CREATE OR REPLACE PROCEDURE idq_production_fe_mstr_bge_palettierer.p_upsert_manual_alert(IN CAL_END_DT1 STRING, /* end date of the alert YYYY-MM_2-DD or MM_2/DD/YYYY */
IN ALERTS_END_TM STRING, /* end time of the alert HH24:MI:SS */
IN ALERTS_MESSAGE_ID FLOAT64, /* message id of the alert: implies location_2 and priority */
IN CAL_START_DT1 STRING, /* start date of the alert YYYY-MM_2-DD or MM_2/DD/YYYY */
IN ALERTS_START_TM STRING, /* start time of the alert HH24:MI:SS */  
IN ALERTS_PRODUCTION_STOP_FG BOOL, /* true: production stopped, false: production did not stop, NULL allowed */
OUT out_param STRING)
BEGIN
DECLARE cal_end_dt_arr ARRAY<STRING(16777216)>;
DECLARE cal_start_dt_arr ARRAY<STRING(16777216)>;
DECLARE dwh_created_tmsp STRING;
DECLARE sql_check_msg STRING;
DECLARE res_check_msg ARRAY<JSON>;
DECLARE alerts_location_id STRING;
DECLARE alerts_priority_id STRING;
DECLARE sql_shift_info STRING;
DECLARE res_shift_info ARRAY<JSON>;
DECLARE iterator_res_shift_info INT64;DECLARE alerts_day_shift_id STRING;
DECLARE alerts_duration_diff STRING;
DECLARE sql_check_dupl STRING;
DECLARE res_check_dupl ARRAY<JSON>;
DECLARE sql_del STRING;
DECLARE sql_ins_alert STRING;
DECLARE sql_commit STRING;
DECLARE iterator_res_check_msg INT64 DEFAULT -1;
DECLARE iterator_res_check_dupl INT64 DEFAULT -1;
DECLARE cal_end_dt STRING;
DECLARE cal_start_dt STRING;
BEGIN TRANSACTION;
-- convert MM_2/DD/YYYY to YYYY-MM_2-DD
SET cal_end_dt_arr  =  SPLIT(CAL_END_DT1, '/');
SET cal_start_dt_arr  =  SPLIT(CAL_START_DT1, '/');
SET cal_end_dt  =  CAL_END_DT1;
SET cal_start_dt  =  CAL_START_DT1;
SET dwh_created_tmsp  =  null;

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

-- check if exactly one referenced type 2 (manual) message exists, terminate otherwise
SET sql_check_msg  =  '''SELECT msg.alerts_location_id,  msg.alerts_priority_id FROM production_production_core.t_dim_alerts_message_2 AS msg WHERE alerts_message_id = CAST( @ALERTS_MESSAGE_ID  AS FLOAT64)  AND alerts_type_id = 2 ''';

EXECUTE IMMEDIATE format('''
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
''',  'ALERTS_LOCATION_ID,ALERTS_PRIORITY_ID',  sql_check_msg)
INTO res_check_msg  USING ALERTS_MESSAGE_ID AS ALERTS_MESSAGE_ID;


IF COALESCE(ARRAY_LENGTH(res_check_msg), 0) <= 0 THEN
    BEGIN
    RAISE USING MESSAGE = 'Incorrect message ID - must be an existing manual type message';
    END;
END IF;


IF COALESCE(ARRAY_LENGTH(res_check_msg), 0) > 1 THEN
    BEGIN
    RAISE USING MESSAGE = 'Too many messages for this message ID - exactly one expected';
    END;
END IF;

-- get the location_2 and priority from the message
SET iterator_res_check_msg  =  iterator_res_check_msg  + 1;
SET alerts_location_id  =  JSON_EXTRACT_SCALAR(res_check_msg[SAFE_OFFSET(iterator_res_check_msg)], '$[0]');
SET alerts_priority_id  =  JSON_EXTRACT_SCALAR(res_check_msg[SAFE_OFFSET(iterator_res_check_msg)], '$[1]');
-- determine the shift this message terminates in
-- use this also to calculate the time difference


SET sql_shift_info = '''SELECT alerts_day_shift_id,
 TIMESTAMP_DIFF(CAST(@cal_end_dt || ' ' || @ALERTS_END_TM AS DATETIME), CAST(@cal_start_dt || ' ' || @ALERTS_START_TM AS DATETIME)
  ,SECOND) AS alerts_duration_diff
FROM production_production_core.t_dim_alerts_day_shift_2 AS shft
WHERE (@cal_end_dt || ' ' || @ALERTS_END_TM) BETWEEN CAST(alerts_day_shift_start_dt AS STRING) || ' ' || CAST(alerts_day_shift_start_tm AS STRING)
   AND (CAST(alerts_day_shift_end_dt AS STRING) || ' ' || CAST(alerts_day_shift_end_tm AS STRING))''';



EXECUTE IMMEDIATE format('''
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
''',  'ALERTS_DAY_SHIFT_ID,ALERTS_DURATION_DIFF',  sql_shift_info)
INTO res_shift_info  USING CAL_END_DT AS cal_end_dt,  ALERTS_END_TM AS ALERTS_END_TM,  CAL_START_DT AS cal_start_dt,  ALERTS_START_TM AS ALERTS_START_TM;

IF COALESCE(ARRAY_LENGTH(res_shift_info), 0) <= 0 THEN
    BEGIN
    RAISE USING MESSAGE = 'No shift information found for this end date and end time';
    END;
END IF;

IF COALESCE(ARRAY_LENGTH(res_shift_info), 0) > 1 THEN
    BEGIN
    RAISE USING MESSAGE = 'Too many shifts for this end date and end time - exactly one expected';
    END;
END IF;


SET iterator_res_shift_info  =  iterator_res_shift_info  + 1;
SET alerts_day_shift_id  =  JSON_EXTRACT_SCALAR(res_shift_info[SAFE_OFFSET(iterator_res_shift_info)], '$[0]');
SET alerts_duration_diff  =  JSON_EXTRACT_SCALAR(res_shift_info[SAFE_OFFSET(iterator_res_shift_info)], '$[1]');
-- check for already existing (duplicate) alerts
SET sql_check_dupl  =  '''SELECT dwh_created_tmsp FROM production_production_core.t_fact_alerts_2 WHERE cal_dt = CAST( @cal_end_dt  AS DATE)  AND alerts_tm =  @ALERTS_END_TM  AND alerts_message_id = CAST( @ALERTS_MESSAGE_ID  AS FLOAT64)  AND NOT alerts_deleted_fg ''';

EXECUTE IMMEDIATE format('''
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
''',  'DWH_CREATED_TMSP',  sql_check_dupl)
INTO res_check_dupl  USING CAL_END_DT1 AS cal_end_dt,  ALERTS_END_TM AS ALERTS_END_TM,  ALERTS_MESSAGE_ID AS ALERTS_MESSAGE_ID;


IF COALESCE(ARRAY_LENGTH(res_check_dupl), 0) > 0 THEN
    BEGIN
    SET iterator_res_check_dupl  =  iterator_res_check_dupl  + 1    ;
    SET dwh_created_tmsp  =  JSON_EXTRACT_SCALAR(res_check_dupl[SAFE_OFFSET(iterator_res_check_dupl)], '$[0]')    ;
    END;
END IF;

-- delete any alerts with the same key
SET sql_del = ''' DELETE FROM production_production_core.t_fact_alerts_2
WHERE cal_dt = CAST(@cal_end_dt AS DATE) AND alerts_tm = @ALERTS_END_TM AND alerts_message_id = CAST(@ALERTS_MESSAGE_ID AS FLOAT64)''';



BEGIN

EXECUTE IMMEDIATE (sql_del) USING CAL_END_DT1 AS cal_end_dt,  ALERTS_END_TM AS ALERTS_END_TM,  ALERTS_MESSAGE_ID AS ALERTS_MESSAGE_ID;

EXCEPTION
WHEN ERROR THEN
RAISE USING MESSAGE = 'Remove deleted alert failed: ' || @@ERROR.MESSAGE;
END;
-- now, finally: insert the new alert
SET sql_ins_alert = '''INSERT INTO production_production_core.t_fact_alerts_2 (alerts_priority_id, alerts_message_id, alerts_type_id, cal_dt,
 alerts_day_shift_id, alerts_location_id, alerts_tm, alerts_duration_diff, alerts_production_stop_fg, alerts_deleted_fg
 , dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id)
(SELECT CAST(@alerts_priority_id AS INTEGER) AS alerts_priority_id,
  CAST(@ALERTS_MESSAGE_ID AS INTEGER) AS alerts_message_id,
  CAST(2.0 AS INTEGER) AS alerts_type_id,
  DATE(@cal_end_dt) AS cal_dt,
  CAST(@alerts_day_shift_id AS INTEGER) AS alerts_day_shift_id,
  CAST(@alerts_location_id AS INTEGER) AS alerts_location_id,
  CAST(@ALERTS_END_TM AS TIME) AS alerts_tm,
  CAST(@alerts_duration_diff AS INTEGER) AS alerts_duration_diff,
  CAST(NULL AS BOOL) AS alerts_production_stop_fg,
  FALSE AS alerts_deleted_fg,
  CAST(COALESCE(CAST(@dwh_created_tmsp AS TIMESTAMP), CURRENT_TIMESTAMP()) AS TIMESTAMP) AS
  dwh_created_tmsp,
  CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
  CAST(- 1 AS STRING) AS dwh_load_id)''';

BEGIN

EXECUTE IMMEDIATE (sql_ins_alert) USING IF(alerts_priority_id = CAST(NULL AS STRING), CAST(NULL AS STRING), alerts_priority_id) AS alerts_priority_id,  IF(ALERTS_MESSAGE_ID = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), ALERTS_MESSAGE_ID) AS ALERTS_MESSAGE_ID,   IF(CAL_END_DT1 = CAST(NULL AS STRING), CAST(NULL AS STRING), CAL_END_DT1) AS cal_end_dt,  IF(alerts_day_shift_id = CAST(NULL AS STRING), CAST(NULL AS STRING), alerts_day_shift_id) AS alerts_day_shift_id,  IF(alerts_location_id = CAST(NULL AS STRING), CAST(NULL AS STRING), alerts_location_id) AS alerts_location_id,  IF(ALERTS_END_TM = CAST(NULL AS STRING), CAST(NULL AS STRING), ALERTS_END_TM) AS ALERTS_END_TM,  IF(alerts_duration_diff = CAST(NULL AS STRING), CAST(NULL AS STRING), alerts_duration_diff) AS alerts_duration_diff,  IF(ALERTS_PRODUCTION_STOP_FG = CAST(NULL AS BOOL), CAST(NULL AS BOOL), ALERTS_PRODUCTION_STOP_FG) AS ALERTS_PRODUCTION_STOP_FG,  IF(dwh_created_tmsp = CAST(NULL AS STRING), CAST(NULL AS STRING), dwh_created_tmsp) AS dwh_created_tmsp;

EXCEPTION
WHEN ERROR THEN
RAISE USING MESSAGE = 'Alert insert failed: ' || @@ERROR.MESSAGE;
END;
-- commit the changes
SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
SET out_param  =  'Succeeded';
RETURN;
END;