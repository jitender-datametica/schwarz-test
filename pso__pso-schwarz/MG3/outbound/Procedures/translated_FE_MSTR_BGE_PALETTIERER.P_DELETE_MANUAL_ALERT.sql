CREATE OR REPLACE PROCEDURE idq_production_fe_mstr_bge_palettierer.p_delete_manual_alert(
  IN CAL_END_DT1 STRING,           /* end date of the alert */
  IN ALERTS_END_TM STRING,        /* end time of the alert */
  IN ALERTS_MESSAGE_ID FLOAT64,   /* message id of the alert: implies location and priority */
  IN ALERTS_DELETED_FG FLOAT64,   /* 0: don't delete (for MSTR formalities, 1: delete this message */
  OUT out_param STRING)
BEGIN
DECLARE cal_end_dt_arr ARRAY<STRING(16777216)>;   
DECLARE sql_check STRING;                         
DECLARE res_check STRING;                         
DECLARE sql_upd STRING;
DECLARE sql_commit STRING;
DECLARE cal_end_dt STRING;
DECLARE res_check_count INT64;
-- convert MM/DD/YYYY to YYYY-MM-DD
SET cal_end_dt_arr  =  SPLIT(CAL_END_DT1, '/');
SET cal_end_dt  =  CAL_END_DT1;

IF (ARRAY_LENGTH(cal_end_dt_arr) = 3)
 THEN
    BEGIN
    SET cal_end_dt  =  CAST(CAL_END_DT_ARR[2] AS STRING) || '-' || CAST(CAL_END_DT_ARR[0] AS STRING) || '-' || CAST(CAL_END_DT_ARR[1] AS STRING);
    END;
END IF;

-- check if this type=2 (manual) alert exists and terminate, if not
SET sql_check  =  '''SELECT 1 AS chk FROM production_production_core.t_fact_alerts 
                      WHERE cal_dt = CAST( @cal_end_dt  AS DATE)  AND alerts_tm =  @ALERTS_END_TM   
                      AND alerts_message_id = CAST( @ALERTS_MESSAGE_ID  AS FLOAT64)  AND alerts_type_id = 2  AND alerts_deleted_fg = CAST(0 AS BOOL);''';

EXECUTE IMMEDIATE (sql_check)  USING CAL_END_DT1 AS cal_end_dt,  ALERTS_END_TM AS ALERTS_END_TM,  ALERTS_MESSAGE_ID AS ALERTS_MESSAGE_ID;

SET res_check  =  '''SELECT COUNT(1) AS chk FROM production_production_core.t_fact_alerts 
                      WHERE cal_dt = CAST( @cal_end_dt  AS DATE)  AND alerts_tm =  @ALERTS_END_TM   
                      AND alerts_message_id = CAST( @ALERTS_MESSAGE_ID  AS FLOAT64)  AND alerts_type_id = 2  AND alerts_deleted_fg = CAST(0 AS BOOL);''';

EXECUTE IMMEDIATE (res_check) INTO res_check_count USING CAL_END_DT1 AS cal_end_dt,  ALERTS_END_TM AS ALERTS_END_TM,  ALERTS_MESSAGE_ID AS ALERTS_MESSAGE_ID ;


IF res_check_count <= 0 THEN
    BEGIN
    RAISE USING MESSAGE = 'Manual Alert does not exists - date, time, message ID, manual type';
    END;
END IF;

-- update the alerts_deleted_fg and the 

BEGIN
BEGIN TRANSACTION;
SET sql_upd  =  '''UPDATE production_production_core.t_fact_alerts 
                SET alerts_deleted_fg = CAST(CAST(@ALERTS_DELETED_FG AS INTEGER) AS BOOL),
                    dwh_updated_tmsp = CURRENT_TIMESTAMP()
                WHERE (cal_dt = CAST(@cal_end_dt AS DATE)) AND (alerts_tm = @ALERTS_END_TM )
                AND (alerts_message_id = @ALERTS_MESSAGE_ID) 
                AND alerts_type_id = 2 AND alerts_deleted_fg = CAST(0 AS BOOL);''';


EXECUTE IMMEDIATE (sql_upd) USING CAL_END_DT1 AS cal_end_dt,  ALERTS_END_TM AS ALERTS_END_TM,  ALERTS_MESSAGE_ID AS ALERTS_MESSAGE_ID,  ALERTS_DELETED_FG AS ALERTS_DELETED_FG;

EXCEPTION
WHEN ERROR THEN
RAISE USING MESSAGE = 'Set alert deleted flag failed: ' || @@ERROR.MESSAGE;
END;
-- commit the change
SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
SET out_param  =  'Succeeded';
SELECT out_param;
RETURN;
END;