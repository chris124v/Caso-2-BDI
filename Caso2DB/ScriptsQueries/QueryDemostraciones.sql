
----Scripts&Queries Demostraciones T SQL ------

use Caso2;

-- Cursor local -----

---Suscripcion Proxima a vencer con un mensaje o notificacion ---

DECLARE @nombreUsuario VARCHAR(250)
DECLARE @email VARCHAR(220)
DECLARE @nombrePlan VARCHAR(100)
DECLARE @fechaVencimiento DATETIME
DECLARE @mensaje VARCHAR(500)

-- Declaramos el cursor local
DECLARE cursor_local_demo CURSOR LOCAL FOR 

SELECT 
    u.Name AS NombreUsuario, 
    u.Email,
    s.Name AS NombrePlan, 
    su.endDateTime AS FechaVencimiento

FROM SocaiSubscriptionUser su
JOIN SocaiUsers u ON su.UserId = u.UserId
JOIN SocaiSubscriptions s ON su.SubscriptionId = s.SubscriptionId

WHERE 
    su.enable = 1 AND 
    su.endDateTime BETWEEN GETDATE() AND DATEADD(DAY, 7, GETDATE());

-- Abrimos el cursor
OPEN cursor_local_demo

-- Obtenemos la primera fila
FETCH NEXT FROM cursor_local_demo INTO @nombreUsuario, @email, @nombrePlan, @fechaVencimiento

-- ahora revisamos propiamente si hay datos
IF @@FETCH_STATUS = 0

BEGIN
    PRINT '===== NOTIFICACIONES DE SUSCRIPCIONES PRÓXIMAS A VENCER ====='
END

ELSE

BEGIN
    PRINT 'No hay suscripciones próximas a vencer en los próximos 7 días.'
END

-- Procesamos cada fila
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Crear mensaje personalizado de recordatorio
    SET @mensaje = 'NOTIFICACIÓN: Estimado/a ' + @nombreUsuario + 
                  ', su suscripción al plan "' + @nombrePlan + 
                  '" vence el ' + CONVERT(VARCHAR, @fechaVencimiento, 103) + 
                  '. Por favor renueve para seguir disfrutando de sus beneficios.';
    
    -- Esta seria una notificacion para verificar que el cursor funciono
    PRINT @mensaje
    
    -- Obtenemos la siguiente fila
    FETCH NEXT FROM cursor_local_demo INTO @nombreUsuario, @email, @nombrePlan, @fechaVencimiento
END

-- Cerramos y liberamos el cursor local 
CLOSE cursor_local_demo
DEALLOCATE cursor_local_demo

---- Cursor Global ----

--- Lista los principales comercios por servicios ofrecidos ---

DECLARE @nombreComercio VARCHAR(225)
DECLARE @serviciosOfrecidos INT
DECLARE @contactoPrincipal VARCHAR(60)

-- Declarar cursor explicitamente como global para ser accesado en otras sesiones
DECLARE cursor_global_demo CURSOR GLOBAL FOR

SELECT 
    c.Name AS NombreComercio,
    COUNT(cf.CommercesFeaturesId) AS ServiciosOfrecidos,
    cp.Name AS ContactoPrincipal
FROM SocaiCommerces c
JOIN SocaiCommercesFeatures cf ON c.CommerceId = cf.CommercesId
LEFT JOIN SocaiCommerceContactPerson cp ON c.CommerceId = cp.CommerceId
WHERE c.IsActive = 1
GROUP BY c.Name, cp.Name
ORDER BY COUNT(cf.CommercesFeaturesId) DESC;

-- Abrir el cursor
OPEN cursor_global_demo

-- Obtenemos la primera fila con fetch
FETCH NEXT FROM cursor_global_demo INTO @nombreComercio, @serviciosOfrecidos, @contactoPrincipal

-- Comprobamos si hay datos
IF @@FETCH_STATUS = 0

BEGIN
    PRINT '===== Comercicos con mas servicios ofrecidos ====='
END

ELSE

BEGIN
    PRINT 'No se encontraron comercios con servicios activos.'
END

-- Procesamos cada fila
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Comercio: ' + @nombreComercio + 
          ' | Servicios: ' + CAST(@serviciosOfrecidos AS VARCHAR) + 
          ' | Contacto: ' + ISNULL(@contactoPrincipal, 'No asignado');
    
    -- Obtenemos la siguiente fila
    FETCH NEXT FROM cursor_global_demo INTO @nombreComercio, @serviciosOfrecidos, @contactoPrincipal
END

-- Cerrar el cursor pero no usamos deallocate esto para demostrar que sigue siendo accesible
CLOSE cursor_global_demo

---DEALLOCATE cursor_global_demo---


--- Trigger, Substring, Ltrim, Coalesce, Top y Distinct ---

--- Aqui una pequena descripcion de que hace cada uno ---

-- Triggerse ejecuta automáticamente tras inserciones en la tabla de pagos
-- SUBSTRING esto para limitar texto
-- LTRIM para limpiar espacios
-- COALESCE esto para manejar nulos 
-- TOP esto para limitar resultados
-- DISTINCT para obtener valores únicos sin duplicados

-- Usando las tablas de  SocaiLogs y SocaiTransactions

-- Creamos el trigger para registrar transacciones de pago en la tabla de logs existente

-- 1. Creación del trigger que demuestra varios conceptos T-SQL
DROP TRIGGER IF EXISTS trg_SocaiPayments_Insert;
GO

CREATE TRIGGER trg_SocaiPayments_Insert
ON SocaiPayments
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Variables para el mensaje de log
    DECLARE @paymentMethod VARCHAR(30)
    DECLARE @logMessage VARCHAR(500)
    DECLARE @transactionId INT
    
    -- TOP: Obtener solo los 5 métodos de pago más utilizados
    DECLARE @topPaymentMethods VARCHAR(200) = '';
    
    -- Versión simplificada que evita el problema de ORDER BY en subconsulta
    SELECT TOP 5 @topPaymentMethods = @topPaymentMethods + pm.name + ', '
    FROM SocaiPaymentMethods pm
    JOIN SocaiPayments p ON pm.PaymentMethodId = p.PaymentMethodId
    GROUP BY pm.name, pm.PaymentMethodId
    ORDER BY COUNT(*) DESC;
    
    -- Quitar la última coma
    IF LEN(@topPaymentMethods) > 0
        SET @topPaymentMethods = LEFT(@topPaymentMethods, LEN(@topPaymentMethods) - 1);
    
    -- Para cada pago, crear transacción y log asociado
    INSERT INTO SocaiTransactions (
        amount,
        description,
        transactionDateTime,
        postTime,
        referenceNumber,
        checksum,
        TransactionTypeId,
        TransactionSubTypeId,
        CurrencyTypeId,
        PaymentId,
        UserId,
        ExchangeRateId
    )
    SELECT 
        COALESCE(i.actualAmount, i.amount, 0),  -- COALESCE: Manejo de valores nulos
        'Transacción generada a partir de pago ID: ' + CAST(i.PaymentId AS VARCHAR),
        GETDATE(),
        GETDATE(),
        LTRIM(i.reference),  -- LTRIM: Eliminar espacios al inicio
        i.checksum,
        0,  -- TransactionTypeId = 0 (Pago)
        0,  -- TransactionSubTypeId = 0 (Tarjeta de Crédito)
        i.CurrencyTypeId,
        i.PaymentId,
        i.UserId,
        1  -- CurrencyExchangeId = 1
    FROM inserted i;
    
    -- Obtener el ID de la transacción recién creada
    SET @transactionId = SCOPE_IDENTITY();
    
    -- Insertar en la tabla de logs
    INSERT INTO SocaiLogs (
        description,
        postTime,
        computer,
        username,
        trace,
        referenceID1,
        referenceID2,
        value1,
        value2,
        checksum,
        lastUpdate,
        LogTypeId,
        LogSourceId,
        LogSeverityId,
        UserId,
        TransactionId
    )
    SELECT 
        -- SUBSTRING: Limitar longitud del mensaje a 200 caracteres
        SUBSTRING(
            'Pago registrado: Usuario ID ' + CAST(i.UserId AS VARCHAR) + 
            ' realizó pago de ' + CAST(COALESCE(i.actualAmount, i.amount, 0) AS VARCHAR) + 
            ' usando ' + (SELECT pm.name FROM SocaiPaymentMethods pm WHERE pm.PaymentMethodId = i.PaymentMethodId),
            1, 200),
        GETDATE(),
        HOST_NAME(),
        SYSTEM_USER,
        'Trigger: trg_SocaiPayments_Insert',
        i.PaymentId,
        @transactionId,
        (SELECT pm.name FROM SocaiPaymentMethods pm WHERE pm.PaymentMethodId = i.PaymentMethodId),
        CAST(COALESCE(i.actualAmount, i.amount, 0) AS VARCHAR),  -- COALESCE: Otra vez
        i.checksum,
        GETDATE(),
        3,  -- LogTypeId = 3 (Transacción)
        0,  -- LogSourceId = 0 (Sistema)
        0,  -- LogSeverityId = 0 (Baja)
        i.UserId,
        @transactionId
    FROM inserted i;
    
    -- Mensaje de depuración
    SET @paymentMethod = (SELECT TOP 1 pm.name FROM SocaiPaymentMethods pm 
                          JOIN inserted i ON pm.PaymentMethodId = i.PaymentMethodId);
                          
    SET @logMessage = 'Trigger ejecutado: Se registró un nuevo pago con método ' + 
                      COALESCE(@paymentMethod, 'Desconocido') + -- COALESCE: Para valor predeterminado
                      ' y se generó la transacción ID: ' + CAST(@transactionId AS VARCHAR);
                      
    PRINT @logMessage;
END;
GO

PRINT 'Trigger trg_SocaiPayments_Insert creado exitosamente';

-- 2. Script para llenar datos de prueba
-- Crear DataPayments para diferentes usuarios
DECLARE @userCount INT;
SELECT @userCount = COUNT(*) FROM SocaiUsers;

-- Solo procesamos hasta 5 usuarios para no crear demasiados registros
DECLARE @usersToProcess INT = CASE WHEN @userCount > 5 THEN 5 ELSE @userCount END;
DECLARE @currentUser INT = 1;
DECLARE @methods TABLE (PaymentMethodId INT);

-- Obtenemos los IDs de métodos de pago existentes
INSERT INTO @methods
SELECT PaymentMethodId FROM SocaiPaymentMethods WHERE enable = 1;

WHILE @currentUser <= @usersToProcess
BEGIN
    -- Para cada usuario, creamos 2-3 métodos de pago diferentes
    DECLARE @methodCursor CURSOR;
    DECLARE @methodId INT;
    
    SET @methodCursor = CURSOR FOR
    SELECT PaymentMethodId FROM @methods
    WHERE PaymentMethodId IN (0, 1, 2, 6, 9) -- Visa, Mastercard, Amex, PayPal, SINPE
    ORDER BY NEWID();
    
    OPEN @methodCursor;
    FETCH NEXT FROM @methodCursor INTO @methodId;
    
    DECLARE @methodCount INT = 0;
    
    WHILE @@FETCH_STATUS = 0 AND @methodCount < 3
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM SocaiDataPayments 
                      WHERE UserId = @currentUser AND PaymentMethodId = @methodId)
        BEGIN
            INSERT INTO SocaiDataPayments (name, token, expToken, maskAccount, UserId, PaymentMethodId)
            VALUES (
                CASE 
                    WHEN @methodId = 0 THEN 'Visa Personal'
                    WHEN @methodId = 1 THEN 'Mastercard Principal'
                    WHEN @methodId = 2 THEN 'American Express Gold'
                    WHEN @methodId = 6 THEN 'Cuenta PayPal'
                    WHEN @methodId = 9 THEN 'SINPE Movil'
                    ELSE 'Método de pago ' + CAST(@methodId AS VARCHAR)
                END, 
                CAST('token_' + CAST(@currentUser AS VARCHAR) + '_' + CAST(@methodId AS VARCHAR) AS VARBINARY(255)), 
                DATEADD(YEAR, 1, GETDATE()), 
                CAST('****' + RIGHT('1000' + CAST((@currentUser * 10 + @methodId) AS VARCHAR), 4) AS VARBINARY(255)), 
                @currentUser, 
                @methodId
            );
            
            PRINT 'DataPayment creado: Usuario ' + CAST(@currentUser AS VARCHAR) + 
                  ', Método ' + CAST(@methodId AS VARCHAR);
            
            SET @methodCount = @methodCount + 1;
        END
        
        FETCH NEXT FROM @methodCursor INTO @methodId;
    END
    
    CLOSE @methodCursor;
    DEALLOCATE @methodCursor;
    
    SET @currentUser = @currentUser + 1;
END

PRINT 'Datos de pago adicionales creados';

-- 3. Insertar múltiples pagos para probar el trigger
DECLARE @paymentsToInsert INT = 15;
DECLARE @paymentCounter INT = 1;
DECLARE @randomUser INT;
DECLARE @randomMethod INT;
DECLARE @dataPaymentId INT;
DECLARE @resultPaymentId INT;
DECLARE @randomAmount INT;

-- Primero verificamos que exista al menos un ResultPaymentId
IF NOT EXISTS (SELECT 1 FROM SocaiResultPayment)
BEGIN
    INSERT INTO SocaiResultPayment (name, description)
    VALUES ('Exitoso', 'Pago procesado exitosamente');
    PRINT 'Resultado de pago creado';
END

SELECT TOP 1 @resultPaymentId = ResultPaymentId FROM SocaiResultPayment;

WHILE @paymentCounter <= @paymentsToInsert
BEGIN
    -- Seleccionar un usuario aleatorio
    SELECT TOP 1 @randomUser = UserId 
    FROM SocaiUsers 
    ORDER BY NEWID();
    
    -- Seleccionar un método de pago aleatorio de los existentes
    SELECT TOP 1 @randomMethod = PaymentMethodId 
    FROM SocaiPaymentMethods 
    WHERE enable = 1 AND PaymentMethodId IN (0, 1, 2, 6, 9) -- Usar métodos populares
    ORDER BY NEWID();
    
    -- Buscar un DataPaymentId para este usuario y método
    SELECT TOP 1 @dataPaymentId = DataPaymentId
    FROM SocaiDataPayments
    WHERE UserId = @randomUser AND PaymentMethodId = @randomMethod;
    
    -- Si no existe, lo creamos
    IF @dataPaymentId IS NULL
    BEGIN
        INSERT INTO SocaiDataPayments (name, token, expToken, maskAccount, UserId, PaymentMethodId)
        VALUES (
            CASE 
                WHEN @randomMethod = 0 THEN 'Visa Personal'
                WHEN @randomMethod = 1 THEN 'Mastercard Principal'
                WHEN @randomMethod = 2 THEN 'American Express Gold'
                WHEN @randomMethod = 6 THEN 'Cuenta PayPal'
                WHEN @randomMethod = 9 THEN 'SINPE Movil'
                ELSE 'Método de pago ' + CAST(@randomMethod AS VARCHAR)
            END, 
            CAST('token_auto_' + CAST(@paymentCounter AS VARCHAR) AS VARBINARY(255)), 
            DATEADD(YEAR, 1, GETDATE()), 
            CAST('****' + RIGHT('1000' + CAST((@randomUser * 10 + @randomMethod) AS VARCHAR), 4) AS VARBINARY(255)), 
            @randomUser, 
            @randomMethod
        );
        
        SET @dataPaymentId = SCOPE_IDENTITY();
        PRINT 'Nuevo DataPayment creado para usuario ' + CAST(@randomUser AS VARCHAR) + 
              ', método ' + CAST(@randomMethod AS VARCHAR);
    END
    
    -- Monto aleatorio entre 10,000 y 100,000
    SET @randomAmount = 10000 + (CAST(RAND() * 90000 AS INT));
    
    -- Insertar el pago - esto activará el trigger
    BEGIN TRY
        INSERT INTO SocaiPayments (
            amount, actualAmount, authentication, reference, chargeToken, date,
            checksum, DataPaymentId, PaymentMethodId, UserId, ResultPaymentId, CurrencyTypeId
        )
        VALUES (
            @randomAmount, 
            @randomAmount, 
            'AUTH' + RIGHT('00000' + CAST(@paymentCounter AS VARCHAR), 5), 
            '   REF-' + CAST(@paymentCounter AS VARCHAR) + '-' + CONVERT(VARCHAR(8), GETDATE(), 112) + '   ', -- Espacios para probar LTRIM 
            CAST('token_pay_' + CAST(@paymentCounter AS VARCHAR) AS VARBINARY(250)), 
            DATEADD(MINUTE, -@paymentCounter * 10, GETDATE()), -- Pagos distribuidos en el tiempo
            CAST('checksum_' + CAST(@paymentCounter AS VARCHAR) AS VARBINARY(250)), 
            @dataPaymentId, 
            @randomMethod, 
            @randomUser, 
            @resultPaymentId, 
            0 -- Usar el CurrencyTypeId 0
        );
        
        PRINT 'Pago #' + CAST(@paymentCounter AS VARCHAR) + ' insertado para usuario ' + CAST(@randomUser AS VARCHAR);
    END TRY
    BEGIN CATCH
        PRINT 'Error al insertar pago #' + CAST(@paymentCounter AS VARCHAR) + ': ' + ERROR_MESSAGE();
    END CATCH
    
    SET @paymentCounter = @paymentCounter + 1;
END

-- 4. Verificar los resultados con consultas que demuestran los conceptos

-- TOP: Ver los últimos 5 logs creados
PRINT '=== TOP: Últimos 5 logs creados ===';
SELECT TOP 5 LogId, description, postTime, value1, value2, UserId, TransactionId
FROM SocaiLogs
ORDER BY postTime DESC;

-- DISTINCT: Ver métodos de pago únicos utilizados en el sistema
PRINT '=== DISTINCT: Métodos de pago únicos utilizados ===';
SELECT DISTINCT pm.name AS 'Método de Pago'
FROM SocaiPayments p
JOIN SocaiPaymentMethods pm ON p.PaymentMethodId = pm.PaymentMethodId
ORDER BY pm.name;

-- TOP y DISTINCT combinados: Mostrar los 3 usuarios con más transacciones
PRINT '=== TOP + DISTINCT: Top 3 usuarios con más transacciones ===';
SELECT TOP 3 u.Name AS 'Usuario', COUNT(DISTINCT t.TransactionId) AS 'Total de Transacciones'
FROM SocaiUsers u
JOIN SocaiTransactions t ON u.UserId = t.UserId
GROUP BY u.UserId, u.Name
ORDER BY COUNT(DISTINCT t.TransactionId) DESC;

-- SUBSTRING: Demostrar texto truncado
PRINT '=== SUBSTRING: Descripción de transacciones truncada ===';
SELECT TransactionId, 
       SUBSTRING(description, 1, 30) + '...' AS 'Descripción Truncada',
       description AS 'Descripción Completa'
FROM SocaiTransactions
ORDER BY TransactionId DESC;

-- LTRIM: Demostrar limpieza de espacios
PRINT '=== LTRIM: Referencias de pago sin espacios iniciales ===';
SELECT p.PaymentId, 
       '|' + p.reference + '|' AS 'Referencia Original',
       '|' + LTRIM(p.reference) + '|' AS 'Referencia sin Espacios Iniciales'
FROM SocaiPayments p
ORDER BY p.PaymentId DESC;

-- COALESCE: Demostrar manejo de valores nulos
PRINT '=== COALESCE: Manejo de valores nulos en montos ===';
SELECT p.PaymentId,
       p.amount AS 'Monto Original',
       p.actualAmount AS 'Monto Actual',
       COALESCE(p.actualAmount, p.amount, 0) AS 'Monto Final (con COALESCE)'
FROM SocaiPayments p
ORDER BY p.PaymentId DESC;

-- Explicación final
PRINT '======================================================';
PRINT 'DEMOSTRACIÓN DE CONCEPTOS TSQL COMPLETADA';
PRINT '1. TRIGGER: Implementado para SocaiPayments';
PRINT '2. SUBSTRING: Utilizado para truncar descripciones';
PRINT '3. LTRIM: Utilizado para limpiar espacios iniciales';
PRINT '4. COALESCE: Utilizado para manejar valores nulos';
PRINT '5. TOP: Utilizado para limitar resultados';
PRINT '6. DISTINCT: Utilizado para obtener valores únicos';
PRINT '======================================================';

--- SP_Recompile, With Encryption, Schemabinding y AVG ---


