CREATE OR REPLACE PROCEDURE p_lew_load.m_sec_role_add_sec (SECURITY_ROLE_DESC VARCHAR(128), NAV_REL_FG FLOAT, ENTRY_USER VARCHAR(128))
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
 	var HANDLE_NOTFOUND;
	var _RS, ROW_COUNT, _ROWS, MESSAGE_TEXT, SQLCODE = 0, SQLSTATE = '00000', ERROR_HANDLERS, ACTIVITY_COUNT = 0, INTO;
	var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
	var fixBind = function (arg) {
	   arg = arg == undefined ? null : arg instanceof Date ? formatDate(arg) : arg;
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
	      HANDLE_NOTFOUND && HANDLE_NOTFOUND(_RS);
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
	EXEC(`-- create new load_id if there is no load_id existing for the current_date
	INSERT INTO p_lew_load.t_sys_wb_load_1 (
	jobname
	, instance_id
	, load_id) SELECT
	'sec_role'           AS jobname,
	CURRENT_TIMESTAMP(0) AS instance_id,
	l.load_id            AS load_id
	FROM
	(SELECT
	MAX(instance_id) AS max_date,
	CASE
	WHEN CURRENT_DATE <> MAX(instance_id) THEN (SELECT
	MAX(load_id) +1 AS load_id
	FROM p_lew_load.t_sys_wb_load_1)
	ELSE MAX(load_id) END AS load_id
	FROM p_lew_load.t_sys_wb_load_1
	WHERE CURRENT_DATE <> CAST((SELECT
	MAX(instance_id)
	FROM p_lew_load.t_sys_wb_load_1) AS DATE)
	     GROUP BY jobname
	  )AS l`,[]);
	
	EXEC(`
	-- at first, delete the last entry, just to ensure, that in the l_0 table are not duplicate change requests
	DELETE FROM p_lew_load.t_sec_security_role_l_0_1
	WHERE change_type = 'ADD_SEC'
	AND security_role_desc = ?`,[SECURITY_ROLE_DESC]);

	EXEC(`
	-- Insert the change_request into the l_0
	-- Entry_user and Approval_user are not used actually. So its not important that there is the same value.
	INSERT INTO p_lew_load.t_sec_security_role_l_0_1 (
	change_type
	, security_role_desc
	, dashboard_name
	, authorized
	, change_dat
	, load_id
	, approval_user
	, entry_user) SELECT
	mp.change_type,
	mp.security_role_desc,
	mp.dashboard_name,
	mp.authorized,
	mp.change_dat,
	mp.load_id,
	mp.approval_user,
	mp.entry_user
	FROM
	(SELECT
	'ADD_SEC'            AS change_type,
	?  AS security_role_desc,
	NULL                 AS dashboard_name,
	?          AS authorized,
	CURRENT_TIMESTAMP(0) AS change_dat,
	load.load_id         AS load_id,
	?          AS approval_user,
	?          AS entry_user
	FROM (SELECT
	MAX(load_id) AS load_id
	FROM p_lew_load.t_sys_wb_load_1
	       WHERE jobname LIKE 'sec_role'
	       ) AS load
	    ) AS mp`,[SECURITY_ROLE_DESC,NAV_REL_FG,ENTRY_USER,ENTRY_USER]);
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;