CREATE OR REPLACE PROCEDURE P_LEW_PROCESS.M_LOAD_CONTROL_START_APP 
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
EXEC(`INSERT INTO p_lew_process.t_load_control (
  load_id
, load_process_application_id
, load_process_sap_cluster_cd
, load_process
, load_status
, load_status_rc
, load_type
, load_start_dt
, load_end_dt
, load_start_tms
, load_end_tms
, load_process_script_svn_vrs)
SELECT
  COALESCE(lc.latest_load_id+1,1) AS load_id
, ap.load_process_application_id
, dm.load_process_sap_cluster_cd
, ap.load_process_application_name AS load_process
, 'started' AS load_status
, NULL AS load_status_rc
, dm.load_type
, dm.load_start_dt
, NULL AS load_end_dt
, dm.load_start_tms
, NULL AS load_end_tms
, -1 AS load_process_script_svn_vrs
FROM p_lew_process.t_current_execution_gtmp AS dm
INNER JOIN p_lew_process.t_load_control_applications AS ap
ON dm.load_process_application_id = ap.load_process_application_id
CROSS JOIN /* p_lew_process.t_load_control */
(SELECT
   MAX(load_id) AS latest_load_id
   FROM p_lew_process.t_load_control
) AS lc`,[]);
$$;


