/* ===================================================================
                    Scripts&Queries Concurrencia
   ===================================================================*/

USE Caso2;
GO
SET NOCOUNT ON;

/*─────────────────────────────────────────────────────────────────────
  1. ESCENARIO DE DEAD‑LOCK (dos sesiones)
  -------------------------------------------------------------------*/
IF OBJECT_ID('dbo.DL_A','P') IS NOT NULL DROP PROCEDURE dbo.DL_A;
GO
CREATE PROCEDURE dbo.DL_A AS
BEGIN
    BEGIN TRAN;
        SELECT * FROM dbo.SocaiCommerceSettlement WHERE CommerceId = 1;
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
        SELECT * FROM dbo.SocaiCommerceSettlement WHERE CommerceId = 1;
    COMMIT;
END;
GO


/*─────────────────────────────────────────────────────────────────────
  2. DEAD‑LOCK EN CASCADA (tres sesiones)
  -------------------------------------------------------------------*/
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


/*─────────────────────────────────────────────────────────────────────
  3. DEMO NIVELES DE AISLAMIENTO
  -------------------------------------------------------------------*/
IF OBJECT_ID('dbo.demo_isolation','P') IS NOT NULL
    DROP PROCEDURE dbo.demo_isolation;
GO
CREATE PROCEDURE dbo.demo_isolation
    @level sysname = 'READ COMMITTED'   
AS
BEGIN
    
    IF      @level = 'READ UNCOMMITTED'  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    ELSE IF @level = 'REPEATABLE READ'   SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    ELSE IF @level = 'SERIALIZABLE'      SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    ELSE                                 SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

    BEGIN TRAN;
        SELECT COUNT(*) AS totalAntes FROM dbo.SocaiPayments;
        WAITFOR DELAY '00:00:05';
        SELECT COUNT(*) AS totalDespues FROM dbo.SocaiPayments;
    ROLLBACK;
END;
GO


/*─────────────────────────────────────────────────────────────────────
  4. CURSOR DE UPDATE (fila‑a‑fila)
  -------------------------------------------------------------------*/
IF OBJECT_ID('dbo.demo_cursorRegeneraSaldo','P') IS NOT NULL
    DROP PROCEDURE dbo.demo_cursorRegeneraSaldo;
GO
CREATE PROCEDURE dbo.demo_cursorRegeneraSaldo AS
BEGIN
    DECLARE c CURSOR LOCAL FOR
        SELECT SuscriptionUserId
        FROM   dbo.SocaiBalancePerPerson
        ORDER  BY SuscriptionUserId;

    DECLARE @id INT;
    OPEN c;
    FETCH NEXT FROM c INTO @id;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE dbo.SocaiBalancePerPerson
           SET updatedAt = GETDATE()
         WHERE CURRENT OF c;

        WAITFOR DELAY '00:00:02';
        FETCH NEXT FROM c INTO @id;
    END;
    CLOSE c; DEALLOCATE c;
END;
GO


/*─────────────────────────────────────────────────────────────────────
  5. TRANSACCIÓN DE VOLUMEN  (benchmark TPS)
  -------------------------------------------------------------------*/
IF OBJECT_ID('dbo.bench_volumenPago','P') IS NOT NULL
    DROP PROCEDURE dbo.bench_volumenPago;
GO
CREATE PROCEDURE dbo.bench_volumenPago
    @segundos INT = 10
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


/*─────────────────────────────────────────────────────────────────────
  6. VISTA AUXILIAR: nivel de aislamiento de la sesión
  -------------------------------------------------------------------*/
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
             WHEN 4 THEN 'SNAPSHOT' END  AS isolation_level,
        last_request_start_time
FROM sys.dm_exec_sessions
WHERE is_user_process = 1;
GO