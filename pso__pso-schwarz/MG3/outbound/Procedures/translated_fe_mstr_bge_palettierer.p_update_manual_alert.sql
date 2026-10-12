CREATE OR REPLACE PROCEDURE idq_production_fe_mstr_bge_palettierer.p_update_manual_alert(IN CAL_END_DT1 STRING, /* end date of the alert YYYY-MM-DD or MM/DD/YYYY */
IN ALERTS_END_TM STRING, /* end time of the alert HH24:MI:SS */
IN ALERTS_MESSAGE_ID FLOAT64,  /* message id of the alert: implies location and priority */
IN CAL_START_DT1 STRING,  /* start date of the alert YYYY-MM-DD or MM/DD/YYYY */
IN ALERTS_START_TM STRING, /* start time of the alert HH24:MI:SS */ 
IN ALERTS_PRODUCTION_STOP_FG BOOL, /* true: production stopped, false: production did not stop, NULL allowed */
OUT out_param STRING)
BEGIN
DECLARE cal_end_dt_arr ARRAY<STRING(16777216)>;
DECLARE cal_start_dt_arr ARRAY<STRING(16777216)>;
DECLARE sql_check STRING;
DECLARE res_check  ARRAY<JSON> ;
DECLARE iterator_res_check INT64;
DECLARE alerts_duration_diff STRING;
DECLARE sql_upd STRING;
DECLARE sql_commit STRING;
DECLARE cal_end_dt STRING;
DECLARE cal_start_dt STRING;
-- convert MM/DD/YYYY to YYYY-MM-DD
BEGIN TRANSACTION;
SET cal_end_dt_arr  =  SPLIT(CAL_END_DT1, '/');
SET cal_start_dt_arr  =  SPLIT(CAL_START_DT1, '/');
SET cal_end_dt  =  CAL_END_DT1;
SET cal_start_dt  =  CAL_START_DT1;

IF (ARRAY_LENGTH(cal_end_dt_arr) = 3)
 THEN
    BEGIN
    SET cal_end_dt  =  CAST(CAL_END_DT_ARR[2] AS STRING) || '-' || CAST(CAL_END_DT_ARR[0] AS STRING) || '-' || CAST(CAL_END_DT_ARR[1] AS STRING);
    END;
END IF;


IF (ARRAY_LENGTH(cal_start_dt_arr) = 3)
 THEN
    BEGIN
    SET cal_start_dt  =  CAST(CAL_START_DT_ARR[2] AS STRING) || '-' || CAST(CAL_START_DT_ARR[0] AS STRING) || '-' || CAST(CAL_START_DT_ARR[1] AS STRING);
    END;
END IF;


IF CAL_START_DT1 || ALERTS_START_TM > CAL_END_DT1 || ALERTS_END_TM THEN
    BEGIN
    RAISE USING MESSAGE = 'Parameter error: Start date and time greater than End date and time';
    END;
END IF;

-- check if this type=2 (manual) alert exists and terminate, if not
-- also use this to calculate the time difference

SET sql_check = '''SELECT TIMESTAMP_DIFF(CAST(@cal_end_dt || ' ' || @ALERTS_END_TM AS DATETIME), CAST(@cal_start_dt || ' ' || @ALERTS_START_TM AS DATETIME)
  ,SECOND) AS alerts_duration_diff
FROM production_production_core.t_fact_alerts
WHERE cal_dt = CAST(@cal_end_dt AS DATE)
 AND alerts_tm = @ALERTS_END_TM
 AND alerts_message_id = CAST(@ALERTS_MESSAGE_ID AS FLOAT64)
 AND alerts_type_id = 2
 AND NOT alerts_deleted_fg''';


EXECUTE IMMEDIATE format('''
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
''',  'ALERTS_DURATION_DIFF',  sql_check)
INTO res_check  USING CAL_END_DT AS cal_end_dt,  ALERTS_END_TM AS ALERTS_END_TM,  ALERTS_MESSAGE_ID AS ALERTS_MESSAGE_ID,  CAL_START_DT AS cal_start_dt,  ALERTS_START_TM AS ALERTS_START_TM;


IF COALESCE(ARRAY_LENGTH(res_check), 0) <= 0 THEN
    BEGIN
    RAISE USING MESSAGE = 'Manual Alert does not exists - date, time, message ID, manual type';
    END;
END IF;

SET iterator_res_check  =  iterator_res_check  + 1;
SET alerts_duration_diff  =  JSON_EXTRACT_SCALAR(res_check[SAFE_OFFSET(iterator_res_check)], '$[0]');


-- update the duration difference, the production stop flag and the timestamp

SET sql_upd = '''UPDATE production_production_core.t_fact_alerts SET
 alerts_duration_diff = CAST(@alerts_duration_diff AS INTEGER),
 alerts_production_stop_fg = CAST(@ALERTS_PRODUCTION_STOP_FG AS BOOL),
 dwh_updated_tmsp = CURRENT_TIMESTAMP()
WHERE cal_dt = CAST(@cal_end_dt AS DATE) AND alerts_tm = @ALERTS_END_TM AND alerts_message_id = CAST(@ALERTS_MESSAGE_ID AS FLOAT64)
     AND alerts_type_id = 2 AND NOT alerts_deleted_fg''';



BEGIN

EXECUTE IMMEDIATE (sql_upd) USING IF(alerts_duration_diff = CAST(NULL AS STRING), CAST(NULL AS STRING), alerts_duration_diff) AS alerts_duration_diff,  IF(ALERTS_PRODUCTION_STOP_FG = CAST(NULL AS BOOL), CAST(NULL AS BOOL), ALERTS_PRODUCTION_STOP_FG) AS ALERTS_PRODUCTION_STOP_FG,  IF(CAL_END_DT1 = CAST(NULL AS STRING), CAST(NULL AS STRING), CAL_END_DT1) AS cal_end_dt,  IF(ALERTS_END_TM = CAST(NULL AS STRING), CAST(NULL AS STRING), ALERTS_END_TM) AS ALERTS_END_TM,  IF(ALERTS_MESSAGE_ID = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), ALERTS_MESSAGE_ID) AS ALERTS_MESSAGE_ID;

EXCEPTION
WHEN ERROR THEN
RAISE USING MESSAGE = 'Alert update failed: ' || @@ERROR.MESSAGE;
END;
-- commit the change
SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
SET out_param  =  'Succeeded';
RETURN;
END;