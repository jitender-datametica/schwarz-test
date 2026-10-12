CREATE OR REPLACE PROCEDURE fe_mstr_bge_palettierer.p_delete_shift_report_messages(IN ALERTS_DAY_SHIFT_ID FLOAT64)
BEGIN
DECLARE sql_command STRING;
DECLARE sql_commit STRING;
SET sql_command  =  '''DELETE FROM szd_core.t_fact_alerts_shift_report_per_shift_2
WHERE alerts_day_shift_id = @ALERTS_DAY_SHIFT_ID ''';

EXECUTE IMMEDIATE (sql_command) USING ALERTS_DAY_SHIFT_ID AS ALERTS_DAY_SHIFT_ID;

END;
