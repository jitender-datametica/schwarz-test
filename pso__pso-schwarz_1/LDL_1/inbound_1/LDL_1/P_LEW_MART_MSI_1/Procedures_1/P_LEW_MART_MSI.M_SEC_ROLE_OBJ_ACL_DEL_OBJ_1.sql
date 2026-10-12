CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.M_SEC_ROLE_OBJ_ACL_DEL_OBJ (OBJECT_NAME VARCHAR(128), NSTD_LFT_ID FLOAT, NSTD_RGT_ID FLOAT, DUMMYID FLOAT)
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
// Delete the object from the main table and update the lft and rgt idÝs
EXEC(`DELETE FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_1
WHERE NSTD_LFT_ID BETWEEN ?
AND ?`,[NSTD_LFT_ID,NSTD_RGT_ID]);

EXEC(`UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl_1 SET NSTD_LFT_ID = NSTD_LFT_ID -Round((? - ? +1))
WHERE NSTD_LFT_ID > ?`,[NSTD_RGT_ID,NSTD_LFT_ID,NSTD_RGT_ID]);

EXEC(`UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl_1 SET NSTD_RGT_ID = NSTD_RGT_ID -Round((? - ? +1))
WHERE nstd_rgt_id > ?`,[NSTD_RGT_ID,NSTD_LFT_ID,NSTD_RGT_ID]);

// Delete the object from the parent child table and update the lft and rgt idÝs
EXEC(`DELETE FROM p_lew_mart_msi.t_ref_obj_acl_parent_child_1
WHERE c_lft_id BETWEEN ? AND ?`,[NSTD_LFT_ID,NSTD_RGT_ID]);

EXEC(`UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child_1 SET c_lft_id=c_lft_id-Round((? - ? +1))
WHERE c_lft_id> ?`,[NSTD_RGT_ID,NSTD_LFT_ID,NSTD_RGT_ID]);

EXEC(`UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child_1 SET c_rgt_id=c_rgt_id-Round((? - ? +1))
WHERE c_rgt_id> ?`,[NSTD_RGT_ID,NSTD_LFT_ID,NSTD_RGT_ID]);

EXEC(`UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child_1 SET p_lft_id=p_lft_id-Round((? - ? +1))
WHERE p_lft_id> ?`,[NSTD_RGT_ID,NSTD_LFT_ID,NSTD_RGT_ID]);

EXEC(`UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child_1 SET p_rgt_id=p_rgt_id-Round((? - ? +1))
WHERE p_rgt_id> ?`,[NSTD_RGT_ID,NSTD_LFT_ID,NSTD_RGT_ID]);

var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
$$;


