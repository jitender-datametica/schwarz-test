CREATE OR REPLACE PROCEDURE FE_MSTR_BGE_PALETTIERER.P_SET_PRODUCTION_STOP_FG (
    CAL_END_DT VARCHAR                /* end date of the alert YYYY-MM_1-DD or MM_1/DD/YYYY */
  , ALERTS_END_TM VARCHAR             /* end time of the alert HH24:MI:SS */
  , ALERTS_MESSAGE_ID FLOAT           /* message id of the alert: implies location_1 and priority */
  , ALERTS_PRODUCTION_STOP_FG BOOLEAN /* true: production stopped, false: production did not stop, NULL allowed */
)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS $$
  // convert MM_1/DD/YYYY to YYYY-MM_1-DD
  var cal_end_dt_arr = CAL_END_DT.split("/");
  var cal_end_dt = CAL_END_DT;

  if (cal_end_dt_arr.length == 3) {
    cal_end_dt = cal_end_dt_arr[2] + "-" + cal_end_dt_arr[0] + "-" + cal_end_dt_arr[1];    
  }

  // check if this alert exists and terminate, if not
  var sql_check = "\
    SELECT 1 AS chk \
    FROM CORE.T_FACT_ALERTS_1 \
    WHERE CAL_DT = :1 \
      AND ALERTS_TM = :2 \
      AND ALERTS_MESSAGE_ID = :3 \
      AND ALERTS_DELETED_FG = 0 \
  ";

  var res_check = snowflake.execute({
      sqlText:sql_check,
      binds: [
        cal_end_dt                // cal_end_dt
      , ALERTS_END_TM             // alerts_end_tm
      , ALERTS_MESSAGE_ID         // alerts_message_id
      ]
  });

  if (res_check.getRowCount() <= 0) {
    throw ('Alert does not exists - date, time, message ID');
  }

  // update the production stop flag and the timestamp  
  var sql_upd = "\
    UPDATE CORE.T_FACT_ALERTS_1 \
       SET ALERTS_PRODUCTION_STOP_FG = :1, \
           DWH_UPDATED_TMSP = CURRENT_TIMESTAMP() \
    WHERE CAL_DT = :2 \
      AND ALERTS_TM = :3 \
      AND ALERTS_MESSAGE_ID = :4 \
      AND ALERTS_DELETED_FG = 0 \
  ";

  try {
   snowflake.execute({
      sqlText:sql_upd,
      binds: [
        ALERTS_PRODUCTION_STOP_FG // alerts_production_stop_fg      
      , cal_end_dt                // cal_end_dt
      , ALERTS_END_TM             // alerts_end_tm
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