/* ==============================================================
          Scripts&Queries Mantenimiento de Seguridad
   =============================================================*/

--------------------------------------------------------------
-- 1.  LOGINS  (master)
--------------------------------------------------------------
USE master;
GO
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'login_sinAcceso')
    CREATE LOGIN login_sinAcceso WITH PASSWORD = 'NoP@ss_demo1!';
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'login_read')
    CREATE LOGIN login_read      WITH PASSWORD = 'Read0nly_demo1!';
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'login_api')
    CREATE LOGIN login_api       WITH PASSWORD = 'ApiP@ss_demo1!';
GO

--------------------------------------------------------------
-- 2.  BD Caso2 (crea si falta)  y  conexión a ella
--------------------------------------------------------------
IF DB_ID(N'Caso2') IS NULL
    CREATE DATABASE Caso2;
GO
USE Caso2;
GO

--------------------------------------------------------------
-- 3.  USUARIOS  (crea o reasigna)
--------------------------------------------------------------
-- usr_noAccess  → login_sinAcceso
IF EXISTS (SELECT 1 FROM sys.database_principals WHERE name=N'usr_noAccess')
    ALTER USER usr_noAccess WITH LOGIN = login_sinAcceso;
ELSE
    CREATE USER usr_noAccess FOR LOGIN login_sinAcceso;

-- usr_readOnly  → login_read
IF EXISTS (SELECT 1 FROM sys.database_principals WHERE name=N'usr_readOnly')
    ALTER USER usr_readOnly WITH LOGIN = login_read;
ELSE
    CREATE USER usr_readOnly FOR LOGIN login_read;

-- usr_backEnd   → login_api
IF EXISTS (SELECT 1 FROM sys.database_principals WHERE name=N'usr_backEnd')
    ALTER USER usr_backEnd  WITH LOGIN = login_api;
ELSE
    CREATE USER usr_backEnd FOR  LOGIN login_api;
GO

--------------------------------------------------------------
-- 4.  ROLES  y membresías
--------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name=N'rl_catalogRead')
    CREATE ROLE rl_catalogRead;
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name=N'rl_backendApi')
    CREATE ROLE rl_backendApi;

-- miembros (solo si falta)
IF NOT EXISTS (SELECT 1 FROM sys.database_role_members
               WHERE role_principal_id = USER_ID('rl_catalogRead')
                 AND member_principal_id = USER_ID('usr_readOnly'))
    EXEC sp_addrolemember 'rl_catalogRead','usr_readOnly';

IF NOT EXISTS (SELECT 1 FROM sys.database_role_members
               WHERE role_principal_id = USER_ID('rl_backendApi')
                 AND member_principal_id = USER_ID('usr_backEnd'))
    EXEC sp_addrolemember 'rl_backendApi','usr_backEnd';
GO

--------------------------------------------------------------
-- 5.  PERMISOS
--------------------------------------------------------------
DENY CONNECT TO usr_noAccess;   -- ni ve la BD

GRANT SELECT ON dbo.SocaiSubscriptions TO rl_catalogRead;
GRANT SELECT ON dbo.SocaiServiceTypes  TO rl_catalogRead;

GRANT EXECUTE ON dbo.SocaiSP_PagarProveedorMesPasado TO rl_backendApi;
DENY  SELECT,INSERT,UPDATE,DELETE ON dbo.SocaiCommerceSettlement       TO rl_backendApi;
DENY  SELECT,INSERT,UPDATE,DELETE ON dbo.SocaiCommerceSettlementDetail TO rl_backendApi;
GO

--------------------------------------------------------------
-- 6.  ROW‑LEVEL SECURITY  (SESSION_CONTEXT N'ComId')
--------------------------------------------------------------
IF OBJECT_ID('dbo.fn_rls_Comercio','IF') IS NULL
EXEC ('CREATE FUNCTION dbo.fn_rls_Comercio(@CommerceId INT)
       RETURNS TABLE WITH SCHEMABINDING
       AS RETURN SELECT 1
                 WHERE @CommerceId = CAST(SESSION_CONTEXT(N''ComId'') AS INT);');
GO
IF NOT EXISTS (SELECT * FROM sys.security_policies WHERE name=N'Policy_Comercio')
BEGIN
    CREATE SECURITY POLICY Policy_Comercio
        ADD FILTER PREDICATE dbo.fn_rls_Comercio(CommerceId)
            ON dbo.SocaiCommerces,
        ADD FILTER PREDICATE dbo.fn_rls_Comercio(CommerceId)
            ON dbo.SocaiCommerceSettlement
    WITH (STATE = ON);
END
GO

--------------------------------------------------------------
-- 7.  CRIPTOGRAFÍA  (master‑key, certificado, llaves)
--------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys
               WHERE name = '##MS_DatabaseMasterKey##')
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'MK$Caso2_demo!';

IF NOT EXISTS (SELECT * FROM sys.certificates WHERE name = 'CertPayments')
    CREATE CERTIFICATE CertPayments WITH SUBJECT = 'Pagos Caso2';

IF NOT EXISTS (SELECT * FROM sys.asymmetric_keys WHERE name = 'AK_Payments')
    CREATE ASYMMETRIC KEY AK_Payments WITH ALGORITHM = RSA_3072;

IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = 'SK_PayToken')
    CREATE SYMMETRIC KEY SK_PayToken
      WITH ALGORITHM = AES_256
      ENCRYPTION BY CERTIFICATE CertPayments,
                     ASYMMETRIC KEY AK_Payments;
GO

--------------------------------------------------------------
-- 8.  SP para desencriptar chargeToken
--------------------------------------------------------------
IF OBJECT_ID('dbo.SocaiSP_GetToken','P') IS NOT NULL
    DROP PROCEDURE dbo.SocaiSP_GetToken;
GO
CREATE PROCEDURE dbo.SocaiSP_GetToken
    @PaymentId INT
AS
BEGIN
    SET NOCOUNT ON;
    OPEN SYMMETRIC KEY SK_PayToken DECRYPTION BY CERTIFICATE CertPayments;

    SELECT  p.PaymentId,
            CONVERT(varchar(250), DECRYPTBYKEY(p.chargeToken)) AS PlainToken
    FROM    dbo.SocaiPayments AS p
    WHERE   p.PaymentId = @PaymentId;

    CLOSE SYMMETRIC KEY SK_PayToken;
END
GO
GRANT EXECUTE ON dbo.SocaiSP_GetToken TO rl_backendApi;
GO

PRINT '=== SEGURIDAD • script aplicado sin errores ===';