CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.M_SEC_ROLE_OBJ_ACL_REQ (SECURITY_ROLE_ID FLOAT, OBJECT_NAME VARCHAR(128), AUTHORIZED FLOAT, NSTD_LFT_ID FLOAT, NSTD_RGT_ID FLOAT, ENTRY_USER VARCHAR(128))
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
	
    
    EXEC(`-- Delete the table, which is the intermediate table to store the parent or child objects
	DELETE FROM p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id`,[]);
	EXEC(`
	-- Insert the parent objects into the update_lft_id_table
	INSERT INTO p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id (
	nstd_lft_id) SELECT
	x.nstd_lft_id
	FROM
	(SELECT
	o.object_name,
	o.object_path,
	o.nstd_lft_id,
	o.nstd_rgt_id,
	o.authorized,
	o.approved,
	o.active_fg,
	Count(DISTINCT p.nstd_lft_id)-1 AS ebene
	FROM p_lew_mart_msi.t_ct_sec_role_obj_acl AS n
	
	INNER JOIN p_lew_mart_msi.t_ct_sec_role_obj_acl AS o
	ON  o.nstd_lft_id BETWEEN n.nstd_lft_id AND n.nstd_rgt_id
	AND o.security_role_id = n.security_role_id
	
	INNER JOIN p_lew_mart_msi.t_ct_sec_role_obj_acl AS p
	ON  o.nstd_lft_id BETWEEN p.nstd_lft_id AND p.nstd_rgt_id
	AND o.security_role_id = p.security_role_id
	
	WHERE n.nstd_lft_id      = 1
	AND n.security_role_id   = ?
	GROUP BY 1,2,3,4,5,6,7
	) AS x
	
	WHERE nstd_lft_id BETWEEN x.nstd_lft_id AND x.nstd_rgt_id
	AND authorized = 1
	AND authorized  = 0
	AND approved    = 1
	AND active_fg   = 1`,[SECURITY_ROLE_ID]);
	
    EXEC(`
	-- Delete from the ACL table all never approved and inactive requests
	DELETE FROM p_lew_mart_msi.t_ct_sec_role_obj_acl
	WHERE security_role_id = ?
	AND approved           = 0
	AND active_fg          = 0
	AND nstd_lft_id IN (SELECT
	nstd_lft_id
	FROM p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id
	                     )`,[SECURITY_ROLE_ID]);
	EXEC(`
	-- Set the last active request to inactive
	UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl
	SET active_fg = 0
	WHERE security_role_id = ?
	AND approved           = 0
	AND active_fg          = 1
	AND nstd_lft_id IN (SELECT
	nstd_lft_id
	FROM p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id
	                     )`,[SECURITY_ROLE_ID]);
	EXEC(`
	-- Insert the new request for the object and all his parent objects
	INSERT INTO p_lew_mart_msi.t_ct_sec_role_obj_acl (
	security_role_id
	, security_role_desc
	, object_name
	, object_type_id
	, object_path
	, nstd_lft_id
	, nstd_rgt_id
	, authorized
	, entry_user
	, entry_datetime
	, approval_user
	, approval_datetime
	, approved
	, active_fg
	, zero_val) SELECT
	security_role_id   AS security_role_id,
	security_role_desc AS security_role_desc,
	object_name        AS object_name,
	object_type_id     AS object_type_id,
	object_path        AS object_path,
	nstd_lft_id        AS nstd_lft_id,
	nstd_rgt_id        AS nstd_rgt_id,
	?        AS authorized,
	?        AS entry_user,
	Current_Timestamp    AS entry_datetime,
	'NOT APPROVED'     AS approval_user,
	NULL               AS approval_datetime,
	0                  AS approved,
	1                  AS active_fg,
	0                  AS zero_val
	FROM p_lew_mart_msi.t_ct_sec_role_obj_acl
	  WHERE security_role_id = ?
	  AND approved           = 1
	  AND active_fg          = 1
	  AND authorized        = 1
	  AND authorized         = 0
	  AND nstd_lft_id IN (SELECT
	nstd_lft_id
	FROM p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id
	                     )`,[ AUTHORIZED , ENTRY_USER , SECURITY_ROLE_ID]);
	
    EXEC(`DELETE FROM p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id`,[]);
	
    EXEC(`
	-- Here comes the same logic as before, just for the children objects.   
	INSERT INTO p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id (
	nstd_lft_id) SELECT
	x.nstd_lft_id
	FROM
	(SELECT
	o.object_name,
	o.object_path,
	o.nstd_lft_id,
	o.nstd_rgt_id,
	o.authorized,
	o.approved,
	o.active_fg,
	Count(DISTINCT p.nstd_lft_id)-1 AS ebene
	FROM p_lew_mart_msi.t_ct_sec_role_obj_acl AS n
	
	INNER JOIN p_lew_mart_msi.t_ct_sec_role_obj_acl AS o
	ON  o.nstd_lft_id BETWEEN n.nstd_lft_id AND n.nstd_rgt_id
	AND o.security_role_id = n.security_role_id
	
	INNER JOIN p_lew_mart_msi.t_ct_sec_role_obj_acl AS p
	ON  o.nstd_lft_id BETWEEN p.nstd_lft_id AND p.nstd_rgt_id
	AND o.security_role_id = p.security_role_id
	
	WHERE n.nstd_lft_id      = 1
	AND   n.security_role_id = ?
	GROUP BY 1,2,3,4,5,6,7
	 ) AS x
	
	WHERE x.nstd_lft_id BETWEEN ? AND ?
	AND authorized = 0
	AND authorized  = 1
	AND approved    = 1
	AND active_fg   = 1`,[ NSTD_LFT_ID, NSTD_RGT_ID, SECURITY_ROLE_ID]);
	
    
    EXEC(`DELETE FROM p_lew_mart_msi.t_ct_sec_role_obj_acl
	WHERE security_role_id = ?
	AND approved           = 0
	AND active_fg          = 0
	AND nstd_lft_id IN (SELECT
	nstd_lft_id
	FROM p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id
	                     )`,[SECURITY_ROLE_ID]);
	
    EXEC(`UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl
	SET active_fg = 0
	WHERE security_role_id = ?
	AND approved           = 0
	AND active_fg          = 1
	AND nstd_lft_id IN (SELECT
	nstd_lft_id
	FROM p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id
	                     )`,[SECURITY_ROLE_ID]);
	
    EXEC(`INSERT INTO p_lew_mart_msi.t_ct_sec_role_obj_acl (
	security_role_id
	, security_role_desc
	, object_name
	, object_type_id
	, object_path
	, nstd_lft_id
	, nstd_rgt_id
	, authorized
	, entry_user
	, entry_datetime
	, approval_user
	, approval_datetime
	, approved
	, active_fg
	, zero_val) SELECT
	security_role_id   AS security_role_id,
	security_role_desc AS security_role_desc,
	object_name        AS object_name,
	object_type_id     AS object_type_id,
	object_path        AS object_path,
	nstd_lft_id        AS nstd_lft_id,
	nstd_rgt_id        AS nstd_rgt_id,
	?       AS authorized,
	?        AS entry_user,
	Current_Timestamp       AS entry_datetime,
	'NOT APPROVED'     AS approval_user,
	NULL               AS approval_datetime,
	0                  AS approved,
	1                  AS active_fg,
	0                  AS zero_val
	FROM p_lew_mart_msi.t_ct_sec_role_obj_acl
	  WHERE security_role_id = ?
	  AND approved           = 1
	  AND active_fg          = 1
	  AND authorized        = 0
	  AND authorized         = 1
	  AND nstd_lft_id IN (SELECT
	nstd_lft_id
	FROM p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id
	                     )`, [  AUTHORIZED , ENTRY_USER  , SECURITY_ROLE_ID]);
	
    EXEC(`DELETE FROM p_lew_mart_msi.t_ct_sec_role_obj_acl
	WHERE active_fg = 0
	AND approved    = 0`,[]);
	
    
    EXEC(`
	-- object_type_id 0 and 32 are the startpoint of MIS Reports the projects (MIS International, MIS lead..) 
	-- there should be default authorized = 1 for all groups
	-- "Öffentliche Objekte" and "Berichte" are also objects, where for all groups are default authorized = 1
	UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl
	SET authorized = 1
	WHERE object_type_id in (0, 32)
	OR object_name in ('Öffentliche Objekte', 'Berichte')`,[]);
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
$$;