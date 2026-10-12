CREATE OR REPLACE PROCEDURE idq_production_fe_mstr_bge_palettierer.p_set_production_stop_fg(
  IN CAL_END_DT1 STRING,               /* end date of the alert YYYY-MM_2-DD or MM_2/DD/YYYY */
  IN ALERTS_END_TM STRING,            /* end time of the alert HH24:MI:SS */
  IN ALERTS_MESSAGE_ID FLOAT64,       /* message id of the alert: implies location_2 and priority */
  IN ALERTS_PRODUCTION_STOP_FG BOOL,  /* true: production stopped, false: production did not stop, NULL allowed */
  OUT out_param STRING)
BEGIN
DECLARE cal_end_dt_arr ARRAY<STRING(16777216)>;
DECLARE sql_check STRING;
DECLARE res_check STRING;
DECLARE sql_upd STRING;
DECLARE sql_commit STRING;
DECLARE cal_end_dt STRING;
DECLARE res_check_count INT64 DEFAULT 0;
-- convert MM_2/DD/YYYY to YYYY-MM_2-DD
SET cal_end_dt_arr  =  SPLIT(CAL_END_DT1, '/');
SET cal_end_dt  =  CAL_END_DT1;

IF (ARRAY_LENGTH(cal_end_dt_arr) = 3)
 THEN
    BEGIN
    SET cal_end_dt  =  CAST(CAL_END_DT_ARR[2] AS STRING) || '-' || CAST(CAL_END_DT_ARR[0] AS STRING) || '-' || CAST(CAL_END_DT_ARR[1] AS STRING);
    END;
END IF;

-- check if this alert exists and terminate, if not
SET sql_check  =  '''SELECT 1 AS chk FROM production_production_core.t_fact_alerts_2 WHERE cal_dt = CAST(@cal_end_dt  AS DATE) 
                     AND alerts_tm =  @ALERTS_END_TM   AND alerts_message_id = CAST( @ALERTS_MESSAGE_ID AS FLOAT64)  AND NOT alerts_deleted_fg;''';

EXECUTE IMMEDIATE (sql_check)  USING CAL_END_DT1 AS cal_end_dt,  ALERTS_END_TM AS ALERTS_END_TM,  ALERTS_MESSAGE_ID AS ALERTS_MESSAGE_ID;

SET res_check  =  '''SELECT COUNT(1) AS chk FROM production_production_core.t_fact_alerts_2 WHERE cal_dt = CAST(@cal_end_dt  AS DATE) 
                     AND alerts_tm =  @ALERTS_END_TM   AND alerts_message_id = CAST( @ALERTS_MESSAGE_ID AS FLOAT64)  AND NOT alerts_deleted_fg;''';

EXECUTE IMMEDIATE (res_check)
INTO res_check_count  USING CAL_END_DT1 AS cal_end_dt,  ALERTS_END_TM AS ALERTS_END_TM,  ALERTS_MESSAGE_ID AS ALERTS_MESSAGE_ID;

IF res_check_count <= 0 THEN
    BEGIN
    RAISE USING MESSAGE = 'Manual Alert does not exists - date, time, message ID, manual type';
    END;
END IF;

-- update the production stop flag and the timestamp


BEGIN
BEGIN TRANSACTION;
SET sql_upd  =  '''UPDATE production_production_core.t_fact_alerts_2
                   SET alerts_production_stop_fg = @ALERTS_PRODUCTION_STOP_FG,
                   dwh_updated_tmsp = CURRENT_TIMESTAMP()
                   WHERE cal_dt = @cal_end_dt 
                   AND alerts_tm = @ALERTS_END_TM 
                   AND alerts_message_id = @ALERTS_MESSAGE_ID 
                   AND alerts_deleted_fg = CAST(0 AS BOOL);''';

EXECUTE IMMEDIATE (sql_upd) USING IF(ALERTS_PRODUCTION_STOP_FG = CAST(NULL AS BOOL), CAST(NULL AS BOOL), ALERTS_PRODUCTION_STOP_FG) AS ALERTS_PRODUCTION_STOP_FG,  IF(CAL_END_DT1 = CAST(NULL AS STRING), CAST(NULL AS STRING), CAL_END_DT1) AS cal_end_dt,  IF(ALERTS_END_TM = CAST(NULL AS STRING), CAST(NULL AS STRING), ALERTS_END_TM) AS ALERTS_END_TM,  IF(ALERTS_MESSAGE_ID = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), ALERTS_MESSAGE_ID) AS ALERTS_MESSAGE_ID;

EXCEPTION
WHEN ERROR THEN
RAISE USING MESSAGE = 'Alert update failed: ' || @@ERROR.MESSAGE;
END;
-- commit the change
SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
SET out_param  =  'Succeeded';
SELECT out_param;
RETURN;
END;