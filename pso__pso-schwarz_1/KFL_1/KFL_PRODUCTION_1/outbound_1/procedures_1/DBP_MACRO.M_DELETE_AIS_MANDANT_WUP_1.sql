CREATE OR REPLACE PROCEDURE dbp_macro.m_delete_ais_mandant_wup(IN WUP_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
SET sql_stmt  =  '''DELETE FROM dbp_msi_data.ais_mandant_wup_1 WHERE mandant_id = 1 AND gp_id = 5191480 AND wup_id IS NOT NULL ''';

EXECUTE IMMEDIATE (sql_stmt) USING WUP_ID AS WUP_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
