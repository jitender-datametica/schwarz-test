CREATE OR REPLACE PROCEDURE kfl_production_dbp_macro.m_insert_msi_user(IN USER_ID STRING, IN MSI_PRODUKT_BEZ STRING, OUT out_param STRING)
BEGIN 
DECLARE sql_stmt STRING;
DECLARE stmt STRING;
DECLARE res ARRAY<JSON>;
DECLARE sql_commit STRING;
DECLARE iterator_res INT64 DEFAULT -1;
BEGIN TRANSACTION;
SET sql_stmt  =  '''SELECT user_id FROM kfl_production_dbp_security.l_msi_user_2 WHERE msi_produkt_bez IS NOT NULL  AND user_id IS NOT NULL ''';
SET stmt  =  sql_stmt;

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'USER_ID',  stmt)
INTO res  USING MSI_PRODUKT_BEZ AS MSI_PRODUKT_BEZ,  USER_ID AS USER_ID;

IF COALESCE(ARRAY_LENGTH(res), 0) <> 0 THEN
    BEGIN
    SET sql_stmt  =  'ROLLBACK TRANSACTION'    ;
    SET stmt  =  sql_stmt;

    EXECUTE IMMEDIATE stmt;
    SET out_param  =  'ACHTUNG: Eingegebener LDAP existiert bereits';
    SELECT out_param;
    RETURN;
    END;
END IF;
BEGIN TRANSACTION;
SET sql_stmt  =  '''INSERT INTO kfl_production_dbp_security.l_msi_user_2 (user_id, msi_produkt_bez) (SELECT UPPER(SUBSTR(TRIM(@USER_ID), 1, 2)) || LOWER(SUBSTR(TRIM(@USER_ID_1), 3, LENGTH(TRIM(@USER_ID_1_2)) - 2)),   @MSI_PRODUKT_BEZ AS msi_produkt_bez) ''';

EXECUTE IMMEDIATE (sql_stmt) USING USER_ID AS USER_ID,  USER_ID AS USER_ID_1,  USER_ID AS USER_ID_1_2,  MSI_PRODUKT_BEZ AS MSI_PRODUKT_BEZ;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;