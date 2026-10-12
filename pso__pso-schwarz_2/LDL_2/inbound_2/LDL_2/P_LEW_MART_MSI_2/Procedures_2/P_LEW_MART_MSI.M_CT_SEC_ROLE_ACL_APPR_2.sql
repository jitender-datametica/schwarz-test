CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.M_CT_SEC_ROLE_ACL_APPR (SECURITY_ROLE_ID FLOAT, SECURITY_ROLE_DESC VARCHAR(128), DASHBOARD_NAME VARCHAR(128), AUTHORIZED FLOAT, ENTRY_USER VARCHAR(128), APPROVAL_USER VARCHAR(128))
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

	EXEC(`-- The last active live value is updated to inactive, but only if the approval_user <> entry_user
	UPDATE p_lew_mart_msi.t_ct_sec_role_acl_2
	SET
	  active_fg = 0
	WHERE security_role_id = ?
	AND dashboard_name     = ?
	AND approved           = 1
	AND active_fg          = 1`,[SECURITY_ROLE_ID,DASHBOARD_NAME]);
	
	EXEC(`
	-- at last, the update statement for the last active request runs. In this statement, the last active request gets updated to the actual live value
	UPDATE p_lew_mart_msi.t_ct_sec_role_acl_2
	SET
	  approved          = 1
	, approval_user     = ?
	, approval_datetime = CURRENT_TIMESTAMP(0)
	WHERE security_role_id = ?
	AND dashboard_name     = ?
	AND approved           = 0
	AND active_fg          = 1`,[APPROVAL_USER,SECURITY_ROLE_ID,DASHBOARD_NAME]);

var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
	

$$
;