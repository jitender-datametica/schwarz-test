CREATE OR REPLACE PROCEDURE dbp_macro.m_insert_ais_mandant_wup_stat_bundesamt(IN WUP_ID FLOAT64, IN STAT_BUNDESAMT_WUP_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
SET sql_stmt  =  '''INSERT INTO dbp_msi_data.ais_mandant_wup_1 (mandant_id, gp_id, wup_id, stat_bundesamt_wup_id) (SELECT 1 AS mandant_id,   5191480 AS gp_id,   CAST(@WUP_ID AS INTEGER) AS wup_id,   CAST(@STAT_BUNDESAMT_WUP_ID AS INTEGER) AS stat_bundesamt_wup_id) ''';

EXECUTE IMMEDIATE (sql_stmt) USING WUP_ID AS WUP_ID,  STAT_BUNDESAMT_WUP_ID AS STAT_BUNDESAMT_WUP_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
