--- Query de CREATE VIEW ----

CREATE VIEW dbo.vw_PromedioPagosPorUsuario WITH SCHEMABINDING
AS
SELECT 
    u.UserId,
    u.Name AS NombreUsuario,
    COUNT_BIG(*) AS TotalPagos,
    SUM(ISNULL(p.amount, 0)) AS SumaTotal,
    COUNT_BIG(p.amount) AS ConteoValores,
    SUM(ISNULL(p.amount, 0)) AS MontoTotal
FROM 
    dbo.SocaiUsers u
    INNER JOIN dbo.SocaiPayments p ON u.UserId = p.UserId
GROUP BY 
    u.UserId, 
    u.Name;
GO

CREATE UNIQUE CLUSTERED INDEX IX_vw_PromedioPagosPorUsuario
ON dbo.vw_PromedioPagosPorUsuario(UserId);
GO

-- 2. Procedimiento para recompilar SP periódicamente (WITH ENCRYPTION)
CREATE OR ALTER PROCEDURE dbo.SP_RecompilacionProcedimientos
WITH ENCRYPTION
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Variables para el proceso
    DECLARE @SPName NVARCHAR(255);
    DECLARE @SQL NVARCHAR(500);
    DECLARE @Count INT = 0;
    DECLARE @LogMessage NVARCHAR(500);
    DECLARE @DummyTransactionId INT;
    
    -- Crear una transacción temporal para tener un ID de transacción
    -- Primero necesitamos obtener IDs válidos para las tablas relacionadas
    DECLARE @UserId INT = 1; -- Usar un ID de usuario existente
    DECLARE @PaymentId INT;
    DECLARE @PaymentMethodId INT = 1; -- Usar un ID de método de pago existente
    DECLARE @ResultPaymentId INT = 0; -- Usar un ID de resultado de pago existente
    DECLARE @CurrencyTypeId INT = 0; -- Usar un ID de moneda existente
    DECLARE @DataPaymentId INT;
    
    -- Verificar si existe un DataPaymentId para este usuario y método de pago
    SELECT TOP 1 @DataPaymentId = DataPaymentId 
    FROM SocaiDataPayments 
    WHERE UserId = @UserId AND PaymentMethodId = @PaymentMethodId;
    
    -- Si no existe, usar el primer DataPaymentId disponible
    IF @DataPaymentId IS NULL
    BEGIN
        SELECT TOP 1 @DataPaymentId = DataPaymentId 
        FROM SocaiDataPayments;
    END
    
    -- Crear una transacción temporal para tener un ID de transacción
    BEGIN TRANSACTION;
    
    -- Insertar un registro en SocaiPayments para obtener un PaymentId
    INSERT INTO SocaiPayments (
        amount, actualAmount, authentication, reference, chargeToken, date,
        checksum, DataPaymentId, PaymentMethodId, UserId, ResultPaymentId, CurrencyTypeId
    )
    VALUES (
        1.00, 1.00, 'RECOMPILE_AUTH', 'RECOMPILE_REF', 
        CAST('recompile_token' AS VARBINARY(250)), GETDATE(),
        CAST('recompile_checksum' AS VARBINARY(250)),
        @DataPaymentId, @PaymentMethodId, @UserId, @ResultPaymentId, @CurrencyTypeId
    );
    
    -- Obtener el PaymentId generado
    SET @PaymentId = SCOPE_IDENTITY();
    
    -- Insertar un registro en SocaiTransactions para obtener un TransactionId
    INSERT INTO SocaiTransactions (
        amount, description, transactionDateTime, postTime, referenceNumber,
        checksum, TransactionTypeId, TransactionSubTypeId, CurrencyTypeId,
        PaymentId, UserId, ExchangeRateId
    )
    VALUES (
        1.00, 'Transacción temporal para recompilación', GETDATE(), GETDATE(),
        'RECOMPILE_REF', CAST('recompile_checksum' AS VARBINARY(250)),
        0, 0, @CurrencyTypeId, @PaymentId, @UserId, 1
    );
    
    -- Obtener el TransactionId generado
    SET @DummyTransactionId = SCOPE_IDENTITY();
    
    -- Cursor para recorrer todos los procedimientos almacenados
    DECLARE SP_Cursor CURSOR FOR
        SELECT SCHEMA_NAME(schema_id) + '.' + name
        FROM sys.procedures
        WHERE is_ms_shipped = 0;
    
    OPEN SP_Cursor;
    FETCH NEXT FROM SP_Cursor INTO @SPName;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Ejecutar sp_recompile para el procedimiento actual
        BEGIN TRY
            SET @SQL = 'EXEC sp_recompile ''' + @SPName + '''';
            EXEC (@SQL);
            
            -- Registrar en SocaiLogs (tabla existente)
            SET @LogMessage = 'Procedimiento recompilado: ' + @SPName;
            
            INSERT INTO SocaiLogs (
                description, postTime, computer, username, trace, 
                LogTypeId, LogSourceId, LogSeverityId, UserId, TransactionId
            )
            VALUES (
                @LogMessage, GETDATE(), HOST_NAME(), SYSTEM_USER, 'SP_RecompilacionProcedimientos',
                3, 0, 0, @UserId, @DummyTransactionId
            );
            
            PRINT 'Object ''' + @SPName + ''' was successfully marked for recompilation.';
        END TRY
        BEGIN CATCH
            PRINT 'Error al recompilar ' + @SPName + ': ' + ERROR_MESSAGE();
        END CATCH
        
        SET @Count = @Count + 1;
        FETCH NEXT FROM SP_Cursor INTO @SPName;
    END

    CLOSE SP_Cursor;
    DEALLOCATE SP_Cursor;
    
    -- Registrar resumen en SocaiLogs
    SET @LogMessage = 'Recompilación completada. ' + CAST(@Count AS VARCHAR) + ' procedimientos recompilados.';
    
    INSERT INTO SocaiLogs (
        description, postTime, computer, username, trace, 
        LogTypeId, LogSourceId, LogSeverityId, UserId, TransactionId
    )
    VALUES (
        @LogMessage, GETDATE(), HOST_NAME(), SYSTEM_USER, 'SP_RecompilacionProcedimientos',
        3, 0, 0, @UserId, @DummyTransactionId
    );
    
    -- Finalizar la transacción
    COMMIT TRANSACTION;
    
    -- Mostrar estadísticas de pagos usando la vista con SCHEMABINDING
    SELECT TOP 5 
        NombreUsuario,
        TotalPagos,
        CASE 
            WHEN ConteoValores > 0 THEN SumaTotal / CAST(ConteoValores AS DECIMAL(18,2))
            ELSE 0 
        END AS MontoPagoPromedio,
        MontoTotal
    FROM dbo.vw_PromedioPagosPorUsuario
    ORDER BY MontoTotal DESC;
    
    PRINT @LogMessage;
END;
GO

-- 3. Ejecutar la recompilación para probar
EXEC dbo.SP_RecompilacionProcedimientos;
GO

-- 4. Demostrar la imposibilidad de ver el código de un SP encriptado
PRINT 'Intentando ver el código del procedimiento encriptado:';
SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.SP_RecompilacionProcedimientos')) AS CodigoEncriptado;
GO

-- 5. Demostrar SCHEMABINDING - Intentar modificar una tabla base (esto debería fallar)
PRINT 'Intentando modificar una columna en tabla referenciada por vista con SCHEMABINDING:';
BEGIN TRY
    ALTER TABLE dbo.SocaiUsers DROP COLUMN Name;
    PRINT 'La modificación fue exitosa (esto no debería verse)';
END TRY
BEGIN CATCH
    PRINT 'Error al modificar: ' + ERROR_MESSAGE();
    PRINT 'La modificación falló debido a SCHEMABINDING (comportamiento correcto)';
END CATCH;
GO

-- 6. Demostrar UNION con planes de suscripción
PRINT 'Demostración de UNION para combinar tipos de planes:';
-- Planes individuales (asumimos ID < 5)
SELECT 
    'Individual' AS TipoSuscripcion,
    SubscriptionId,
    Name AS NombrePlan,
    amount AS Precio
FROM SocaiSubscriptions
WHERE SubscriptionId < 5

UNION

-- Planes empresariales (asumimos ID >= 5)
SELECT 
    'Empresarial' AS TipoSuscripcion,
    SubscriptionId,
    Name AS NombrePlan,
    amount AS Precio
FROM SocaiSubscriptions
WHERE SubscriptionId >= 5
ORDER BY TipoSuscripcion, Precio DESC;
GO

-- 7. Demostrar MERGE para sincronizar datos entre tablas existentes
-- En este caso, usamos SocaiPaymentMethods para actualizar la tabla SocaiDataPayments
PRINT 'Demostración de MERGE para sincronización de datos:';

BEGIN TRANSACTION;

-- Mostrar datos antes del MERGE
SELECT 'Antes de MERGE - SocaiDataPayments' AS Estado, 
       dp.DataPaymentId, dp.name, dp.UserId, dp.PaymentMethodId
FROM SocaiDataPayments dp
JOIN SocaiUsers u ON dp.UserId = u.UserId
ORDER BY dp.DataPaymentId;

-- Ejecutar MERGE para actualizar nombres de métodos de pago en DataPayments
-- basado en la tabla SocaiPaymentMethods
MERGE SocaiDataPayments AS destino
USING (
    SELECT dp.DataPaymentId, dp.UserId, dp.PaymentMethodId, 
           pm.name AS PaymentMethodName
    FROM SocaiDataPayments dp
    JOIN SocaiPaymentMethods pm ON dp.PaymentMethodId = pm.PaymentMethodId
) AS origen
ON destino.DataPaymentId = origen.DataPaymentId
WHEN MATCHED THEN
    UPDATE SET 
        destino.name = origen.PaymentMethodName + ' - ' + CAST(origen.UserId AS VARCHAR);

-- Mostrar datos después del MERGE
SELECT 'Después de MERGE - SocaiDataPayments' AS Estado, 
       dp.DataPaymentId, dp.name, dp.UserId, dp.PaymentMethodId
FROM SocaiDataPayments dp
JOIN SocaiUsers u ON dp.UserId = u.UserId
ORDER BY dp.DataPaymentId;

-- Revertir los cambios para no afectar la base de datos
ROLLBACK TRANSACTION;
GO

-- 8. Mostrar AVG con agrupamiento directamente desde las tablas
PRINT 'Demostración de AVG con agrupamiento:';
SELECT 
    u.Name AS NombreUsuario,
    COUNT(*) AS TotalPagos,
    AVG(p.amount) AS MontoPagoPromedio,
    SUM(p.amount) AS MontoTotal
FROM 
    SocaiUsers u
    INNER JOIN SocaiPayments p ON u.UserId = p.UserId
GROUP BY 
    u.UserId, u.Name
ORDER BY 
    MontoTotal DESC;
GO


--- Execute As ----

-- Crear usuario con permisos limitados
CREATE USER UsuarioLectura WITHOUT LOGIN;
GO

-- Otorgar permisos de solo lectura
GRANT SELECT ON SocaiSubscriptions TO UsuarioLectura;
DENY UPDATE ON SocaiSubscriptions TO UsuarioLectura;
-- Conceder permiso para ejecutar el procedimiento
GRANT EXECUTE ON SP_ActualizarPrecios TO UsuarioLectura;
GO

-- Crear procedimiento con impersonificación
CREATE PROCEDURE SP_ActualizarPrecios
    @Porcentaje DECIMAL(5,2)
WITH EXECUTE AS 'dbo'  -- Usando WITH EXECUTE AS
AS
BEGIN
    -- Esta actualización funcionará aunque el usuario que llame
    -- al procedimiento no tenga permisos de actualización
    UPDATE SocaiSubscriptions 
    SET amount = amount * (1 + (@Porcentaje/100));
    
    PRINT 'Precios actualizados por usuario: ' + CAST(CURRENT_USER AS VARCHAR(50));
END;
GO

-- Demostrar que funciona
EXECUTE AS USER = 'UsuarioLectura';
GO
EXEC SP_ActualizarPrecios @Porcentaje = 5.0;
GO
REVERT;  -- Regresar al contexto original
GO

