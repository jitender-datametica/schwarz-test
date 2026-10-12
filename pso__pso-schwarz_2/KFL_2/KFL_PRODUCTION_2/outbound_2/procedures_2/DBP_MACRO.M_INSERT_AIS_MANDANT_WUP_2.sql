CREATE OR REPLACE PROCEDURE dbp_macro.m_insert_ais_mandant_wup(IN WUP_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
SET sql_stmt  =  '''INSERT INTO dbp_msi_data.ais_mandant_wup_2 (mandant_id, gp_id, wup_id) (SELECT 1 AS mandant_id,   5191480 AS gp_id,   CAST(@WUP_ID AS INTEGER) AS wup_id) ''';

EXECUTE IMMEDIATE (sql_stmt) USING WUP_ID AS WUP_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;

