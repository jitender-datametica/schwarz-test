CREATE OR REPLACE PROCEDURE fe_mstr_bge_palettierer.p_set_production_stop_fg(IN CAL_END_DT STRING, IN ALERTS_END_TM STRING, IN ALERTS_MESSAGE_ID FLOAT64, IN ALERTS_PRODUCTION_STOP_FG BOOL, OUT out_param STRING)
BEGIN
DECLARE cal_end_dt_arr ARRAY<STRING(16777216)>;
DECLARE sql_check STRING;
DECLARE res_check ARRAY<JSON>;
DECLARE sql_upd STRING;
DECLARE sql_commit STRING;
DECLARE iterator_res_check INT64 DEFAULT -1;
-- convert MM/DD/YYYY to YYYY-MM-DD

SET cal_end_dt_arr  =  SPLIT(CAL_END_DT, '/');
SET cal_end_dt  =  CAL_END_DT;

IF (ARRAY_LENGTH(cal_end_dt_arr) = 3)
 THEN
    BEGIN
    SET CAL_END_DT  =  cal_end_dt_arr[2] || '-' || cal_end_dt_arr[0] || '-' || cal_end_dt_arr[1];
    END;
END IF;

-- check if this alert exists and terminate, if not

SET sql_check  =  '''SELECT 1 AS chk
FROM szd_core.t_fact_alerts
WHERE cal_dt = CAST(@CAL_END_DT AS DATE)
 AND alerts_tm = CAST(TRIM(@ALERTS_END_TM) AS TIME)
 AND alerts_message_id = @ALERTS_MESSAGE_ID
 AND NOT alerts_deleted_fg ''';

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'chk',  sql_check)
INTO res_check  USING CAL_END_DT AS CAL_END_DT,  ALERTS_END_TM AS ALERTS_END_TM,  ALERTS_MESSAGE_ID AS ALERTS_MESSAGE_ID;

IF COALESCE(CAST(ARRAY_LENGTH(res_check) AS BIGNUMERIC), 0) <= 0 THEN
    BEGIN
    RAISE USING MESSAGE = 'Alert does not exists - date, time, message ID';
    END;
END IF;

-- update the production stop flag and the timestamp

SET sql_upd  =  '''UPDATE szd_core.t_fact_alerts SET
 alerts_production_stop_fg = @ALERTS_PRODUCTION_STOP_FG,
 dwh_updated_tmsp = CURRENT_TIMESTAMP()
WHERE cal_dt = CAST(@CAL_END_DT AS DATE) AND alerts_tm = CAST(TRIM(@ALERTS_END_TM) AS TIME) AND
   alerts_message_id = @ALERTS_MESSAGE_ID AND NOT alerts_deleted_fg ''';
BEGIN

EXECUTE IMMEDIATE (sql_upd) USING IF(ALERTS_PRODUCTION_STOP_FG = CAST(NULL AS BOOL), CAST(NULL AS BOOL), ALERTS_PRODUCTION_STOP_FG) AS ALERTS_PRODUCTION_STOP_FG,  IF(CAL_END_DT = CAST(NULL AS STRING), CAST(NULL AS STRING), CAL_END_DT) AS CAL_END_DT,  IF(ALERTS_END_TM = CAST(NULL AS STRING), CAST(NULL AS STRING), ALERTS_END_TM) AS ALERTS_END_TM,  IF(ALERTS_MESSAGE_ID = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), ALERTS_MESSAGE_ID) AS ALERTS_MESSAGE_ID;

EXCEPTION
WHEN ERROR THEN
RAISE USING MESSAGE = 'Alert update failed: ' || @@ERROR.MESSAGE;
END;
SET out_param  =  'Succeeded';
SELECT out_param;
RETURN;
END;