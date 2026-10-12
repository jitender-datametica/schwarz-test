CREATE OR REPLACE PROCEDURE P_LEW_PROCESS.M_LOAD_CONTROL_END_APP 
()
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS CALLER
   AS
   $$
 	var _RS, ROW_COUNT, _ROWS, MESSAGE_TEXT, SQLCODE = 0, SQLSTATE = '00000', ERROR_HANDLERS, ACTIVITY_COUNT, INTO;
var fixBind = function (arg) {
   arg = arg == undefined ? null : arg instanceof Date ? arg.toISOString() : arg;
   return arg;
};
var EXEC = function (stmt,binds,noCatch,catchFunction) {
   try {
      binds = binds ? binds.map(fixBind) : binds;
      _RS = snowflake.createStatement({
            sqlText : stmt,
            binds : binds
         });
      _ROWS = _RS.execute();
      ROW_COUNT = _RS.getRowCount();
      ACTIVITY_COUNT = _RS.getNumRowsAffected();
      if (INTO) return {
         INTO : function () {
            return INTO();
         }
      };
   } catch(error) {
      MESSAGE_TEXT = error.message;
      SQLCODE = error.code;
      SQLSTATE = error.state;
      var msg = `ERROR CODE: ${SQLCODE} SQLSTATE: ${SQLSTATE} MESSAGE: ${MESSAGE_TEXT}`;
      if (catchFunction) catchFunction(error);
      if (!noCatch && ERROR_HANDLERS) ERROR_HANDLERS(error); else throw new Error(msg);
   }
};
EXEC(`UPDATE p_lew_process.t_current_execution_gtmp SET
load_end_dt = CURRENT_DATE
, load_end_tms = CURRENT_TIMESTAMP
WHERE load_end_dt IS NULL`,[]);

EXEC(`UPDATE p_lew_process.t_load_control 
SET
  load_end_dt = s.load_end_dt
, load_end_tms = s.load_end_tms
, load_status = 'success'
, load_status_rc = 0 
FROM (  /* p_lew_process.t_load_control_applications */
   SELECT
   lc.load_process_application_id,
   lc.load_process_sap_cluster_cd,
   lc.load_status,
   lc.load_type,
   lc.load_id,
   la.load_process_application_name,
   tm.load_end_dt,
   tm.load_end_tms
   FROM p_lew_process.t_load_control AS lc
   INNER JOIN p_lew_process.t_current_execution_gtmp AS tm
   ON lc.load_process_application_id = tm.load_process_application_id
   AND lc.load_process_sap_cluster_cd = tm.load_process_sap_cluster_cd
   AND lc.load_type = tm.load_type
   AND lc.load_start_tms <= tm.load_start_tms
   AND lc.load_status = 'started'
   INNER JOIN p_lew_process.t_load_control_applications AS la
   ON lc.load_process_application_id = la.load_process_application_id
   AND lc.load_process = la.load_process_application_name
   WHERE lc.load_end_tms IS NULL
   QUALIFY RANK () OVER (ORDER BY lc.load_id DESC NULLS LAST) = 1
) AS s
WHERE p_lew_process.t_load_control.load_process_application_id = s.load_process_application_id
AND p_lew_process.t_load_control.load_process = s.load_process_application_name
AND p_lew_process.t_load_control.load_process_sap_cluster_cd = s.load_process_sap_cluster_cd
AND p_lew_process.t_load_control.load_status = s.load_status
AND p_lew_process.t_load_control.load_type = s.load_type
AND p_lew_process.t_load_control.load_id = s.load_id
AND p_lew_process.t_load_control.load_end_tms IS NULL`,[]);
$$;


