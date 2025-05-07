# Caso 2 Base de Datos Soltura: Queries

# Test de la base de datos

En este documento propiamente se delimitaran todas las secciones requeridas del caso 2 en lo que se refiere a los queries. Primeramente habria una explicacion breve de la seccion y como se abordo para conseguir el resultado y posteriormente se adjuntara el script del query. Ademas en las secciones que requieran mostrar un llenado de tabla se mostrara tanto el script como el query, de igual forma las tareas que solo pueden ser aplicadas en SQL Server se mostrara entonces solo el script. Importante mencionar que los scripts se encunetran individualmente en la carpeta de "ScriptsQueries" en caso de que sea necesario visitarlos ahi.

## 1. Poblacion de Datos (Chris)

## 2. Demostraciones T-SQL (uso de instrucciones específicas) (Chris)

## 3. Mantenimiento de la Seguridad (Santi)
*(corresponde al script `Scripts&Queries Mantenimiento de Seguridad.sql`)*

---

### 3.1 Logins

| Login | Propósito | Contraseña demo ¹ |
|-------|-----------|-------------------|
| `login_sinAcceso` | Cuenta bloqueada para pruebas negativas | `NoP@ss_demo1!` |
| `login_read` | Cuenta de solo‑lectura de catálogos | `Read0nly_demo1!` |
| `login_api` | Servicio Back‑End / API | `ApiP@ss_demo1!` |

---

### 3.2 Usuarios

| Usuario BD | Login asociado | Uso |
|------------|----------------|-----|
| `usr_noAccess` | `login_sinAcceso` | Asegurar que *DENY CONNECT* realmente impide el acceso |
| `usr_readOnly` | `login_read` | Lectura de tablas de catálogo |
| `usr_backEnd` | `login_api` | Invocar SP protegidos desde la API |

---

### 3.3 Roles y membresías

| Rol | Objetivo | Miembros |
|-----|----------|----------|
| `rl_catalogRead` | Lectura estricta de catálogos de la aplicación | `usr_readOnly` |
| `rl_backendApi`  | Operaciones permitidas al servicio back‑end | `usr_backEnd` |

---

### 3.4 Modelo de permisos

| Principal | `CONNECT` | `SELECT` catálogos | `SELECT/CRUD` liquidaciones | `EXEC` SP de pagos |
|-----------|-----------|--------------------|-----------------------------|--------------------|
| `usr_noAccess` | ❌ | ❌ | ❌ | ❌ |
| `usr_readOnly` | ✔️ | ✔️ (`SocaiSubscriptions`,`SocaiServiceTypes`) | ❌ | ❌ |
| `usr_backEnd`  | ✔️ | ❌ | ❌ (DENY directo) | ✔️ (`SocaiSP_PagarProveedorMesPasado`, `SocaiSP_GetToken`) |

---

### 3.5 Row-level Security

| Elemento | Detalle |
|----------|---------|
| **Función inline** | `dbo.fn_rls_Comercio(@CommerceId INT)` compara el parámetro con `SESSION_CONTEXT('ComId')`. |
| **Política** | `Policy_Comercio`; **FILTER** sobre `SocaiCommerces` y `SocaiCommerceSettlement`. |
| **Uso** | Antes de un `SELECT` el back‑end establece<br>`EXEC sp_set_session_context N'ComId', @idComercio;` |

---

### 3.6 Infraestructura criptográfica

| Objeto | Tipo / Algoritmo | Protegido por |
|--------|------------------|---------------|
| `##MS_DatabaseMasterKey##` | Master Key | Contraseña `MK$Caso2_demo!` |
| `CertPayments` | Certificado X.509 | — |
| `AK_Payments` | Llave asimétrica RSA‑3072 | — |
| `SK_PayToken` | Llave simétrica AES‑256 | `CertPayments`, `AK_Payments` |

Los *chargeToken* de la tabla `SocaiPayments.chargeToken` se cifran con
`ENCRYPTBYKEY(KEY_GUID('SK_PayToken'), @valor)`.

---

### 3.7 Procedimiento seguro de descrifrado
```sql
CREATE PROCEDURE dbo.SocaiSP_GetToken @PaymentId int AS
BEGIN
    OPEN SYMMETRIC KEY SK_PayToken DECRYPTION BY CERTIFICATE CertPayments;
    SELECT  p.PaymentId,
            CONVERT(varchar(250),DECRYPTBYKEY(p.chargeToken)) AS PlainToken
    FROM    dbo.SocaiPayments AS p
    WHERE   p.PaymentId = @PaymentId;
    CLOSE SYMMETRIC KEY SK_PayToken;
END
```

## 4. Consultas Misceláneas (Barquero)

## 4.1. Vista Indexada

### Vista: `vwResumenUsuarios`

Una vista indexada que proporciona información consolidada sobre los usuarios, sus suscripciones y servicios contratados.

#### Definición:

```sql
-- Vista Indexada sin SocaiPayments
CREATE VIEW dbo.vwResumenUsuarios
WITH SCHEMABINDING
AS
SELECT 
    u.UserId AS idUsuario,
    u.Name AS NombreUsuario,
    su.SubscriptionUserId AS idSuscripcion,
    su.startDateTime AS fechaInicio,
    su.endDateTime AS fechaFin,
    fs.FeaturesSubscriptionsId AS idServicio,
    pf.Name AS NombreServicio,
    CONCAT(u.UserId, '-', su.SubscriptionUserId, '-', fs.FeaturesSubscriptionsId) AS CodigoRelacional
FROM dbo.SocaiUsers u
INNER JOIN dbo.SocaiSubscriptionUser su ON u.UserId = su.UserId
INNER JOIN dbo.SocaiFeaturesSubscriptions fs ON su.SubscriptionId = fs.SubscriptionId
INNER JOIN dbo.SocaiPlanFeatures pf ON fs.PlanFeatureId = pf.FeatureId
WHERE u.isActive = 1 
  AND su.enable = 1;
  AND fs.FeaturesSubscriptionsId IS NOT NULL;
GO

```

#### Índice único agrupado:

```sql
CREATE UNIQUE CLUSTERED INDEX IX_ResumenUsuarios
ON dbo.vwResumenUsuarios (idUsuario, idSuscripcion, idServicio);
```

#### Uso:
```sql
SELECT * FROM dbo.vwResumenUsuarios;

Procedimiento: sp_ActualizarDatosResumenUsuarios
Este procedimiento permite actualizar los datos relacionados con la vista indexada.
Definición:
sqlCREATE OR ALTER PROCEDURE sp_ActualizarDatosResumenUsuarios
    @IdUsuario INT,
    @IdSuscripcion INT = NULL,
    @IdServicio INT = NULL,
    @NuevoNombre VARCHAR(250) = NULL,
    @NuevaFechaInicio DATETIME = NULL,
    @NuevaFechaFin DATETIME = NULL,
    @NuevoNombreServicio VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Errores TABLE (
        EntidadModificada VARCHAR(100),
        IdEntidad INT,
        Mensaje VARCHAR(500)
    );
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Actualizar información de usuario
        IF @NuevoNombre IS NOT NULL
        BEGIN
            UPDATE SocaiUsers
            SET Name = @NuevoNombre
            WHERE UserId = @IdUsuario;
            
            IF @@ROWCOUNT = 0
                INSERT INTO @Errores VALUES ('Usuario', @IdUsuario, 'Usuario no encontrado');
        END
        
        -- Actualizar información de suscripción
        IF @IdSuscripcion IS NOT NULL AND (@NuevaFechaInicio IS NOT NULL OR @NuevaFechaFin IS NOT NULL)
        BEGIN
            UPDATE SocaiSubscriptionUser
            SET startDateTime = ISNULL(@NuevaFechaInicio, startDateTime),
                endDateTime = ISNULL(@NuevaFechaFin, endDateTime)
            WHERE SubscriptionUserId = @IdSuscripcion
              AND UserId = @IdUsuario;
              
            IF @@ROWCOUNT = 0
                INSERT INTO @Errores VALUES ('Suscripción', @IdSuscripcion, 'Suscripción no encontrada o no pertenece al usuario');
        END
        
        -- Actualizar información de servicio
        IF @IdServicio IS NOT NULL AND @NuevoNombreServicio IS NOT NULL
        BEGIN
            -- Esta actualización es más compleja porque necesitamos encontrar el PlanFeature adecuado
            DECLARE @PlanFeatureId INT;
            
            -- Buscar o crear un PlanFeature con el nuevo nombre
            SELECT @PlanFeatureId = FeatureId
            FROM SocaiPlanFeatures
            WHERE Name = @NuevoNombreServicio;
            
            IF @PlanFeatureId IS NULL
            BEGIN
                -- Si no existe el nombre de servicio, crear uno nuevo
                INSERT INTO SocaiPlanFeatures (
                    Name, 
                    Description, 
                    Category, 
                    UnitTypeId, 
                    isActive, 
                    UpdatedTime, 
                    CreatedTime
                )
                VALUES (
                    @NuevoNombreServicio,
                    'Servicio creado automáticamente',
                    'Otros',
                    1,  -- UnitTypeId predeterminado
                    1,  -- activo
                    GETDATE(),
                    GETDATE()
                );
                
                SET @PlanFeatureId = SCOPE_IDENTITY();
            END
            
            -- Actualizar la característica de suscripción
            UPDATE SocaiFeaturesSubscriptions
            SET PlanFeatureId = @PlanFeatureId,
                UpdatedAt = GETDATE()
            WHERE FeaturesSubscriptionsId = @IdServicio;
            
            IF @@ROWCOUNT = 0
                INSERT INTO @Errores VALUES ('Servicio', @IdServicio, 'Servicio no encontrado');
        END
        
        -- Verificar si hay errores
        IF EXISTS (SELECT 1 FROM @Errores)
        BEGIN
            ROLLBACK TRANSACTION;
            
            SELECT 'Error' AS Resultado, 
                   EntidadModificada,
                   IdEntidad,
                   Mensaje
            FROM @Errores;
        END
        ELSE
        BEGIN
            COMMIT TRANSACTION;
            
            SELECT 'Éxito' AS Resultado, 
                   'Se actualizaron correctamente los datos solicitados' AS Mensaje;
                   
            -- Mostrar los datos actualizados
            SELECT *
            FROM dbo.vwResumenUsuarios
            WHERE idUsuario = @IdUsuario
            AND (@IdSuscripcion IS NULL OR idSuscripcion = @IdSuscripcion)
            AND (@IdServicio IS NULL OR idServicio = @IdServicio);
        END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SELECT 
            'Error' AS Resultado,
            ERROR_MESSAGE() AS Mensaje,
            ERROR_SEVERITY() AS Severidad,
            ERROR_STATE() AS Estado,
            ERROR_PROCEDURE() AS Procedimiento,
            ERROR_LINE() AS Linea;
    END CATCH;
END;
```
Características:

- Permite actualizar datos relacionados con la vista indexada
- Implementa transacciones para garantizar la integridad
- Maneja diferentes tipos de actualizaciones (usuario, suscripción, servicio)
- Incluye validación de datos y reporte de errores
- Muestra los datos actualizados tras la operación exitosa
## 4.2. Procedimiento Almacenado Transaccional

### Procedimiento: `spRegistrarSuscripcion`

Este procedimiento almacenado transaccional gestiona el registro de nuevas suscripciones y realiza modificaciones en al menos tres tablas relacionadas.

#### Parámetros:
- `@idUsuario`: ID del usuario
- `@idServicio`: ID del servicio a suscribir
- `@fechaInicio`: Fecha de inicio de la suscripción
- `@fechaFin`: Fecha de fin de la suscripción
- `@monto`: Monto del pago
- `@fechaPago`: Fecha del pago

#### Definición:

```sql
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

        -- 1. Insertar en SocaiSubscriptionUser
        INSERT INTO dbo.SocaiSubscriptionUser (enable, startDateTime, endDateTime, UserId, SubscriptionId)
        VALUES (1, @fechaInicio, @fechaFin, @idUsuario, @idServicio);
        
        DECLARE @idSuscripcion INT = SCOPE_IDENTITY();
        
        -- 2. Insertar en SocaiPayments
        DECLARE @PaymentMethodId INT = (SELECT TOP 1 PaymentMethodId FROM dbo.SocaiPaymentMethods WHERE enable = 1);
        DECLARE @CurrencyTypeId INT = (SELECT TOP 1 CurrencyTypeId FROM dbo.SocaiCurrencyTypes WHERE acronym = 'CRC');
        DECLARE @ResultPaymentId INT = (SELECT TOP 1 ResultPaymentId FROM dbo.SocaiResultPayment WHERE name = 'Exitoso');
        
        INSERT INTO dbo.SocaiPayments (amount, actualAmount, date, DataPaymentId, PaymentMethodId, UserId, ResultPaymentId, CurrencyTypeId)
        VALUES (@monto, @monto, @fechaPago, 1, @PaymentMethodId, @idUsuario, @ResultPaymentId, @CurrencyTypeId);
        
        DECLARE @idPago INT = SCOPE_IDENTITY();
        
        -- 3. Insertar en SocaiTransactions
        INSERT INTO dbo.SocaiTransactions (amount, description, transactionDateTime, postTime, referenceNumber,
                                          TransactionTypeId, TransactionSubTypeId, CurrencyTypeId, PaymentId, UserId, ExchangeRateId)
        VALUES (@monto, 'Pago por suscripción a servicio', GETDATE(), GETDATE(), NEWID(),
                1, 1, @CurrencyTypeId, @idPago, @idUsuario, 1);
        
        -- 4. Actualizar SocaiFeaturesSubscriptions
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
```

#### Funcionalidades:
- Inserta un nuevo registro en la tabla `SocaiSubscriptionUser`
- Registra un pago en la tabla `SocaiPayments`
- Registra una transacción en la tabla `SocaiTransactions`
- Actualiza la cantidad en la tabla `SocaiFeaturesSubscriptions`
- Proporciona manejo de errores y rollback en caso de fallo

#### Lógica de Negocio:
- Verificación de consistencia de datos
- Gestión de transacciones para asegurar integridad
- Registro de errores en la tabla de logs del sistema

## 4.3. Consulta con CASE para Agrupamiento Dinámico

### Procedimiento: `sp_ClasificacionUsuarios`

Este procedimiento utiliza la instrucción CASE para clasificar dinámicamente a los usuarios según su patrón de pagos.

#### Definición:

```sql
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
    LEFT JOIN dbo.SocaiPayments p ON u.UserId = p.UserId
    GROUP BY u.UserId, u.Name;
END;
```

#### Categorías de clasificación:
- **Nuevo**: Usuarios sin pagos registrados
- **Ocasional**: Usuarios con 1 a 3 pagos
- **Frecuente**: Usuarios con más de 3 pagos

#### Uso:
```sql
EXEC sp_ClasificacionUsuarios;
```

## 4.4. Consulta Compleja con JOINs, Funciones Agregadas y CTEs

### Procedimiento: `sp_ObtenerReporteAnalisisUsuarios`

Este procedimiento implementa una consulta compleja que utiliza múltiples técnicas avanzadas de T-SQL.

#### Definición:

```sql
CREATE OR ALTER PROCEDURE sp_ObtenerReporteAnalisisUsuarios
AS
BEGIN
    SET NOCOUNT ON;
    
    -- CTE 1: Información de usuarios y suscripciones
    WITH UsuariosSuscripciones AS (
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
    -- CTE 2: Información de pagos
    PagosUsuario AS (
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
    -- CTE 3: Servicios utilizados
    ServiciosUtilizados AS (
        SELECT 
            su.UserId,
            COUNT(fs.FeaturesSubscriptionsId) AS TotalServicios,
            STRING_AGG(pf.Name, ', ') AS Servicios
        FROM dbo.SocaiSubscriptionUser su
        INNER JOIN dbo.SocaiFeaturesSubscriptions fs ON su.SubscriptionId = fs.SubscriptionId
        INNER JOIN dbo.SocaiPlanFeatures pf ON fs.PlanFeatureId = pf.FeatureId
        GROUP BY su.UserId
    )
    
    -- Consulta principal que utiliza las 3 CTEs
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
```

#### Características:
- Utiliza 3 Common Table Expressions (CTEs):
  - `UsuariosSuscripciones`: Información base de usuarios y suscripciones
  - `PagosUsuario`: Información agregada de pagos por usuario
  - `ServiciosUtilizados`: Servicios contratados por usuario con STRING_AGG
- Implementa 4 JOINs entre tablas principales
- Incluye 2 funciones agregadas (COUNT, SUM)
- Utiliza operadores EXISTS y NOT IN para filtrado avanzado
- Implementa CASE para categorización dinámica
- Incluye formateo de fechas con CONVERT
- Usa HAVING para filtrar después de agregación

#### Propósito:
Generar un informe detallado del estado de los clientes, sus suscripciones, historial de pagos y servicios contratados, con clasificación de clientes según su comportamiento.

## 4.5. Consulta con INTERSECTION y SET DIFFERENCE

### Procedimiento: `sp_AnalisisUsuariosInterseccionDiferencia`

Este procedimiento demuestra el uso de operaciones de conjuntos en SQL.

#### Definición:

```sql
CREATE OR ALTER PROCEDURE sp_AnalisisUsuariosInterseccionDiferencia
AS
BEGIN
    -- INTERSECCIÓN: Usuarios con suscripción y al menos un pago registrado
    SELECT DISTINCT u.UserId AS idUsuario, u.Name AS nombre
    FROM dbo.SocaiUsers u
    INNER JOIN dbo.SocaiSubscriptionUser su ON u.UserId = su.UserId
    INNER JOIN dbo.SocaiPayments p ON u.UserId = p.UserId

    INTERSECT

    SELECT DISTINCT u.UserId AS idUsuario, u.Name AS nombre
    FROM dbo.SocaiUsers u
    INNER JOIN dbo.SocaiSubscriptionUser su ON u.UserId = su.UserId
    INNER JOIN dbo.SocaiFeaturesSubscriptions fs ON su.SubscriptionId = fs.SubscriptionId
    WHERE su.enable = 1;

    -- DIFERENCIA: Usuarios con suscripción pero sin ningún pago
    SELECT DISTINCT u.UserId AS idUsuario, u.Name AS nombre
    FROM dbo.SocaiUsers u
    INNER JOIN dbo.SocaiSubscriptionUser su ON u.UserId = su.UserId

    EXCEPT

    SELECT DISTINCT u.UserId AS idUsuario, u.Name AS nombre
    FROM dbo.SocaiUsers u
    INNER JOIN dbo.SocaiPayments p ON u.UserId = p.UserId;
END;
```

#### Operaciones:
1. **INTERSECT**: Encuentra usuarios que tienen tanto suscripciones como pagos registrados
2. **EXCEPT**: Identifica usuarios con suscripciones pero sin pagos registrados

#### Uso:
```sql
EXEC sp_AnalisisUsuariosInterseccionDiferencia;
```

## 4.6. Procedimientos Almacenados Transaccionales Anidados

### Procedimientos: 
- `sp_actualizarPagosYServicios`: Nivel más bajo
- `sp_actualizarUsuarioYSuscripcion`: Nivel intermedio
- `sp_procesoCompleto`: Nivel superior

#### Estructura de anidamiento:
- `sp_procesoCompleto` llama a `sp_actualizarUsuarioYSuscripcion`
- `sp_actualizarUsuarioYSuscripcion` llama a `sp_actualizarPagosYServicios`

#### Definición:

```sql
-- Procedimiento de nivel más bajo
CREATE OR ALTER PROCEDURE sp_actualizarPagosYServicios
    @idServicio INT,
    @idSuscripcion INT,
    @nuevoMonto DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN

        -- Actualizar servicios
        UPDATE dbo.SocaiFeaturesSubscriptions
        SET Quantity = COALESCE(Quantity, 0) + 1,
            MemberCount = COALESCE(MemberCount, 1),
            UpdatedAt = GETDATE()
        WHERE FeaturesSubscriptionsId = @idServicio;

        -- Datos para pago
        DECLARE @PaymentMethodId INT = (SELECT TOP 1 PaymentMethodId FROM dbo.SocaiPaymentMethods WHERE enable = 1);
        DECLARE @CurrencyTypeId INT = (SELECT TOP 1 CurrencyTypeId FROM dbo.SocaiCurrencyTypes WHERE acronym = 'CRC');
        DECLARE @ResultPaymentId INT = (SELECT TOP 1 ResultPaymentId FROM dbo.SocaiResultPayment WHERE name = 'Exitoso');
        
        DECLARE @UserId INT = (SELECT UserId FROM dbo.SocaiSubscriptionUser WHERE SubscriptionUserId = @idSuscripcion);
        SET @UserId = ISNULL(@UserId, 1);
        
        -- Registrar pago
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

-- Procedimiento de nivel intermedio
CREATE OR ALTER PROCEDURE sp_actualizarUsuarioYSuscripcion
    @idUsuario INT,
    @nuevoNombre NVARCHAR(100),
    @idSuscripcion INT,
    @idServicio INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN

        -- Actualizar usuario
        UPDATE dbo.SocaiUsers
        SET Name = @nuevoNombre
        WHERE UserId = @idUsuario;

        -- Actualizar suscripción
        UPDATE dbo.SocaiSubscriptionUser
        SET startDateTime = GETDATE()
        WHERE SubscriptionUserId = @idSuscripcion;

        -- Llamar al procedimiento de nivel más bajo
        EXEC sp_actualizarPagosYServicios @idServicio, @idSuscripcion, 5000;

        COMMIT
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK
        THROW
    END CATCH
END
GO

-- Procedimiento de nivel superior
CREATE OR ALTER PROCEDURE sp_procesoCompleto
    @idUsuario INT,
    @nuevoNombre NVARCHAR(100),
    @idSuscripcion INT,
    @idServicio INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN
        -- Llamar al procedimiento de nivel intermedio
        EXEC sp_actualizarUsuarioYSuscripcion @idUsuario, @nuevoNombre, @idSuscripcion, @idServicio;
        COMMIT
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK
        THROW
    END CATCH
END
```

#### Características:
- Demuestra el manejo de transacciones anidadas
- Implementa propagación de excepciones a través de los niveles
- Gestión coherente de commit y rollback en cascada
- Manejo de errores consistente mediante bloques TRY-CATCH

## 4.7. Consulta que Retorna JSON

### Procedimiento: `sp_ObtenerDetalleSubscripcionJSON`

Este procedimiento genera una salida en formato JSON para facilitar la integración con aplicaciones web y móviles.

#### Definición:

```sql
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
```

#### Características:
- Utiliza la cláusula FOR JSON PATH para formatear la salida
- Implementa JSON anidado para representar relaciones
- Utiliza WITHOUT_ARRAY_WRAPPER para simplificar la estructura
- Define ROOT para establecer el nodo raíz del JSON

#### Uso:
```sql
EXEC sp_ObtenerDetalleSubscripcionJSON @UserId = 1;
```

## 4.8. Procedimiento con Table-Valued Parameter

### Procedimiento: `sp_UpdateServiceContracts`

Este procedimiento demuestra el uso de parámetros de tipo tabla (TVP) para pasar múltiples valores en una sola llamada.

#### Definición del tipo de tabla:

```sql
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
```

#### Definición del procedimiento:

```sql
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
        
        -- Actualizaciones de comercio y contrato...
        
        -- Parte principal: MERGE con el parámetro de tipo tabla
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
                -- más actualizaciones...
        WHEN NOT MATCHED THEN
            INSERT (
                CommercesId, PlanFeaturesId, IsActive, ValidFrom, ValidTo, CreatedAt, UpdatedAt,
                -- más campos...
            )
            VALUES (
                source.CommercesId, source.PlanFeaturesId, source.IsActive, source.ValidFrom, source.ValidTo, GETDATE(), GETDATE(),
                -- más valores...
            );
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        -- Manejo de errores...
    END CATCH;
END;
```

#### Características:
- Define un tipo `ContractConditionsType` como tabla
- Implementa la instrucción MERGE para sincronización eficiente de datos
- Maneja inserción y actualización en un solo paso
- Incluye transacciones para mantener la integridad
- Registra errores en una tabla temporal para reportarlos al cliente

#### Uso:
```sql
-- Declarar la variable de tipo tabla
DECLARE @condiciones ContractConditionsType;

-- Insertar datos en la variable de tipo tabla
INSERT INTO @condiciones (PlanFeaturesId, IsActive, ValidFrom, ValidTo, ...)
VALUES (1, 1, '2023-01-01', '2024-01-01', ...);

-- Ejecutar el procedimiento
EXEC sp_UpdateServiceContracts
    @CommerceId = 1,
    @CommerceName = 'Nombre Comercio',
    @ContractConditions = @condiciones;
```
## 4.9. Generación de Archivo CSV

### Descripción
Este procedimiento almacenado permite generar un archivo CSV con información de suscripciones de usuarios, utilizando el comando BCP (Bulk Copy Program) de SQL Server.

### Procedimiento: `sp_GenerateSubscriptionsCSV`

```sql
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
```

### Características

- **Parametrización**: Permite especificar la ruta del archivo CSV de salida.
- **Consulta Personalizada**: Genera un conjunto de datos completo con información de usuarios, suscripciones y planes.
- **Formateo de Fechas**: Formato especial para fechas que evita problemas de interpretación en Excel y otras herramientas de hoja de cálculo.
- **Utilización de xp_cmdshell**: Ejecuta comandos del sistema operativo para generar el archivo.
- **BCP (Bulk Copy Program)**: Utiliza la utilidad de SQL Server para exportación eficiente de datos.
- **Verificación de Resultados**: Comprueba si el archivo se generó correctamente y devuelve un mensaje apropiado.

### Parámetros

| Parámetro | Tipo | Descripción | Valor por defecto |
|-----------|------|-------------|-------------------|
| @FilePath | VARCHAR(500) | Ruta donde se generará el archivo CSV | 'C:\Exports\subscription_report.csv' |

### Uso del Procedimiento

```sql
-- Generar el archivo CSV en la ubicación por defecto
EXEC sp_GenerateSubscriptionsCSV;

-- Generar el archivo CSV en una ubicación personalizada
EXEC sp_GenerateSubscriptionsCSV @FilePath = 'D:\Reportes\suscripciones_soltura.csv';
```

### Requisitos Previos

- Permisos de xp_cmdshell para el usuario que ejecuta el procedimiento.
- Permisos de escritura en la carpeta de destino.
- Configuración habilitada de xp_cmdshell en el servidor SQL.

### Notas Técnicas

- El formato de fecha utilizado ('="yyyy-mm-dd hh:mi:ss"') permite que Excel reconozca correctamente las fechas sin convertirlas automáticamente.
- Se utiliza el separador de campos coma (,) que es el estándar para archivos CSV.
- El codificado ACP (ANSI Code Page) asegura la compatibilidad con caracteres especiales.

## 4.10. Bitácora en Servidor Remoto Vinculado

### Descripción

Este conjunto de scripts y procedimientos implementa un sistema de registro (logging) centralizado utilizando un servidor vinculado (Linked Server) para almacenar logs provenientes de múltiples bases de datos en un único repositorio.

### Configuración del Linked Server

```sql
-- Configuración del Linked Server (ejecutar en el servidor principal)
EXEC master.dbo.sp_addlinkedserver 
    @server = N'CENTRAL_LOG_SERVER', 
    @srvproduct = N'',
    @provider = N'SQLOLEDB', 
    @datasrc = N'localhost';

-- Configuración de impersonación
EXEC master.dbo.sp_addlinkedsrvlogin 
    @rmtsrvname = N'CENTRAL_LOG_SERVER',
    @useself = N'TRUE';

-- Habilitar RPC
EXEC master.dbo.sp_serveroption 
    @server = N'CENTRAL_LOG_SERVER', 
    @optname = N'rpc', 
    @optvalue = N'true';

EXEC master.dbo.sp_serveroption 
    @server = N'CENTRAL_LOG_SERVER', 
    @optname = N'rpc out', 
    @optvalue = N'true';
```

### Creación de la Base de Datos y Tabla de Logs en el Servidor Remoto

```sql
-- Crear la base de datos de logs si no existe
EXEC('
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = ''LoggingDB'')
BEGIN
    CREATE DATABASE LoggingDB;
END
') AT CENTRAL_LOG_SERVER;

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
```

### Procedimiento para Logging Remoto

```sql
CREATE OR ALTER PROCEDURE dbo.sp_LogToRemoteServer
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
```

### Ejemplo de Uso del Procedimiento

```sql
CREATE OR ALTER PROCEDURE dbo.sp_EjemploUsoBitacoraRemota
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
            @Message = @Operacion,
            @AdditionalInfo = ERROR_MESSAGE(),
            @RelatedEntityId = @UserId,
            @RelatedEntityType = 'Usuario',
            @ErrorNumber = ERROR_NUMBER(),
            @ErrorLine = ERROR_LINE(),
            @ErrorState = ERROR_STATE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorProcedure = ERROR_PROCEDURE();
            
        -- Re-lanzar el error
        THROW;
    END CATCH;
END;
```

### Características

- **Centralización de Logs**: Permite almacenar logs de múltiples bases de datos/servidores en un único repositorio central.
- **Redundancia**: Mantiene un registro local en caso de fallos de conectividad con el servidor remoto.
- **Contexto Automático**: Captura automáticamente información del servidor, base de datos, usuario, host, etc.
- **Niveles de Severidad**: Soporta diferentes niveles de log (Information, Warning, Error, Critical).
- **Manejo de Errores**: Implementa captura y registro de detalles de error.
- **Integración con Sistema Existente**: Se integra con la tabla local SocaiLogs para mantener compatibilidad.

### Parámetros del Procedimiento sp_LogToRemoteServer

| Parámetro | Tipo | Descripción | Obligatorio |
|-----------|------|-------------|-------------|
| @LogLevel | VARCHAR(20) | Nivel de severidad del log (Information, Warning, Error, Critical) | Sí |
| @Message | VARCHAR(4000) | Mensaje principal del log | Sí |
| @AdditionalInfo | VARCHAR(MAX) | Información adicional o detallada | No |
| @SourceProcedure | VARCHAR(255) | Procedimiento que origina el log | No |
| @RelatedEntityId | INT | ID de la entidad relacionada (usuario, transacción, etc.) | No |
| @RelatedEntityType | VARCHAR(50) | Tipo de entidad relacionada | No |
| @OriginalLogId | INT | ID de un log relacionado | No |
| @ErrorNumber | INT | Número de error (en caso de excepciones) | No |
| @ErrorLine | INT | Línea donde ocurrió el error | No |
| @ErrorState | INT | Estado del error | No |
| @ErrorSeverity | INT | Severidad del error | No |
| @ErrorProcedure | VARCHAR(255) | Procedimiento donde ocurrió el error | No |

### Requisitos Previos

- Permisos para crear y configurar servidores vinculados.
- Permisos para ejecutar inserciones en el servidor remoto.
- Habilitación de RPC y RPC Out en la configuración del servidor.
- Existencia de la tabla SocaiLogs en la base de datos local.

### Consideraciones de Rendimiento

- Las operaciones de logging remoto pueden introducir latencia en las transacciones.
- Se recomienda usar este sistema principalmente para eventos importantes o errores críticos.
- Los índices en la tabla remota están diseñados para optimizar consultas comunes en los logs.


## 5. Concurrencia (Santi)

### 5.1 Objetivos  
1. **Dead‑locks** realistas (SELECT ⇄ UPDATE) y en *cascada*.  
2. Demostrar los cuatro **niveles de aislamiento** y sus efectos (lecturas sucias, phantom rows…).  
3. Ejemplo de **cursor de update** que bloquea fila‑a‑fila.  
4. **Transacción de volumen** (benchmark TPS) para medir y extrapolar capacidad.  
5. Vista auxiliar para comprobar en vivo el aislamiento de cada sesión.  

---

### 5.2 Escenario de Dead‑lock simple   `DL_A / DL_B`  
**Uso:** abrir **dos** conexiones.  
* Ventana‑1 → `EXEC dbo.DL_A`  
* Ventana‑2 → `EXEC dbo.DL_B`  
> El cruce SELECT → UPDATE / UPDATE → SELECT provoca el dead‑lock.
> 
```sql
IF OBJECT_ID('dbo.DL_A','P') IS NOT NULL DROP PROCEDURE dbo.DL_A;
GO
CREATE PROCEDURE dbo.DL_A AS
BEGIN
    BEGIN TRAN;
        SELECT *              FROM dbo.SocaiCommerceSettlement WHERE CommerceId = 1;
        WAITFOR DELAY '00:00:03';
        UPDATE dbo.SocaiPayments SET amount = amount WHERE PaymentId = 1;
    COMMIT;
END;
GO

IF OBJECT_ID('dbo.DL_B','P') IS NOT NULL DROP PROCEDURE dbo.DL_B;
GO
CREATE PROCEDURE dbo.DL_B AS
BEGIN
    BEGIN TRAN;
        UPDATE dbo.SocaiPayments SET amount = amount WHERE PaymentId = 1;
        WAITFOR DELAY '00:00:03';
        SELECT *              FROM dbo.SocaiCommerceSettlement WHERE CommerceId = 1;
    COMMIT;
END;
GO
```

### 5.3 Dead‑lock en cascada
**Uso**: tres conexiones independientes (A → B → C).
Demuestra que pueden formarse ciclos A bloquea B, B bloquea C, C bloquea A.

```sql
IF OBJECT_ID('dbo.Cascade_A','P') IS NOT NULL DROP PROCEDURE dbo.Cascade_A;
GO
CREATE PROCEDURE dbo.Cascade_A AS
BEGIN
    BEGIN TRAN;
        UPDATE dbo.SocaiSubscriptions SET amount = amount WHERE SubscriptionId = 1;   
        WAITFOR DELAY '00:00:05';
        SELECT 1 FROM dbo.SocaiPayments WHERE PaymentId = 1;                         
    COMMIT;
END;
GO

IF OBJECT_ID('dbo.Cascade_B','P') IS NOT NULL DROP PROCEDURE dbo.Cascade_B;
GO
CREATE PROCEDURE dbo.Cascade_B AS
BEGIN
    BEGIN TRAN;
        UPDATE dbo.SocaiPayments SET amount = amount WHERE PaymentId = 1;             
        WAITFOR DELAY '00:00:05';
        SELECT 1 FROM dbo.SocaiCommerceSettlement WHERE CommerceId = 1;              
    COMMIT;
END;
GO

IF OBJECT_ID('dbo.Cascade_C','P') IS NOT NULL DROP PROCEDURE dbo.Cascade_C;
GO
CREATE PROCEDURE dbo.Cascade_C AS
BEGIN
    BEGIN TRAN;
        UPDATE dbo.SocaiCommerceSettlement SET totalNet = totalNet WHERE CommerceId = 1; 
        WAITFOR DELAY '00:00:05';
        SELECT 1 FROM dbo.SocaiSubscriptions WHERE SubscriptionId = 1;                   
    COMMIT;
END;
GO
```
### 5.4 Demo de niveles de aislamiento
Permite repetir la misma lectura con distintos isolation levels y observar diferencias.
```sql
IF OBJECT_ID('dbo.demo_isolation','P') IS NOT NULL DROP PROCEDURE dbo.demo_isolation;
GO
CREATE PROCEDURE dbo.demo_isolation
    @level sysname = 'READ COMMITTED'     -- opciones: READ UNCOMMITTED | REPEATABLE READ | SERIALIZABLE
AS
BEGIN
    IF      @level = 'READ UNCOMMITTED'   SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    ELSE IF @level = 'REPEATABLE READ'    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    ELSE IF @level = 'SERIALIZABLE'       SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    ELSE                                  SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

    BEGIN TRAN;
        SELECT COUNT(*) AS totalAntes  FROM dbo.SocaiPayments;
        WAITFOR DELAY '00:00:05';          -- modificar datos en otra sesión durante la espera
        SELECT COUNT(*) AS totalDespues FROM dbo.SocaiPayments;
    ROLLBACK;
END;
GO
```
### 5.5 Cursor de actualización fila‑a‑fila
Ejemplo para que el equipo de desarrollo entienda cuándo un cursor bloquea registros.
```sql
IF OBJECT_ID('dbo.demo_cursorRegeneraSaldo','P') IS NOT NULL
    DROP PROCEDURE dbo.demo_cursorRegeneraSaldo;
GO
CREATE PROCEDURE dbo.demo_cursorRegeneraSaldo
AS
BEGIN
    DECLARE c CURSOR LOCAL FOR
        SELECT SuscriptionUserId
        FROM   dbo.SocaiBalancePerPerson
        ORDER BY SuscriptionUserId;

    DECLARE @id INT;
    OPEN c; FETCH NEXT FROM c INTO @id;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE dbo.SocaiBalancePerPerson
           SET updatedAt = SYSUTCDATETIME()
         WHERE CURRENT OF c;                     -- bloqueo por fila

        WAITFOR DELAY '00:00:02';
        FETCH NEXT FROM c INTO @id;
    END
    CLOSE c; DEALLOCATE c;
END;
GO
```
### 5.6 Transacción de volumen / Benchmark TPS
La “transacción de volumen” de Soltura es registrar una transacción de pago (INSERT INTO SocaiTransactions).
El procedimiento inserta en bucle durante n segundos y reporta TPS promedio.
```sql
IF OBJECT_ID('dbo.bench_volumenPago','P') IS NOT NULL
    DROP PROCEDURE dbo.bench_volumenPago;
GO
CREATE PROCEDURE dbo.bench_volumenPago
    @segundos INT = 10            -- duración de la prueba
AS
BEGIN
    DECLARE @ini DATETIME2 = SYSUTCDATETIME();

    WHILE DATEDIFF(SECOND,@ini,SYSUTCDATETIME()) < @segundos
    BEGIN
        INSERT dbo.SocaiTransactions
               (amount,transactionDateTime,postTime,
                TransactionTypeId,TransactionSubTypeId,
                CurrencyTypeId,PaymentId,UserId,ExchangeRateId)
        VALUES(1,SYSUTCDATETIME(),SYSUTCDATETIME(),1,1,1,1,1,1);
    END;

    DECLARE @total BIGINT =
        (SELECT COUNT(*) FROM dbo.SocaiTransactions
         WHERE transactionDateTime >= @ini);

    PRINT 'TPS ≈ ' + CONVERT(varchar,@total / NULLIF(@segundos,0))
        + '  (' + CONVERT(varchar,@total) + ' transacciones)';
END;
GO
```
### 5.7 Vista auxiliar
Muestra, por sesión de usuario, el nivel de aislamiento actualmente activo.
```sql
IF OBJECT_ID('dbo.vw_trxIsolation','V') IS NOT NULL
    DROP VIEW dbo.vw_trxIsolation;
GO
CREATE VIEW dbo.vw_trxIsolation
AS
SELECT  session_id,
        CASE transaction_isolation_level
             WHEN 0 THEN 'READ UNCOMMITTED'
             WHEN 1 THEN 'READ COMMITTED'
             WHEN 2 THEN 'REPEATABLE READ'
             WHEN 3 THEN 'SERIALIZABLE'
             WHEN 4 THEN 'SNAPSHOT' END AS isolation_level,
        last_request_start_time
FROM sys.dm_exec_sessions
WHERE is_user_process = 1;
GO
```
## 5.8 Cómo ejecutar las pruebas

| Objetivo                         | Sesión A (ventana 1)            | Sesión B (ventana 2)            | Sesión C (ventana 3) / Observación |
|---------------------------------|---------------------------------|---------------------------------|------------------------------------|
| **Dead‑lock simple**            | `EXEC dbo.DL_A;`                | `EXEC dbo.DL_B;`                | Dead‑lock visible en *Activity Monitor* o en `sys.dm_tran_deadlock_graph`. |
| **Dead‑lock en cascada**        | `EXEC dbo.Cascade_A;`           | `EXEC dbo.Cascade_B;`           | `EXEC dbo.Cascade_C;`              |
| **Demostración de aislamiento** | `EXEC dbo.demo_isolation 'READ COMMITTED';` (o nivel deseado) | Mientras corre, ejecutar DML que modifique `SocaiPayments`. | Comparar `totalAntes` vs `totalDespues`. |
| **Cursor de update**            | `EXEC dbo.demo_cursorRegeneraSaldo;` | (Opcional) segundo `UPDATE` sobre `SocaiBalancePerPerson` | Se observan bloqueos fila‑a‑fila. |
| **Benchmark TPS**               | `EXEC dbo.bench_volumenPago 15;` | *—* | El mensaje de salida muestra `TPS ≈ …`. |

> **Cómo triplicar el TPS sin hardware ni cambiar el query**  
> 1. Convertir `SocaiTransactions` en tabla **memory‑optimized** (Hekaton).  
> 2. Activar aislamiento **READ\_COMMITTED\_SNAPSHOT** para reducir bloqueos de lectura.  
> 3. Insertar en *lotes* (`INSERT … SELECT TOP (N)`) en lugar de fila a fila.

```sql
-- Activar versión optimista para lecturas
ALTER DATABASE Caso2 SET READ_COMMITTED_SNAPSHOT ON;
```

## 6. Noticias de Ultima Hora (Barquero)
