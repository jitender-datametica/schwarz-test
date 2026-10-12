CREATE OR REPLACE PROCEDURE FE_MSTR_BGE_PALETTIERER.P_DELETE_MANUAL_ALERT (
    CAL_END_DT VARCHAR                /* end date of the alert */
  , ALERTS_END_TM VARCHAR             /* end time of the alert */
  , ALERTS_MESSAGE_ID FLOAT           /* message id of the alert: implies location_2 and priority */
  , ALERTS_DELETED_FG FLOAT           /* 0: don't delete (for MSTR formalities, 1: delete this message */
)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS $$
  // convert MM_2/DD/YYYY to YYYY-MM_2-DD
  var cal_end_dt_arr = CAL_END_DT.split("/");
  var cal_end_dt = CAL_END_DT;
  
  if (cal_end_dt_arr.length == 3) {
    cal_end_dt = cal_end_dt_arr[2] + "-" + cal_end_dt_arr[0] + "-" + cal_end_dt_arr[1];    
  }

  // check if this type=2 (manual) alert exists and terminate, if not
  var sql_check = "\
    SELECT 1 AS chk \
    FROM CORE.T_FACT_ALERTS_2 \
    WHERE CAL_DT = :1 \
      AND ALERTS_TM = :2 \
      AND ALERTS_MESSAGE_ID = :3 \
      AND ALERTS_TYPE_ID = 2 \
      AND ALERTS_DELETED_FG = 0 \
  ";

  var res_check = snowflake.execute({
      sqlText:sql_check,
      binds: [
        cal_end_dt                // cal_end_dt
      , ALERTS_END_TM             // alerts_tm
      , ALERTS_MESSAGE_ID         // alerts_message_id
      ]
  });

  if (res_check.getRowCount() <= 0) {
    throw ('Manual Alert does not exists - date, time, message ID, manual type');
  }

  // update the alerts_deleted_fg and the timestamp
  var sql_upd = "\
    UPDATE CORE.T_FACT_ALERTS_2 \
       SET ALERTS_DELETED_FG = :4, \
           DWH_UPDATED_TMSP = CURRENT_TIMESTAMP() \
    WHERE CAL_DT = :1 \
      AND ALERTS_TM = :2 \
      AND ALERTS_MESSAGE_ID = :3 \
      AND ALERTS_TYPE_ID = 2 \
      AND ALERTS_DELETED_FG = 0 \
  ";

  try {
   snowflake.execute({
      sqlText:sql_upd,
      binds: [
        cal_end_dt                // cal_end_dt
      , ALERTS_END_TM             // alerts_tm
      , ALERTS_MESSAGE_ID         // alerts_message_id
      , ALERTS_DELETED_FG         // alerts_deleted_fg
      ]
   }); 
  }
  catch (error) {
    throw "Set alert deleted flag failed: " + error;
  }

  // commit the change  
  var sql_commit ='COMMIT';
  snowflake.execute( {
    sqlText:sql_commit
  });
  return "Succeeded";  
$$
;