CREATE OR REPLACE PROCEDURE P_LEW_PROCESS.M_LOAD_CONTROL_START_SCRIPT 
(APP_ID FLOAT, SCRIPT_NM VARCHAR(100), SAP_CLUSTER_CD VARCHAR(100), LOAD_TYPE VARCHAR(100), LOAD_PROCESS_SCRIPT_SVN_VRS VARCHAR(30), LOAD_PROCESS_SCRIPT_SVN_LASTCHANGEDBY VARCHAR(100), LOAD_PROCESS_SCRIPT_SVN_LASTCHANGEDDATE_TXT VARCHAR(70), LOAD_PROCESS_SCRIPT_SVN_URL VARCHAR(250))
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
// Populate log table with start of load information 
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
, load_process_script_svn_vrs
, load_user_id
, load_session_id)
SELECT
   COALESCE(lc.latest_load_id+1,1) AS load_id,
   ? AS load_process_application_id,
   ? AS load_process_sap_cluster_cd,
   ? AS load_process,
   'started' AS load_status,
   NULL AS load_status_rc,
   ? AS load_type,
   CURRENT_DATE AS load_start_dt,
   NULL AS load_end_dt,
   CURRENT_TIMESTAMP(6) AS load_start_tms,
   NULL AS load_end_tms,
CASE
    WHEN ? IS NULL THEN CAST(-99 AS INTEGER)
    WHEN CAST(REGEXP_REPLACE(?,'[^0-9]','') AS INTEGER) = 0 THEN CAST(-99 AS INTEGER)
    ELSE CAST(REGEXP_REPLACE(?,'[^0-9]','') AS INTEGER)
  END AS load_process_script_svn_vrs,
USER AS load_user_id,
SESSION AS load_session_id
FROM
(SELECT
MAX(load_id) AS latest_load_id
FROM p_lew_process.t_load_control
   ) AS lc`
,[APP_ID,SAP_CLUSTER_CD,SCRIPT_NM,LOAD_TYPE,LOAD_PROCESS_SCRIPT_SVN_VRS,LOAD_PROCESS_SCRIPT_SVN_VRS,LOAD_PROCESS_SCRIPT_SVN_VRS]);

// Pre-delete temp table in case the macro has run twice within the session 
EXEC(`DELETE FROM p_lew_process.t_current_execution_gtmp`,[]);

/* Populate table with information about the current load process to facilitate better updates within the script */
EXEC(`INSERT INTO p_lew_process.t_current_execution_gtmp (
  load_id
, load_process_application_id
, load_process_sap_cluster_cd
, load_process
, load_type
, load_start_dt
, load_start_tms)
SELECT
lc.load_id,
lc.load_process_application_id,
lc.load_process_sap_cluster_cd,
lc.load_process,
lc.load_type,
lc.load_start_dt,
lc.load_start_tms
FROM p_lew_process.t_load_control AS lc
WHERE lc.load_process_application_id = ?
AND lc.load_process_sap_cluster_cd = ?
AND lc.load_process = ?
QUALIFY ROW_NUMBER () OVER (ORDER BY lc.load_start_tms DESC NULLS LAST) = 1`
,[APP_ID,SAP_CLUSTER_CD,SCRIPT_NM]);

/* Add new script info to script logging table */
EXEC(`MERGE INTO p_lew_process.t_load_control_script_info AS t 
USING
   (SELECT
      ? AS load_process,
      CASE
           WHEN ? IS NULL 
           THEN CAST(-99 AS INTEGER)
           WHEN CAST(REGEXP_REPLACE(?,'[^0-9]','') AS INTEGER) = 0 
           THEN CAST(-99 AS INTEGER)
           ELSE CAST(REGEXP_REPLACE(?,'[^0-9]','') AS INTEGER)
      END AS load_process_script_svn_vrs,
      TRIM(REGEXP_REPLACE(?,'LastChangedBy:|[$]','')) AS load_process_script_svn_lastchangedby,
      TRIM(REGEXP_REPLACE(?,'LastChangedDate:|[$]','')) AS load_process_script_svn_lastchangeddate_txt,
      to_timestamp(SUBSTRING(load_process_script_svn_lastchangeddate_txt, 1, 19), 'YYYY-MM-DDbHH:MI:SS' AS load_process_script_svn_lastchangeddate_tms,
      TRIM(REGEXP_REPLACE(?,'URL:|[$]','')) AS load_process_script_svn_url,
      gtm.load_id,
      gtm.load_start_tms
      FROM p_lew_process.t_current_execution_gtmp AS gtm
      WHERE ? IS NOT NULL
   ) AS s 
ON t.load_process = s.load_process
AND t.load_process_script_svn_vrs = s.load_process_script_svn_vrs

WHEN NOT MATCHED THEN INSERT
(
  load_process
, ?
, ?
, ?
, load_process_script_svn_lastchangeddate_tms
, ?
, load_id
, dwh_inserted
)
VALUES
(
  s.load_process
, s.load_process_script_svn_vrs
, s.load_process_script_svn_lastchangedby
, s.load_process_script_svn_lastchangeddate_txt
, s.load_process_script_svn_lastchangeddate_tms
, s.load_process_script_svn_url
, s.load_id
, s.load_start_tms
)`
,[SCRIPT_NM,LOAD_PROCESS_SCRIPT_SVN_VRS,LOAD_PROCESS_SCRIPT_SVN_VRS,LOAD_PROCESS_SCRIPT_SVN_VRS,LOAD_PROCESS_SCRIPT_SVN_LASTCHANGEDBY,LOAD_PROCESS_SCRIPT_SVN_LASTCHANGEDDATE_TXT,LOAD_PROCESS_SCRIPT_SVN_URL,SCRIPT_NM,LOAD_PROCESS_SCRIPT_SVN_VRS,LOAD_PROCESS_SCRIPT_SVN_LASTCHANGEDBY,LOAD_PROCESS_SCRIPT_SVN_LASTCHANGEDDATE_TXT,LOAD_PROCESS_SCRIPT_SVN_URL]);
$$;

