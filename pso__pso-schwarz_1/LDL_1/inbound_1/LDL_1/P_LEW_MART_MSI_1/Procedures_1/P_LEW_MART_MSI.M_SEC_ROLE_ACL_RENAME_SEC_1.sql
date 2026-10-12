CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.M_SEC_ROLE_ACL_RENAME_SEC (SECURITY_ROLE_DESC_OLD VARCHAR(128), SECURITY_ROLE_DESC_NEW VARCHAR(128), ENTRY_USER VARCHAR(128))
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
	INSERT INTO p_lew_mart_msi.t_sys_load_status_acl_1 (
	jobname
	, instance_id
	, load_id
	, flag_change) SELECT
	'sec_role' AS jobname,
	Current_Timestamp(0) AS instance_id,
	l.load_id AS load_id,
	1
	FROM
	(SELECT
	Max(instance_id) AS max_date,
	CASE
	WHEN Current_Date <> Max(instance_id) THEN (SELECT
	Max(load_id) +1 AS load_id
	FROM p_lew_mart_msi.t_sys_load_status_acl_1 )
	ELSE Max(load_id) END AS load_id
	FROM p_lew_mart_msi.t_sys_load_status_acl_1
	WHERE Current_Date <> Cast((SELECT
	Max(instance_id)
	FROM p_lew_mart_msi.t_sys_load_status_acl_1 ) AS DATE)
	    GROUP BY jobname
	  )AS l`,[]);
	
    EXEC(`DELETE FROM p_lew_mart_msi.t_sec_role_obj_acl_tmpl_1
	WHERE attribute_frst = ?
	AND change_type = 'RENAME_SEC'`,[SECURITY_ROLE_DESC_OLD]);
	
   	EXEC(`
	-- Insert the change_request into the tmpl
	-- entry_user and approval_user are not used actually. So its not important that there are the same values
	INSERT INTO p_lew_mart_msi.t_sec_role_obj_acl_tmpl_1 (
	change_type
	, attribute_frst
	, attribute_scnd
	, change_type_value
	, change_dat
	, load_id
	, approval_user
	, entry_user) SELECT
	mp.change_type,
	mp.attribute_frst,
	mp.attribute_scnd,
	mp.change_type_value,
	mp.change_dat,
	mp.load_id,
	mp.approval_user,
	mp.entry_user
	FROM
	(SELECT
	'RENAME_SEC'            AS change_type,
	? AS attribute_frst,
	? AS attribute_scnd,
	NULL                    AS change_type_value,
	Current_Date            AS change_dat,
	lid.load_id             AS load_id,
	?             AS approval_user,
	?             AS entry_user
	FROM (SELECT
	Max(load_id) AS load_id
	FROM p_lew_mart_msi.t_sys_load_status_acl_1
	) AS lid
	) AS mp`,[SECURITY_ROLE_DESC_OLD,SECURITY_ROLE_DESC_NEW,ENTRY_USER,ENTRY_USER]);
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
$$;