CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.M_SEC_ROLE_OBJ_ACL_APPR (SECURITY_ROLE_ID FLOAT, OBJECT_NAME VARCHAR(128), NSTD_LFT_ID FLOAT, APPROVAL_USER VARCHAR(128), APPROVING FLOAT)
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

	EXEC(`-- At first, we are updating the actual live value to inactive
	UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl_1
	SET
	active_fg = 0
	WHERE security_role_id = ?
	AND nstd_lft_id        = ?
	AND approved           = 1
	AND active_fg          = 1`,[SECURITY_ROLE_ID,NSTD_LFT_ID]);

	EXEC(`
	-- Now we are updating the last change request to the new live value
	UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl_1
	SET
	  approved          = 1
	, approval_user     = ?
	, approval_datetime = Current_Timestamp(0)
	WHERE security_role_id = ?
	AND nstd_lft_id        = ?
	AND approved           = 0
	AND active_fg          = 1`,[APPROVAL_USER,SECURITY_ROLE_ID,NSTD_LFT_ID]);
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
$$;