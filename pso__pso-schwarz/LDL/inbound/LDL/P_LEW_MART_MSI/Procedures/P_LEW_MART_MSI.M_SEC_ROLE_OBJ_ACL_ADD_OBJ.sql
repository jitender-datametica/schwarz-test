CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.M_SEC_ROLE_OBJ_ACL_ADD_OBJ 
(NSTD_LFT_ID FLOAT, NSTD_RGT_ID FLOAT, OBJECT_PATH_PARENT VARCHAR(512), OBJECT_NAME VARCHAR(128), OBJECT_TYPE_ID FLOAT, ENTRY_USER VARCHAR (128))
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
EXEC(`UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl 
SET NSTD_RGT_ID = NSTD_RGT_ID +2
WHERE nstd_rgt_id >= ?`,[NSTD_RGT_ID]);

EXEC(`UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl 
SET NSTD_LFT_ID = NSTD_LFT_ID +2
WHERE NSTD_LFT_ID > ?`,[NSTD_RGT_ID]);

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
, zero_val)
SELECT
sec.security_role_id     AS security_role_id,
sec.security_role_desc   AS security_role_desc,
?                        AS object_name,
?                        AS object_type_id,
? || ? || '\'            AS object_path,
?                        AS nstd_lft_id,
?+1                      AS nstd_rgt_id,
0                        AS authorized,
?                        AS entry_user,
Current_Timestamp        AS entry_datetime,
?                        AS approval_user,
Current_Timestamp        AS approval_datetime,
1                        AS approved,
1                        AS active_fg,
0                        AS zero_val
FROM (
   SELECT
   security_role_id,
   security_role_desc
   FROM p_lew_mart_msi.t_ct_sec_role_obj_acl
   GROUP BY 1,2
  ) AS sec`,[OBJECT_NAME,OBJECT_TYPE_ID,OBJECT_PATH_PARENT,OBJECT_NAME,NSTD_RGT_ID,NSTD_RGT_ID,ENTRY_USER,ENTRY_USER]);

EXEC(`UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child 
SET p_rgt_id = p_rgt_id+2
WHERE p_rgt_id >= ?`,[NSTD_RGT_ID]);

EXEC(`UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child 
SET p_lft_id =p_lft_id+2
WHERE p_lft_id > ?`,[NSTD_RGT_ID]);

EXEC(`UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child 
SET c_rgt_id = c_rgt_id+2
WHERE c_rgt_id >= ?`,[NSTD_RGT_ID]);

EXEC(`UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child 
SET c_lft_id =c_lft_id+2
WHERE c_lft_id > ?`,[NSTD_RGT_ID]);

EXEC(`INSERT INTO p_lew_mart_msi.t_ref_obj_acl_parent_child (
  p_lft_id
, p_rgt_id
, p_object_name
, c_lft_id
, c_rgt_id)
SELECT
p.nstd_lft_id  AS p_lft_id,
p.nstd_rgt_id  AS p_rgt_id,
p.object_name  AS p_object_name,
?              AS c_lft_id,
? + 1          AS c_rgt_id
FROM p_lew_mart_msi.t_ct_sec_role_obj_acl AS p
WHERE ? BETWEEN NSTD_LFT_ID AND NSTD_RGT_ID
GROUP BY 1,2,3`,[NSTD_RGT_ID,NSTD_RGT_ID,NSTD_RGT_ID]);

// object_type_id 0 and 32 are the startpoint of MIS Reports the projects (MIS International, MIS lead..) 
// there should be default authorized = 1 for all groups
// "Öffentliche Objekte" and "Berichte" are also objects, where for all groups are default authorized = 1
EXEC(`UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl SET authorized = 1
WHERE OBJECT_TYPE_ID in (0, 32)
OR OBJECT_NAME in ('Öffentliche Objekte', 'Berichte')`,[]);

var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
$$;


