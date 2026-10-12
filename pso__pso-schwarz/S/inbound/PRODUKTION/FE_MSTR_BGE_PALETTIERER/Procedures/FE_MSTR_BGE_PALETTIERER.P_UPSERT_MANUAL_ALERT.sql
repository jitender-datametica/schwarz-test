CREATE OR REPLACE PROCEDURE FE_MSTR_BGE_PALETTIERER.P_UPSERT_MANUAL_ALERT (
    CAL_END_DT VARCHAR                /* end date of the alert YYYY-MM-DD or MM/DD/YYYY */
  , ALERTS_END_TM VARCHAR             /* end time of the alert HH24:MI:SS */
  , ALERTS_MESSAGE_ID FLOAT           /* message id of the alert: implies location and priority */
  , CAL_START_DT VARCHAR              /* start date of the alert YYYY-MM-DD or MM/DD/YYYY */
  , ALERTS_START_TM VARCHAR           /* start time of the alert HH24:MI:SS */  
  , ALERTS_PRODUCTION_STOP_FG BOOLEAN /* true: production stopped, false: production did not stop, NULL allowed */
)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS $$
  // convert MM/DD/YYYY to YYYY-MM-DD
  var cal_end_dt_arr   = CAL_END_DT.split("/");
  var cal_start_dt_arr = CAL_START_DT.split("/");  
  var cal_end_dt = CAL_END_DT;
  var cal_start_dt = CAL_START_DT;
  var dwh_created_tmsp = undefined;  
  
  if (cal_end_dt_arr.length == 3) {
    cal_end_dt = cal_end_dt_arr[2] + "-" + cal_end_dt_arr[0] + "-" + cal_end_dt_arr[1];    
  }
  if (cal_start_dt_arr.length == 3) {
    cal_start_dt = cal_start_dt_arr[2] + "-" + cal_start_dt_arr[0] + "-" + cal_start_dt_arr[1];    
  }
  
  if ((cal_start_dt + ALERTS_START_TM) > (cal_end_dt + ALERTS_END_TM)) {
    throw ('Parameter error: Start date and time greater than End date and time')
  }

  // check if exactly one referenced type 2 (manual) message exists, terminate otherwise
  var sql_check_msg = "\
    SELECT \
      MSG.ALERTS_LOCATION_ID \
    , MSG.ALERTS_PRIORITY_ID \
    FROM CORE.T_DIM_ALERTS_MESSAGE AS MSG \
    WHERE MSG.ALERTS_MESSAGE_ID = :1 \
      AND MSG.ALERTS_TYPE_ID = 2 \
  ";
  
  var res_check_msg = snowflake.execute({
      sqlText:sql_check_msg,
      binds: [
        ALERTS_MESSAGE_ID         // alerts_message_id
      ]
  });
  
  if (res_check_msg.getRowCount() <= 0) {
    throw ('Incorrect message ID - must be an existing manual type message');
  }  
  if (res_check_msg.getRowCount() > 1) {
    throw ('Too many messages for this message ID - exactly one expected');
  }  

  // get the location and priority from the message
  res_check_msg.next();
  var alerts_location_id = res_check_msg.getColumnValue(1);
  var alerts_priority_id = res_check_msg.getColumnValue(2);
  
  // determine the shift this message terminates in
  // use this also to calculate the time difference
  var sql_shift_info = "\
    SELECT \
      SHFT.ALERTS_DAY_SHIFT_ID \
    , TIMESTAMPDIFF(SECOND,(:3||' '||:4), (:1||' '||:2)) AS ALERTS_DURATION_DIFF \
    FROM CORE.T_DIM_ALERTS_DAY_SHIFT AS SHFT \
    WHERE (:1 ||' '|| :2) BETWEEN \
        ALERTS_DAY_SHIFT_START_DT||' '||ALERTS_DAY_SHIFT_START_TM AND \
        ALERTS_DAY_SHIFT_END_DT||' '||ALERTS_DAY_SHIFT_END_TM \
  ";
  
  var res_shift_info = snowflake.execute({
      sqlText:sql_shift_info,
      binds: [
        cal_end_dt                // cal_end_dt
      , ALERTS_END_TM             // alerts_end_tm
      , cal_start_dt              // cal_start_dt
      , ALERTS_START_TM          // alerts_start_tm
      ]
  });
  
  if (res_shift_info.getRowCount() <= 0) {
    throw ('No shift information found for this end date and end time');
  }
  if (res_shift_info.getRowCount() > 1) {
    throw ('Too many shifts for this end date and end time - exactly one expected');
  }  

  res_shift_info.next();
  var alerts_day_shift_id = res_shift_info.getColumnValue(1);
  var alerts_duration_diff = res_shift_info.getColumnValue(2);

  // check for already existing (duplicate) alerts
  var sql_check_dupl = "\
    SELECT DWH_CREATED_TMSP \
    FROM CORE.T_FACT_ALERTS \
    WHERE CAL_DT = :1 \
      AND ALERTS_TM = :2 \
      AND ALERTS_MESSAGE_ID = :3 \
      AND ALERTS_DELETED_FG = 0 \
  ";

  var res_check_dupl = snowflake.execute({
      sqlText:sql_check_dupl,
      binds: [
        cal_end_dt                // cal_dt
      , ALERTS_END_TM             // alerts_tm
      , ALERTS_MESSAGE_ID         // alerts_message_id
      ]
  });

  if (res_check_dupl.getRowCount() > 0) {
    res_check_dupl.next();
    dwh_created_tmsp = res_check_dupl.getColumnValue(1);
  }


  // delete any alerts with the same key 
  var sql_del = "\
    DELETE \
    FROM CORE.T_FACT_ALERTS \
    WHERE CAL_DT = :1 \
      AND ALERTS_TM = :2 \
      AND ALERTS_MESSAGE_ID = :3 \
  ";

  try {
   snowflake.execute({
      sqlText:sql_del,
      binds: [
        cal_end_dt                // cal_dt
      , ALERTS_END_TM             // alerts_tm
      , ALERTS_MESSAGE_ID         // alerts_message_id
      ]
   }); 
  }
  catch (error) {
    throw "Remove deleted alert failed: " + error;
  }

  // now, finally: insert the new alert
  var sql_ins_alert = "\
    INSERT INTO CORE.T_FACT_ALERTS ( \
        ALERTS_PRIORITY_ID \
    ,   ALERTS_MESSAGE_ID \
    ,   ALERTS_TYPE_ID \
    ,   CAL_DT \
    ,   ALERTS_DAY_SHIFT_ID \
    ,   ALERTS_LOCATION_ID \
    ,   ALERTS_TM \
    ,   ALERTS_DURATION_DIFF \
    ,   ALERTS_PRODUCTION_STOP_FG \
    ,   ALERTS_DELETED_FG \
    ,   DWH_CREATED_TMSP \
    ,   DWH_UPDATED_TMSP \
    ,   DWH_LOAD_ID \
    ) VALUES ( \
     /* ALERTS_PRIORITY_ID */         :1 \
    ,/* ALERTS_MESSAGE_ID */          :2 \
    ,/* ALERTS_TYPE_ID */             :3 \
    ,/* CAL_DT */                     :4 \
    ,/* ALERTS_DAY_SHIFT_ID */        :5 \
    ,/* ALERTS_LOCATION_ID */         :6 \
    ,/* ALERTS_TM */                  :7 \
    ,/* ALERTS_DURATION_DIFF */       :8 \
    ,/* ALERTS_PRODUCTION_STOP_FG */  :9 \
    ,/* ALERTS_DELETED_FG */          0 \
    ,/* DWH_CREATED_TMSP */           COALESCE(:10, CURRENT_TIMESTAMP()) \
    ,/* DWH_UPDATED_TMSP */           current_timestamp() \
    ,/* DWH_LOAD_ID */                -1   \
    ) \
  ";
  
  try {
    snowflake.execute({
      sqlText:sql_ins_alert,
      binds: [
        alerts_priority_id        // alerts_priority_id
      , ALERTS_MESSAGE_ID         // alerts_message_id
      , 2                         // alerts_type_id  (fixed to manual = 2)
      , cal_end_dt                // cal_dt
      , alerts_day_shift_id       // alerts_day_shift_id
      , alerts_location_id        // alerts_location_id
      , ALERTS_END_TM             // alerts_tm
      , alerts_duration_diff      // alerts_duration_diff
      , ALERTS_PRODUCTION_STOP_FG // alerts_production_stop_fg
      , dwh_created_tmsp          // dwh_created_tmsp 
      ].map(function(x){return x===undefined?null:x})
    });

  }
  catch (error) {
    throw "Alert insert failed: " + error;
  }

  // commit the changes
  var sql_commit ='COMMIT';
  snowflake.execute( {
    sqlText:sql_commit
  });
  return "Succeeded";  
$$
;