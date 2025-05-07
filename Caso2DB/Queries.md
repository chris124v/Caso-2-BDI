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
