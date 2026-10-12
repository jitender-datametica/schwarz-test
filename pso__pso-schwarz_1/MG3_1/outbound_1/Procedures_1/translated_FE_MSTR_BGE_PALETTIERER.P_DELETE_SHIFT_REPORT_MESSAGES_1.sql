CREATE OR REPLACE PROCEDURE idq_production_fe_mstr_bge_palettierer.p_delete_shift_report_messages(IN ALERTS_DAY_SHIFT_ID FLOAT64)
BEGIN
DECLARE sql_command STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
SET sql_command  =  '''DELETE FROM production_production_core.t_fact_alerts_shift_report_per_shift_1 WHERE alerts_day_shift_id = @ALERTS_DAY_SHIFT_ID;''';

EXECUTE IMMEDIATE (sql_command) USING ALERTS_DAY_SHIFT_ID AS ALERTS_DAY_SHIFT_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;