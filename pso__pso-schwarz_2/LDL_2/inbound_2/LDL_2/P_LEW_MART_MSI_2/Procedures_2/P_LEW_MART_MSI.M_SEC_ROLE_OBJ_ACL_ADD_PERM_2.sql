CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.M_SEC_ROLE_OBJ_ACL_ADD_PERM (PERMISSION_TYPE VARCHAR(128), ENTRY_USER VARCHAR(128))
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

	EXEC(`-- Insert the new permission type into the perms table
	INSERT INTO p_lew_mart_msi.t_ct_sec_role_obj_acl_perms_2 (
	security_role_id
	, security_role_desc
	, permission_type
	, authorized
	, entry_user
	, entry_datetime
	, approval_user
	, approval_datetime
	, approved
	, active_fg) SELECT
	p.security_role_id   AS security_role_id,
	p.security_role_desc AS security_role_desc,
	?     AS permission_type,
	0                    AS authorized,
	?          AS entry_user,
	Current_Timestamp(0) AS entry_datetime,
	?          AS approval_user,
	Current_Timestamp(0) AS approval_datetime,
	1                    AS  approved,
	1                    AS active_fg
	FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_perms_2 AS p
	WHERE ? NOT IN(SELECT
	permission_type
	FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_perms_2
	                                 )`,[PERMISSION_TYPE,ENTRY_USER,ENTRY_USER,PERMISSION_TYPE]);
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
$$;