CREATE OR REPLACE PROCEDURE FE_MSTR_BGE_PALETTIERER.P_UPDATE_MANUAL_ALERT (
    CAL_END_DT VARCHAR                /* end date of the alert YYYY-MM_1-DD or MM_1/DD/YYYY */
  , ALERTS_END_TM VARCHAR             /* end time of the alert HH24:MI:SS */
  , ALERTS_MESSAGE_ID FLOAT           /* message id of the alert: implies location_1 and priority */
  , CAL_START_DT VARCHAR              /* start date of the alert YYYY-MM_1-DD or MM_1/DD/YYYY */
  , ALERTS_START_TM VARCHAR           /* start time of the alert HH24:MI:SS */ 
  , ALERTS_PRODUCTION_STOP_FG BOOLEAN /* true: production stopped, false: production did not stop, NULL allowed */
)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS $$
  // convert MM_1/DD/YYYY to YYYY-MM_1-DD
  var cal_end_dt_arr   = CAL_END_DT.split("/");
  var cal_start_dt_arr = CAL_START_DT.split("/");  
  var cal_end_dt = CAL_END_DT;
  var cal_start_dt = CAL_START_DT;  
  
  if (cal_end_dt_arr.length == 3) {
    cal_end_dt = cal_end_dt_arr[2] + "-" + cal_end_dt_arr[0] + "-" + cal_end_dt_arr[1];    
  }
  if (cal_start_dt_arr.length == 3) {
    cal_start_dt = cal_start_dt_arr[2] + "-" + cal_start_dt_arr[0] + "-" + cal_start_dt_arr[1];    
  }
  
  if ((cal_start_dt + ALERTS_START_TM) > (cal_end_dt + ALERTS_END_TM)) {
    throw ('Parameter error: Start date and time greater than End date and time')
  }

  // check if this type=2 (manual) alert exists and terminate, if not
  // also use this to calculate the time difference
  var sql_check = "\
    SELECT TIMESTAMPDIFF(SECOND,(:4||' '||:5), (:1||' '||:2)) AS ALERTS_DURATION_DIFF \
    FROM CORE.T_FACT_ALERTS_1 \
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
      , ALERTS_END_TM             // alerts_end_tm
      , ALERTS_MESSAGE_ID         // alerts_message_id
      , cal_start_dt              // cal_start_dt
      , ALERTS_START_TM           // alerts_start_tm      
      ]
  });

  if (res_check.getRowCount() <= 0) {
    throw ('Manual Alert does not exists - date, time, message ID, manual type');
  }
  
  res_check.next();
  var alerts_duration_diff = res_check.getColumnValue(1); 

  // update the duration difference, the production stop flag and the timestamp
  var sql_upd = "\
    UPDATE CORE.T_FACT_ALERTS_1 \
       SET ALERTS_DURATION_DIFF = :1, \
           ALERTS_PRODUCTION_STOP_FG = :2, \
           DWH_UPDATED_TMSP = CURRENT_TIMESTAMP() \
    WHERE CAL_DT = :3 \
      AND ALERTS_TM = :4 \
      AND ALERTS_MESSAGE_ID = :5 \
      AND ALERTS_TYPE_ID = 2 \
      AND ALERTS_DELETED_FG = 0 \
  ";

  try {
   snowflake.execute({
      sqlText:sql_upd,
      binds: [
        alerts_duration_diff      // alerts_duration_diff
      , ALERTS_PRODUCTION_STOP_FG // alerts_production_stop_fg      
      , cal_end_dt                // cal_end_dt
      , ALERTS_END_TM             // alerts_tm
      , ALERTS_MESSAGE_ID         // alerts_message_id
      ].map(function(x){return x===undefined?null:x})
   }); 
  }
  catch (error) {
    throw "Alert update failed: " + error;
  }

  // commit the change
  var sql_commit ='COMMIT';
  snowflake.execute( {
    sqlText:sql_commit
  });
  return "Succeeded";  
$$
;