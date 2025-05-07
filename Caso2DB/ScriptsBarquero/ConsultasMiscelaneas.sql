USE [Caso2]
GO
-- 1. Vista indexada con al menos 4 tablas
CREATE OR ALTER VIEW dbo.vwResumenUsuarios
WITH SCHEMABINDING
AS
SELECT 
    u.UserId AS idUsuario,
    u.Name AS NombreUsuario,
    su.SubscriptionUserId AS idSuscripcion,
    su.startDateTime AS fechaInicio,
    su.endDateTime AS fechaFin,
    p.PaymentId AS idPago,
    p.amount AS monto,
    p.date AS fechaPago,
    fs.FeaturesSubscriptionsId AS idServicio,
    pf.Name AS NombreServicio
FROM dbo.SocaiUsers u
INNER JOIN dbo.SocaiSubscriptionUser su ON u.UserId = su.UserId
INNER JOIN dbo.SocaiPayments p ON p.UserId = u.UserId 
INNER JOIN dbo.SocaiFeaturesSubscriptions fs ON su.SubscriptionId = fs.SubscriptionId
INNER JOIN dbo.SocaiPlanFeatures pf ON fs.PlanFeatureId = pf.FeatureId;
GO

CREATE UNIQUE CLUSTERED INDEX IX_ResumenUsuarios
ON dbo.vwResumenUsuarios (idUsuario, idSuscripcion, idPago, idServicio);
GO

-- 2. Procedimiento almacenado transaccional que modifica al menos 3 tablas 
CREATE OR ALTER PROCEDURE spRegistrarSuscripcion
    @idUsuario INT,
    @idServicio INT,
    @fechaInicio DATE,
    @fechaFin DATE,
    @monto DECIMAL(10, 2),
    @fechaPago DATE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
    DECLARE @Message VARCHAR(200)
    DECLARE @InicieTransaccion BIT = 0
    
    IF @@TRANCOUNT = 0 BEGIN
        SET @InicieTransaccion = 1
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED
        BEGIN TRANSACTION
    END
    
    BEGIN TRY
        SET @CustomError = 2001

   
        INSERT INTO dbo.SocaiSubscriptionUser (enable, startDateTime, endDateTime, UserId, SubscriptionId)
        VALUES (1, @fechaInicio, @fechaFin, @idUsuario, @idServicio);
        
        DECLARE @idSuscripcion INT = SCOPE_IDENTITY();
  
        DECLARE @PaymentMethodId INT = (SELECT TOP 1 PaymentMethodId FROM dbo.SocaiPaymentMethods WHERE enable = 1);
        DECLARE @CurrencyTypeId INT = (SELECT TOP 1 CurrencyTypeId FROM dbo.SocaiCurrencyTypes WHERE acronym = 'CRC');
        DECLARE @ResultPaymentId INT = (SELECT TOP 1 ResultPaymentId FROM dbo.SocaiResultPayment WHERE name = 'Completado');
        
        INSERT INTO dbo.SocaiPayments (amount, actualAmount, date, DataPaymentId, PaymentMethodId, UserId, ResultPaymentId, CurrencyTypeId)
        VALUES (@monto, @monto, @fechaPago, 1, @PaymentMethodId, @idUsuario, @ResultPaymentId, @CurrencyTypeId);
        
        DECLARE @idPago INT = SCOPE_IDENTITY();
        
        INSERT INTO dbo.SocaiTransactions (amount, description, transactionDateTime, postTime, referenceNumber,
                                          TransactionTypeId, TransactionSubTypeId, CurrencyTypeId, PaymentId, UserId, ExchangeRateId)
        VALUES (@monto, 'Pago por suscripción a servicio', GETDATE(), GETDATE(), NEWID(),
                1, 1, @CurrencyTypeId, @idPago, @idUsuario, 1);
        
        
        UPDATE dbo.SocaiFeaturesSubscriptions
        SET Quantity = COALESCE(Quantity, 0) + 1,
            UpdatedAt = GETDATE()
        WHERE FeaturesSubscriptionsId = @idServicio;
        
        IF @InicieTransaccion = 1 BEGIN
            COMMIT TRANSACTION
        END
        
        SELECT 'Éxito' AS Resultado, @idSuscripcion AS idSuscripcion, @idPago AS idPago;
    END TRY
    BEGIN CATCH
        SET @ErrorNumber = ERROR_NUMBER()
        SET @ErrorSeverity = ERROR_SEVERITY()
        SET @ErrorState = ERROR_STATE()
        SET @Message = ERROR_MESSAGE()
        
        IF @InicieTransaccion = 1 BEGIN
            ROLLBACK TRANSACTION
        END
        
        INSERT INTO dbo.SocaiLogs (description, postTime, computer, username, trace, 
                                  LogTypeId, LogSourceId, LogSeverityId, UserId, TransactionId)
        VALUES ('Error al registrar suscripción: ' + @Message, GETDATE(), 
                HOST_NAME(), SYSTEM_USER, 'spRegistrarSuscripcion', 3, 1, 3, @idUsuario, NULL);
        
        SELECT 'Error' AS Resultado, @Message AS MensajeError;
    END CATCH
END;
GO

-- 3. SELECT con CASE para agrupar datos dinámicamente
CREATE OR ALTER PROCEDURE sp_ClasificacionUsuarios
AS
BEGIN
    SELECT 
        u.UserId AS idUsuario,
        u.Name AS nombre,
        COUNT(p.PaymentId) AS CantidadPagos,
        CASE 
            WHEN COUNT(p.PaymentId) = 0 THEN 'Nuevo'
            WHEN COUNT(p.PaymentId) BETWEEN 1 AND 3 THEN 'Ocasional'
            ELSE 'Frecuente'
        END AS ClasificacionUsuario
    FROM dbo.SocaiUsers u
    LEFT JOIN dbo.SocaiSubscriptionUser su ON u.UserId = su.UserId
    LEFT JOIN dbo.SocaiPayments p ON su.SubscriptionUserId = p.UserId
    GROUP BY u.UserId, u.Name;
END;
GO

-- 4. Consulta compleja (4 JOINs, 2 funciones agregadas, 3 CTEs, etc.)
CREATE OR ALTER PROCEDURE sp_ObtenerReporteAnalisisUsuarios
AS
BEGIN
    SET NOCOUNT ON;
    
    
    WITH UsuariosSuscripciones AS (
        --CTE 1
        SELECT 
            u.UserId,
            u.Name,
            u.Email,
            u.PhoneNumber,
            u.CreatedAt AS FechaRegistro,
            su.SubscriptionUserId,
            su.startDateTime,
            su.endDateTime,
            su.enable,
            s.SubscriptionId,
            s.Name AS PlanName,
            s.amount AS PlanCost,
            c.acronym AS Currency,
            DATEDIFF(DAY, GETDATE(), su.endDateTime) AS DiasRestantes
        FROM dbo.SocaiUsers u
        INNER JOIN dbo.SocaiSubscriptionUser su ON u.UserId = su.UserId
        INNER JOIN dbo.SocaiSubscriptions s ON su.SubscriptionId = s.SubscriptionId
        INNER JOIN dbo.SocaiCurrencyTypes c ON s.CurrencyTypeId = c.CurrencyTypeId
    ),
    PagosUsuario AS (
       --CTE 2
        SELECT 
            u.UserId,
            COUNT(p.PaymentId) AS TotalPagos,
            SUM(p.amount) AS MontoTotal,
            AVG(p.amount) AS PromedioGasto,
            MAX(p.date) AS UltimoPago
        FROM dbo.SocaiUsers u
        LEFT JOIN dbo.SocaiPayments p ON u.UserId = p.UserId
        GROUP BY u.UserId
    ),
    ServiciosUtilizados AS (
        --CTE 3
        SELECT 
            su.UserId,
            COUNT(fs.FeaturesSubscriptionsId) AS TotalServicios,
            STRING_AGG(pf.Name, ', ') AS Servicios
        FROM dbo.SocaiSubscriptionUser su
        INNER JOIN dbo.SocaiFeaturesSubscriptions fs ON su.SubscriptionId = fs.SubscriptionId
        INNER JOIN dbo.SocaiPlanFeatures pf ON fs.PlanFeatureId = pf.FeatureId
        GROUP BY su.UserId
    )
    
    -- Consulta principal 
    SELECT 
        us.UserId,
        us.Name AS NombreUsuario,
        us.Email,
        CONVERT(VARCHAR(10), us.FechaRegistro, 103) AS FechaRegistroFormateada,
        us.PlanName AS NombrePlan,
        CONCAT(us.PlanCost, ' ', us.Currency) AS CostoPlan,
        pu.TotalPagos,
        pu.MontoTotal,
        pu.PromedioGasto,
        CONVERT(VARCHAR(10), pu.UltimoPago, 103) AS UltimoPagoFormateado,
        su.TotalServicios,
        su.Servicios,
        us.DiasRestantes,
        CASE 
            WHEN us.DiasRestantes < 0 THEN 'Vencido'
            WHEN us.DiasRestantes BETWEEN 0 AND 7 THEN 'Vence esta semana'
            WHEN us.DiasRestantes BETWEEN 8 AND 30 THEN 'Vence este mes'
            ELSE 'Vigente'
        END AS EstadoSuscripcion,
        CASE
            WHEN pu.TotalPagos = 0 THEN 'Sin pagos'
            WHEN pu.TotalPagos = 1 THEN 'Primer pago'
            WHEN pu.TotalPagos BETWEEN 2 AND 5 THEN 'Cliente regular'
            ELSE 'Cliente frecuente'
        END AS CategoriaCliente
    FROM UsuariosSuscripciones us
    LEFT JOIN PagosUsuario pu ON us.UserId = pu.UserId
    LEFT JOIN ServiciosUtilizados su ON us.UserId = su.UserId
    WHERE 
        us.enable = 1
        AND EXISTS (
            SELECT 1 
            FROM dbo.SocaiBalances b 
            WHERE b.SubscriptionUserId = us.SubscriptionUserId
        )
        AND us.PlanCost IN (
            SELECT DISTINCT amount 
            FROM dbo.SocaiSubscriptions 
            WHERE isActive = 1
        )
        AND us.UserId NOT IN (
            SELECT l.UserId 
            FROM dbo.SocaiLogs l 
            WHERE l.LogTypeId = 3  -- Suponiendo que LogTypeId 3 es para errores
            AND l.postTime > DATEADD(DAY, -30, GETDATE())
        )
    HAVING 
        pu.TotalPagos > 0
    ORDER BY 
        us.DiasRestantes ASC,
        pu.MontoTotal DESC;
END;
GO

-- 5. Consulta con INTERSECTION y SET DIFFERENCE
CREATE OR ALTER PROCEDURE sp_AnalisisUsuariosInterseccionDiferencia
AS
BEGIN
    -- INTERSECCIÓN: Usuarios con suscripción y al menos un pago registrado
    SELECT DISTINCT u.UserId AS idUsuario, u.Name AS nombre
    FROM dbo.SocaiUsers u
    INNER JOIN dbo.SocaiSubscriptionUser su ON u.UserId = su.UserId
    INNER JOIN dbo.SocaiPayments p ON su.SubscriptionUserId = p.UserId

    INTERSECT

    SELECT DISTINCT u.UserId AS idUsuario, u.Name AS nombre
    FROM dbo.SocaiUsers u
    INNER JOIN dbo.SocaiSubscriptionUser su ON u.UserId = su.UserId
    INNER JOIN dbo.SocaiFeaturesSubscriptions fs ON su.SubscriptionUserId = fs.SubscriptionId
    WHERE su.enable = 1;

    -- DIFERENCIA: Usuarios con suscripción pero sin ningún pago
    SELECT DISTINCT u.UserId AS idUsuario, u.Name AS nombre
    FROM dbo.SocaiUsers u
    INNER JOIN dbo.SocaiSubscriptionUser su ON u.UserId = su.UserId

    EXCEPT

    SELECT DISTINCT u.UserId AS idUsuario, u.Name AS nombre
    FROM dbo.SocaiUsers u
    INNER JOIN dbo.SocaiSubscriptionUser su ON u.UserId = su.UserId
    INNER JOIN dbo.SocaiPayments p ON su.SubscriptionUserId = p.UserId;
END;
GO

-- 6. Procedimiento almacenado transaccional anidado 
CREATE OR ALTER PROCEDURE sp_actualizarPagosYServicios
    @idServicio INT,
    @idSuscripcion INT,
    @nuevoMonto DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN

        
        UPDATE dbo.SocaiFeaturesSubscriptions
        SET Quantity = COALESCE(Quantity, 0) + 1,
            MemberCount = COALESCE(MemberCount, 1),
            UpdatedAt = GETDATE()
        WHERE FeaturesSubscriptionsId = @idServicio;

        DECLARE @PaymentMethodId INT = (SELECT TOP 1 PaymentMethodId FROM dbo.SocaiPaymentMethods WHERE enable = 1);
        DECLARE @CurrencyTypeId INT = (SELECT TOP 1 CurrencyTypeId FROM dbo.SocaiCurrencyTypes WHERE acronym = 'CRC');
        DECLARE @ResultPaymentId INT = (SELECT TOP 1 ResultPaymentId FROM dbo.SocaiResultPayment WHERE name = 'Completado');
        
        DECLARE @UserId INT = (SELECT UserId FROM dbo.SocaiSubscriptionUser WHERE SubscriptionUserId = @idSuscripcion);
        
      
        SET @UserId = ISNULL(@UserId, 1);
        
        INSERT INTO dbo.SocaiPayments (amount, actualAmount, date, DataPaymentId, PaymentMethodId, UserId, ResultPaymentId, CurrencyTypeId)
        VALUES (@nuevoMonto, @nuevoMonto, GETDATE(), 1, @PaymentMethodId, @UserId, @ResultPaymentId, @CurrencyTypeId);

        COMMIT
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK
        THROW
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_actualizarUsuarioYSuscripcion
    @idUsuario INT,
    @nuevoNombre NVARCHAR(100),
    @idSuscripcion INT,
    @idServicio INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN

        UPDATE dbo.SocaiUsers
        SET Name = @nuevoNombre
        WHERE UserId = @idUsuario;

        UPDATE dbo.SocaiSubscriptionUser
        SET startDateTime = GETDATE()
        WHERE SubscriptionUserId = @idSuscripcion;

        EXEC sp_actualizarPagosYServicios @idServicio, @idSuscripcion, 5000;

        COMMIT
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK
        THROW
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_procesoCompleto
    @idUsuario INT,
    @nuevoNombre NVARCHAR(100),
    @idSuscripcion INT,
    @idServicio INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN
        EXEC sp_actualizarUsuarioYSuscripcion @idUsuario, @nuevoNombre, @idSuscripcion, @idServicio;
        COMMIT
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK
        THROW
    END CATCH
END
GO

-- 7. Consulta que retorna JSON
CREATE OR ALTER PROCEDURE sp_ObtenerDetalleSubscripcionJSON
    @UserId INT
AS
BEGIN
    SELECT 
        u.UserId AS idUsuario,
        u.Name AS nombreUsuario,
        su.SubscriptionUserId AS idSuscripcion,
        pf.Name AS nombreServicio,
        s.amount AS precioPlan,
        (
            SELECT 
                SUM(p.amount) AS totalPagado,
                MAX(p.date) AS ultimaFechaPago
            FROM dbo.SocaiPayments p
            WHERE p.UserId = u.UserId
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        ) AS detallesPago
    FROM dbo.SocaiUsers u
    INNER JOIN dbo.SocaiSubscriptionUser su ON u.UserId = su.UserId
    INNER JOIN dbo.SocaiFeaturesSubscriptions fs ON su.SubscriptionId = fs.SubscriptionId
    INNER JOIN dbo.SocaiPlanFeatures pf ON fs.PlanFeatureId = pf.FeatureId
    INNER JOIN dbo.SocaiSubscriptions s ON fs.SubscriptionId = s.SubscriptionId
    WHERE u.UserId = @UserId
    FOR JSON PATH, ROOT('suscripcionesUsuario');
END;
GO

-- 8. SP con Table-Valued Parameter
CREATE TYPE dbo.ContractConditionsType AS TABLE (
    CommercesFeaturesId INT NULL,
    PlanFeaturesId INT NOT NULL,
    IsActive BIT NOT NULL,
    ValidFrom DATETIME NOT NULL,
    ValidTo DATETIME NOT NULL,
    OriginalPrice DECIMAL(18, 2) NOT NULL,
    NegotiatedPrice DECIMAL(18, 2) NOT NULL,
    ServiceTypeId INT NOT NULL,
    IsGuaranteedRight BIT NOT NULL,
    DiscountType CHAR(1) NOT NULL,
    DiscountValue DECIMAL(18, 2) NOT NULL,
    SolturaMargin DECIMAL(18, 2) NOT NULL,
    IsMarginPercentage BIT NOT NULL,
    InlcudesTax BIT NOT NULL,
    TaxRateId INT NOT NULL,
    MinQuantity DECIMAL(18, 2) NULL,
    MaxQuantity DECIMAL(18, 2) NULL,
    TermsAndConditions VARCHAR(500) NULL,
    AdditionalBenefits VARCHAR(500) NULL,
    IsCombined BIT NOT NULL
);
GO

CREATE OR ALTER PROCEDURE sp_UpdateServiceContracts
    @CommerceId INT,
    @CommerceName VARCHAR(225) = NULL,
    @CommerceDescription VARCHAR(250) = NULL,
    @CommerceAddressId INT = NULL,
    @CommercePhoneNumber VARCHAR(20) = NULL,
    @CommerceEmail VARCHAR(200) = NULL,
    @ContractCommercesId INT = NULL,
    @ValidFrom DATETIME = NULL,
    @ValidTo DATETIME = NULL,
    @ContractType VARCHAR(50) = NULL,
    @ContractDescription VARCHAR(150) = NULL,
    @InChargeSignature VARCHAR(100) = NULL,
    @FileId INT = NULL,
    @CountryId INT = NULL,
    @ContractConditions dbo.ContractConditionsType READONLY
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @NewCommerceId INT;
    DECLARE @NewContractId INT;
    DECLARE @ErrorMsg NVARCHAR(4000);
    DECLARE @ErrorState INT;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
       
        IF EXISTS (SELECT 1 FROM SocaiCommerces WHERE CommerceId = @CommerceId)
        BEGIN
            
            UPDATE SocaiCommerces
            SET 
                Name = ISNULL(@CommerceName, Name),
                Description = ISNULL(@CommerceDescription, Description),
                AddressId = ISNULL(@CommerceAddressId, AddressId),
                PhoneNumber = ISNULL(@CommercePhoneNumber, PhoneNumber),
                Email = ISNULL(@CommerceEmail, Email),
                UpdatedAt = GETDATE()
            WHERE CommerceId = @CommerceId;
            
            SET @NewCommerceId = @CommerceId;
        END
        ELSE
        BEGIN
           
            INSERT INTO SocaiCommerces (
                Name, 
                Description, 
                AddressId, 
                PhoneNumber, 
                Email, 
                FileId, 
                IsActive, 
                CreatedAt, 
                UpdatedAt
            )
            VALUES (
                @CommerceName,
                @CommerceDescription,
                @CommerceAddressId,
                @CommercePhoneNumber,
                @CommerceEmail,
                @FileId,
                1, 
                GETDATE(),
                GETDATE()
            );
            
            SET @NewCommerceId = SCOPE_IDENTITY();
        END;
        
       
        IF @ContractCommercesId IS NOT NULL AND EXISTS (SELECT 1 FROM SocaiContractCommerces WHERE ContractCommercesId = @ContractCommercesId)
        BEGIN
           
            UPDATE SocaiContractCommerces
            SET 
                validFrom = ISNULL(@ValidFrom, validFrom),
                validTo = ISNULL(@ValidTo, validTo),
                contractType = ISNULL(@ContractType, contractType),
                contractDescription = ISNULL(@ContractDescription, contractDescription),
                inChargeSignature = ISNULL(@InChargeSignature, inChargeSignature),
                FileId = ISNULL(@FileId, FileId),
                CountryId = ISNULL(@CountryId, CountryId)
            WHERE ContractCommercesId = @ContractCommercesId;
            
            SET @NewContractId = @ContractCommercesId;
        END
        ELSE
        BEGIN
           
            INSERT INTO SocaiContractCommerces (
                validFrom,
                validTo,
                contractType,
                contractDescription,
                isActive,
                CommerceId,
                inChargeSignature,
                FileId,
                CountryId
            )
            VALUES (
                @ValidFrom,
                @ValidTo,
                @ContractType,
                @ContractDescription,
                1, 
                @NewCommerceId,
                @InChargeSignature,
                @FileId,
                @CountryId
            );
            
            SET @NewContractId = SCOPE_IDENTITY();
        END;
        
      
        MERGE SocaiCommercesFeatures AS target
        USING (
            SELECT 
                cc.CommercesFeaturesId,
                @NewCommerceId AS CommercesId,
                cc.PlanFeaturesId,
                cc.IsActive,
                cc.ValidFrom,
                cc.ValidTo,
                cc.OriginalPrice,
                cc.NegotiatedPrice,
                cc.ServiceTypeId,
                cc.IsGuaranteedRight,
                cc.DiscountType,
                cc.DiscountValue,
                cc.SolturaMargin,
                cc.IsMarginPercentage,
                cc.InlcudesTax,
                cc.TaxRateId,
                cc.MinQuantity,
                cc.MaxQuantity,
                cc.TermsAndConditions,
                cc.AdditionalBenefits,
                cc.IsCombined,
                @NewContractId AS ContractCommercesId
            FROM @ContractConditions cc
        ) AS source
        ON (target.CommercesFeaturesId = source.CommercesFeaturesId AND source.CommercesFeaturesId IS NOT NULL)
        WHEN MATCHED THEN
            UPDATE SET
                target.IsActive = source.IsActive,
                target.ValidFrom = source.ValidFrom,
                target.ValidTo = source.ValidTo,
                target.OriginalPrice = source.OriginalPrice,
                target.NegotiatedPrice = source.NegotiatedPrice,
                target.ServiceTypeId = source.ServiceTypeId,
                target.IsGuaranteedRight = source.IsGuaranteedRight,
                target.DiscountType = source.DiscountType,
                target.DiscountValue = source.DiscountValue,
                target.SolturaMargin = source.SolturaMargin,
                target.IsMarginPercentage = source.IsMarginPercentage,
                target.InlcudesTax = source.InlcudesTax,
                target.TaxRateId = source.TaxRateId,
                target.MinQuantity = source.MinQuantity,
                target.MaxQuantity = source.MaxQuantity,
                target.TermsAndConditions = source.TermsAndConditions,
                target.AdditionalBenefits = source.AdditionalBenefits,
                target.IsCombined = source.IsCombined,
                target.UpdatedAt = GETDATE()
        WHEN NOT MATCHED THEN
            INSERT (
                CommercesId, PlanFeaturesId, IsActive, ValidFrom, ValidTo, CreatedAt, UpdatedAt,
                OriginalPrice, NegotiatedPrice, ServiceTypeId, IsGuaranteedRight, DiscountType,
                DiscountValue, SolturaMargin, IsMarginPercentage, InlcudesTax, TaxRateId,
                MinQuantity, MaxQuantity, TermsAndConditions, AdditionalBenefits, IsCombined, ContractCommercesId
            )
            VALUES (
                source.CommercesId, source.PlanFeaturesId, source.IsActive, source.ValidFrom, source.ValidTo, GETDATE(), GETDATE(),
                source.OriginalPrice, source.NegotiatedPrice, source.ServiceTypeId, source.IsGuaranteedRight, source.DiscountType,
                source.DiscountValue, source.SolturaMargin, source.IsMarginPercentage, source.InlcudesTax, source.TaxRateId,
                source.MinQuantity, source.MaxQuantity, source.TermsAndConditions, source.AdditionalBenefits, source.IsCombined, source.ContractCommercesId
            );
        
        COMMIT TRANSACTION;
        
        SELECT 
            @NewCommerceId AS CommerceId,
            @NewContractId AS ContractCommercesId,
            'Success' AS Status,
            (SELECT COUNT(*) FROM @ContractConditions) AS TotalConditions,
            @@ROWCOUNT AS AffectedConditions;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
       
        INSERT INTO dbo.SocaiLogs (
            description, 
            postTime, 
            computer, 
            username, 
            trace, 
            LogTypeId, 
            LogSourceId, 
            LogSeverityId, 
            UserId,
            TransactionId
        )
        VALUES (
            'Error en actualización de contratos: ' + ERROR_MESSAGE(),
            GETDATE(),
            HOST_NAME(),
            SYSTEM_USER,
            'Error en línea: ' + CAST(ERROR_LINE() AS VARCHAR),
            3, -- Error
            2, -- Contratos
            3, -- Alta
            1, -- Admin
            NULL
        );
        
        
        SET @ErrorMsg = ERROR_MESSAGE();
        SET @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, 16, @ErrorState);
    END CATCH;
END;
GO

-- 9. SELECT que genera un archivo CSV
CREATE OR ALTER PROCEDURE sp_GenerateSubscriptionsCSV
    @FilePath VARCHAR(500) = 'C:\Exports\subscription_report.csv'
AS
BEGIN
    SET NOCOUNT ON;
    
    
    DECLARE @BCPCommand NVARCHAR(4000);
    DECLARE @SQLQuery NVARCHAR(4000);
    
    -- Crear la consulta SQL que generará los datos
    SET @SQLQuery = '
    SELECT 
        u.UserId,
        u.Name AS UserName,
        u.Email,
        u.PhoneNumber,
        s.SubscriptionId,
        s.Name AS PlanName,
        s.Description AS PlanDescription,
        su.startDateTime,
        su.endDateTime,
        s.amount AS PlanCost,
        c.acronym AS Currency,
        ''="'' + CONVERT(VARCHAR(20), su.startDateTime, 120) + ''"'' AS FormattedStartDate,
        ''="'' + CONVERT(VARCHAR(20), su.endDateTime, 120) + ''"'' AS FormattedEndDate
    FROM SocaiUsers u
    JOIN SocaiSubscriptionUser su ON u.UserId = su.UserId
    JOIN SocaiSubscriptions s ON su.SubscriptionId = s.SubscriptionId
    JOIN SocaiCurrencyTypes c ON s.CurrencyTypeId = c.CurrencyTypeId
    WHERE u.isActive = 1 AND su.enable = 1
    ORDER BY u.UserId, su.startDateTime DESC';
    
    -- Construir el comando BCP
    SET @BCPCommand = 'bcp "' + @SQLQuery + '" queryout "' + @FilePath + 
                      '" -c -t, -S ' + @@SERVERNAME + ' -T -C ACP';
    
    -- Ejecutar el comando
    EXEC master..xp_cmdshell @BCPCommand;
    
    -- Verificar si el archivo se generó correctamente
    IF @@ERROR = 0
        SELECT 'CSV file generated successfully at: ' + @FilePath AS Result;
    ELSE
        SELECT 'Error generating CSV file' AS Result;
END;
GO

-- 10. Configuración de tabla de bitácora en otro servidor SQL Server
--  Configuración del Linked Server (ejecutar en el servidor principal)

USE [master]
GO

EXEC master.dbo.sp_addlinkedserver 
    @server = N'CENTRAL_LOG_SERVER', 
    @srvproduct = N'',
    @provider = N'SQLOLEDB', 
    @datasrc = N'localhost';
GO


EXEC master.dbo.sp_addlinkedsrvlogin 
    @rmtsrvname = N'CENTRAL_LOG_SERVER',
    @useself = N'TRUE';
GO


EXEC master.dbo.sp_serveroption 
    @server = N'CENTRAL_LOG_SERVER', 
    @optname = N'rpc', 
    @optvalue = N'true'
GO

EXEC master.dbo.sp_serveroption 
    @server = N'CENTRAL_LOG_SERVER', 
    @optname = N'rpc out', 
    @optvalue = N'true'
GO
--  Crear la base de datos y tabla en el servidor remoto


-- Crear la base de datos de logs si no existe
EXEC('
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = ''LoggingDB'')
BEGIN
    CREATE DATABASE LoggingDB;
END
') AT CENTRAL_LOG_SERVER;
GO

-- Usar la base de datos y crear la tabla de logs
EXEC('
USE LoggingDB;

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = ''SocaiRemoteLogs'')
BEGIN
    CREATE TABLE dbo.SocaiRemoteLogs(
        RemoteLogId INT IDENTITY(1,1) PRIMARY KEY,
        SourceServer VARCHAR(100) NOT NULL,
        SourceDatabase VARCHAR(100) NOT NULL,
        SourceProcedure VARCHAR(255) NULL,
        LogLevel VARCHAR(20) NOT NULL,
        Message VARCHAR(4000) NOT NULL,
        AdditionalInfo VARCHAR(MAX) NULL,
        UserName VARCHAR(100) NULL,
        HostName VARCHAR(100) NULL,
        ExecutionTime DATETIME2 NOT NULL DEFAULT GETDATE(),
        RelatedEntityId INT NULL,
        RelatedEntityType VARCHAR(50) NULL,
        OriginalLogId INT NULL,
        SessionId INT NULL,
        ErrorNumber INT NULL,
        ErrorLine INT NULL,
        ErrorState INT NULL,
        ErrorSeverity INT NULL,
        ErrorProcedure VARCHAR(255) NULL
    );
    
    CREATE INDEX IX_SocaiRemoteLogs_LogLevel ON SocaiRemoteLogs(LogLevel);
    CREATE INDEX IX_SocaiRemoteLogs_ExecutionTime ON SocaiRemoteLogs(ExecutionTime);
    CREATE INDEX IX_SocaiRemoteLogs_SourceProcedure ON SocaiRemoteLogs(SourceProcedure);
END
') AT CENTRAL_LOG_SERVER;
GO

--Crear el procedimiento almacenado genérico en el servidor principal
USE [Caso2]
GO

DROP PROCEDURE IF EXISTS dbo.sp_LogToRemoteServer;
GO
DROP PROCEDURE IF EXISTS dbo.sp_EjemploUsoBitacoraRemota;
GO

CREATE PROCEDURE dbo.sp_LogToRemoteServer
    @LogLevel VARCHAR(20),
    @Message VARCHAR(4000),
    @AdditionalInfo VARCHAR(MAX) = NULL,
    @SourceProcedure VARCHAR(255) = NULL,
    @RelatedEntityId INT = NULL,
    @RelatedEntityType VARCHAR(50) = NULL,
    @OriginalLogId INT = NULL,
    @ErrorNumber INT = NULL,
    @ErrorLine INT = NULL,
    @ErrorState INT = NULL,
    @ErrorSeverity INT = NULL,
    @ErrorProcedure VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Capturar información del contexto
    DECLARE @SourceServer VARCHAR(100) = @@SERVERNAME;
    DECLARE @SourceDatabase VARCHAR(100) = DB_NAME();
    DECLARE @UserName VARCHAR(100) = SUSER_SNAME();
    DECLARE @HostName VARCHAR(100) = HOST_NAME();
    DECLARE @SessionId INT = @@SPID;
    
    -- Si no se proporciona el procedimiento fuente, intentar capturarlo
    IF @SourceProcedure IS NULL
        SET @SourceProcedure = OBJECT_NAME(@@PROCID);
    
    BEGIN TRY
        -- Insertar en la tabla de bitácora remota
        INSERT INTO CENTRAL_LOG_SERVER.LoggingDB.dbo.SocaiRemoteLogs
        (
            SourceServer, SourceDatabase, SourceProcedure, LogLevel, 
            Message, AdditionalInfo, UserName, HostName, ExecutionTime,
            RelatedEntityId, RelatedEntityType, OriginalLogId, SessionId, 
            ErrorNumber, ErrorLine, ErrorState, ErrorSeverity, ErrorProcedure
        )
        VALUES
        (
            @SourceServer, @SourceDatabase, @SourceProcedure, @LogLevel,
            @Message, @AdditionalInfo, @UserName, @HostName, GETDATE(),
            @RelatedEntityId, @RelatedEntityType, @OriginalLogId, @SessionId,
            @ErrorNumber, @ErrorLine, @ErrorState, @ErrorSeverity, @ErrorProcedure
        );
        
        -- Registrar también localmente en caso de falla de conectividad (redundancia)
        INSERT INTO dbo.SocaiLogs 
        (
            description, postTime, computer, username, trace, 
            LogTypeId, LogSourceId, LogSeverityId, UserId, TransactionId
        )
        VALUES
        (
            @Message, 
            GETDATE(), 
            @HostName, 
            @UserName,
            ISNULL(@AdditionalInfo, N'Remote logging enabled'),
            -- Mapear LogLevel a LogTypeId
            CASE @LogLevel 
                WHEN 'Information' THEN 1
                WHEN 'Warning' THEN 2
                WHEN 'Error' THEN 3
                WHEN 'Critical' THEN 4
                ELSE 1
            END,
            5, -- Fuente: Remote Logging
            CASE @LogLevel 
                WHEN 'Information' THEN 1
                WHEN 'Warning' THEN 2
                WHEN 'Error' THEN 3
                WHEN 'Critical' THEN 4
                ELSE 1
            END,
            ISNULL(@RelatedEntityId, 1), -- Usuario administrador como fallback
            NULL
        );
        
        RETURN 0; -- Éxito
    END TRY
    BEGIN CATCH
        -- Capturar error de registro remoto y guardar localmente
        INSERT INTO dbo.SocaiLogs 
        (
            description, postTime, computer, username, trace, 
            LogTypeId, LogSourceId, LogSeverityId, UserId, TransactionId
        )
        VALUES
        (
            'Error al registrar en servidor remoto: ' + @Message, 
            GETDATE(), 
            @HostName, 
            @UserName,
            'Error: ' + ERROR_MESSAGE() + ', Mensaje original: ' + ISNULL(@AdditionalInfo, 'N/A'),
            3, -- Tipo: Error
            5, -- Fuente: Remote Logging
            3, -- Severidad: Alta
            1, -- Usuario admin
            NULL
        );
        
        RETURN ERROR_NUMBER(); -- Devolver código de error
    END CATCH;
END;
GO

-- Ejemplo de uso del SP genérico en cualquier otro procedimiento del sistema
CREATE PROCEDURE dbo.sp_EjemploUsoBitacoraRemota
    @UserId INT,
    @Operacion VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Lógica normal del procedimiento
        DECLARE @Resultado VARCHAR(100) = 'Operación ' + @Operacion + ' completada para usuario ' + CAST(@UserId AS VARCHAR);
        
        -- Registrar el éxito en bitácora remota
        EXEC dbo.sp_LogToRemoteServer 
            @LogLevel = 'Information',
            @Message = @Resultado,
            @RelatedEntityId = @UserId,
            @RelatedEntityType = 'Usuario';
            
        -- Devolver resultado
        SELECT @Resultado AS Resultado;
    END TRY
    BEGIN CATCH
        -- Registrar el error en bitácora remota
        EXEC dbo.sp_LogToRemoteServer 
            @LogLevel = 'Error',
            @Message =  @Operacion,
            @AdditionalInfo = ERROR_MESSAGE,
            @RelatedEntityId = @UserId,
            @RelatedEntityType = 'Usuario',
            @ErrorNumber = ERROR_NUMBER,
            @ErrorLine = ERROR_LINE,
            @ErrorState = ERROR_STATE,
            @ErrorSeverity = ERROR_SEVERITY,
            @ErrorProcedure = ERROR_PROCEDURE;
            
        -- Re-lanzar el error
        THROW;
    END CATCH;
END;
GO

