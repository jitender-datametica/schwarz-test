CREATE OR REPLACE PROCEDURE dbp_macro.m_insert_msi_user(IN user_id STRING, IN msi_produkt_bez STRING, OUT out_param STRING)
BEGIN
DECLARE sql_stmt STRING;
DECLARE stmt STRING;
DECLARE res ARRAY<JSON>;
DECLARE sql_commit STRING;
DECLARE iterator_res INT64 DEFAULT -1;


BEGIN TRANSACTION;
SET sql_stmt  =  '''SELECT user_id FROM dbp_security.l_msi_user WHERE msi_produkt_bez =  @MSI_PRODUKT_BEZ   AND user_id =  @USER_ID ''';
SET stmt  =  sql_stmt;

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'USER_ID',  stmt)
INTO res  USING msi_produkt_bez AS MSI_PRODUKT_BEZ,  user_id AS USER_ID;


IF COALESCE(ARRAY_LENGTH(res), 0) <> 0 THEN
    BEGIN
    SET sql_stmt  =  'ROLLBACK TRANSACTION'    ;
    SET stmt  =  sql_stmt;

    EXECUTE IMMEDIATE (stmt);
    SET out_param  =  'ACHTUNG: Eingegebener LDAP existiert bereits';
    SELECT out_param;
    RETURN;
    END;
END IF;

SET sql_stmt  =  '''INSERT INTO dbp_security.l_msi_user (user_id, msi_produkt_bez) (SELECT UPPER(SUBSTR(TRIM(@USER_ID), 1, 2)) || LOWER(SUBSTR(TRIM(@USER_ID_1), 3, LENGTH(TRIM(@USER_ID_1_2)) - 2)), @MSI_PRODUKT_BEZ) ''';

EXECUTE IMMEDIATE (sql_stmt) USING user_id AS USER_ID,  user_id AS USER_ID_1,  user_id AS USER_ID_1_2,  msi_produkt_bez AS MSI_PRODUKT_BEZ;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
