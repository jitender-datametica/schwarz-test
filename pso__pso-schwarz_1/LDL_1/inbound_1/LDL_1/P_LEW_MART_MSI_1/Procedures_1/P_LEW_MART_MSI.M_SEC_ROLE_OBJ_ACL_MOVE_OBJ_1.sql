CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.M_SEC_ROLE_OBJ_ACL_MOVE_OBJ (NSTD_LFT_ID FLOAT, NSTD_RGT_ID FLOAT, OBJECT_NAME VARCHAR(128), OBJECT_TYPE FLOAT, NSTD_LFT_ID_MOVE FLOAT)
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
// -- Delete move table everytime, so that there is no data at the beginning
EXEC(`DELETE FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_move_1`,[]);
// Insert the data from the object, which will be moved from one parent object to an other parent object
EXEC(`INSERT INTO p_lew_mart_msi.t_ct_sec_role_obj_acl_move_1 (
security_role_id
, security_role_desc
, object_name
, object_type_id
, nstd_lft_id
, nstd_rgt_id
, authorized
, entry_user
, entry_datetime
, approval_user
, approval_datetime
, approved
, active_fg
, zero_val)SELECT
acl.security_role_id   AS  security_role_id,
acl.security_role_desc AS  security_role_desc,
acl.object_name        AS  object_name,
acl.object_type_id     AS  object_type_id,
acl.nstd_lft_id        AS  nstd_lft_id,
id.nstd_rgt_id         AS  nstd_rgt_id,
acl.authorized         AS  authorized,
acl.entry_user         AS  entry_user,
acl.entry_datetime     AS  entry_datetime,
acl.approval_user      AS  approval_user,
acl.approval_datetime  AS  approval_datetime,
acl.approved           AS  approved,
acl.active_fg          AS  active_fg,
acl.zero_val           AS  zero_val
FROM (SELECT
security_role_id   AS security_role_id,
security_role_desc AS security_role_desc,
object_name        AS object_name,
object_type_id     AS object_type_id,
?                  AS nstd_lft_id,
authorized         AS authorized,
entry_user         AS entry_user,
entry_datetime     AS entry_datetime,
approval_user      AS approval_user,
approval_datetime  AS approval_datetime,
approved           AS approved,
active_fg          AS active_fg,
zero_val           AS zero_val
FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_1 AS acl
WHERE nstd_lft_id = ?
) AS acl

JOIN(SELECT
DISTINCT nstd_rgt_id,
nstd_lft_id
FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_1
     WHERE nstd_lft_id = ?
) AS id
ON acl.nstd_lft_id = id.nstd_lft_id`,[NSTD_LFT_ID_MOVE,NSTD_LFT_ID,NSTD_LFT_ID_MOVE]);
// Now delete the object, which will be moved to an other parent.
EXEC(`DELETE FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_1
WHERE nstd_lft_id BETWEEN ? AND ?`,[NSTD_LFT_ID,NSTD_RGT_ID]);

EXEC(`UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl_1 
SET nstd_lft_id = nstd_lft_id-Round((? - ? +1))
WHERE NSTD_LFT_ID > ?`,[NSTD_RGT_ID,NSTD_LFT_ID,NSTD_RGT_ID]);

EXEC(`UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl_1 
SET NSTD_RGT_ID = NSTD_RGT_ID -Round((? - ? +1))
WHERE nstd_rgt_id > ?`,[NSTD_RGT_ID,NSTD_LFT_ID,NSTD_RGT_ID]);

// Now delete the object, also from the parent_child Table.
EXEC(`DELETE FROM p_lew_mart_msi.t_ref_obj_acl_parent_child_1
WHERE c_lft_id BETWEEN ? AND ?`,[NSTD_LFT_ID,NSTD_RGT_ID]);

EXEC(`UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child_1 
SET c_lft_id=c_lft_id-Round((? - ? +1))
WHERE c_lft_id> ?`,[NSTD_RGT_ID,NSTD_LFT_ID,NSTD_RGT_ID]);

EXEC(`UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child_1 
SET c_rgt_id=c_rgt_id-Round((? - ? +1))
WHERE c_rgt_id> ?`,[NSTD_RGT_ID,NSTD_LFT_ID,NSTD_RGT_ID]);

EXEC(`UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child_1 
SET p_lft_id=p_lft_id-Round((? - ? +1))
WHERE p_lft_id> ?`,[NSTD_RGT_ID,NSTD_LFT_ID,NSTD_RGT_ID]);

EXEC(`UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child_1 
SET p_rgt_id=p_rgt_id-Round((? - ? +1))
WHERE p_rgt_id> ?`,[NSTD_RGT_ID,NSTD_LFT_ID,NSTD_RGT_ID]);

// Update the move table at the same time, because we need the correct nstd_lft_id of the parent object.
EXEC(`UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl_move_1 
SET NSTD_LFT_ID = NSTD_LFT_ID -Round((? - ? +1))
WHERE NSTD_LFT_ID > ?`,[NSTD_RGT_ID,NSTD_LFT_ID,NSTD_RGT_ID]);

EXEC(`UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl_move_1 
SET NSTD_RGT_ID = NSTD_RGT_ID -Round((? - ? +1))
WHERE nstd_rgt_id> ?`,[,,NSTD_RGT_ID,NSTD_LFT_ID,NSTD_RGT_ID]);

// Now update the IDÝs so that the moved object can be inserted
EXEC(`UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl_1 AS acl 
SET acl.NSTD_RGT_ID = acl.nstd_rgt_id+2 
FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_move_1 AS move
WHERE acl.nstd_rgt_id >= move.nstd_rgt_id
AND move.security_role_id = 1
AND move.approved = 1
AND move.active_fg = 1`,[]);

EXEC(`UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl_1 AS acl 
SET acl.NSTD_LFT_ID = acl.nstd_lft_id+2 
FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_move_1 AS move
WHERE acl.nstd_lft_id > move.nstd_rgt_id
AND move.security_role_id = 1
AND move.approved = 1
AND move.active_fg = 1`,[]);

// Now insert the object again under the new parent object with the new IDÝs and the new object path        
EXEC(`
INSERT INTO p_lew_mart_msi.t_ct_sec_role_obj_acl_1 (
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
move.security_role_id                      AS security_role_id,
move.security_role_desc                    AS security_role_desc,
move.object_name                           AS object_name,
move.object_type_id                        AS object_type_id,
acl.object_path || move.object_name || '\' AS object_path,
move.nstd_rgt_id                           AS nstd_lft_id,
move.nstd_rgt_id+1                         AS nstd_rgt_id,
move.authorized                            AS authorized,
move.entry_user                            AS entry_user,
move.entry_datetime                        AS entry_datetime,
move.approval_user                         AS approval_user,
move.approval_datetime                     AS approval_datetime,
move.approved                              AS approved,
move.active_fg                             AS active_fg,
move.zero_val                              AS zero_val
FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_move_1 AS move

INNER JOIN p_lew_mart_msi.t_ct_sec_role_obj_acl_1 AS acl
ON acl.nstd_lft_id = move.nstd_lft_id`,[]);

// The same insert has to be done to the parent child table
EXEC(`
UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child_1 AS acl 
SET acl.p_rgt_id = acl.p_rgt_id+2 
FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_move_1 AS move
WHERE acl.p_rgt_id        >= move.nstd_rgt_id
AND move.security_role_id = 1
AND move.approved         = 1
AND move.active_fg        = 1`,[]);

EXEC(`UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child_1 AS acl 
SET acl.p_lft_id = acl.p_lft_id+2 
FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_move_1 AS move
WHERE acl.p_lft_id > move.nstd_rgt_id
AND move.security_role_id = 1
AND move.approved         = 1
AND move.active_fg        = 1`,[]);

EXEC(`UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child_1 AS acl 
SET acl.c_rgt_id = acl.c_rgt_id+2 
FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_move_1 AS move
WHERE acl.c_rgt_id >= move.nstd_rgt_id
AND move.security_role_id = 1
AND move.approved         = 1
AND move.active_fg        = 1`,[]);

EXEC(`UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child_1 AS acl 
SET acl.c_lft_id = acl.c_lft_id+2 
FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_move_1 AS move
WHERE acl.c_lft_id > move.nstd_rgt_id
AND move.security_role_id = 1
AND move.approved         = 1
AND move.active_fg        = 1`,[]);

EXEC(`INSERT INTO p_lew_mart_msi.t_ref_obj_acl_parent_child_1 (
p_lft_id
, p_rgt_id
, p_object_name
, c_lft_id
, c_rgt_id)
SELECT
p.nstd_lft_id     AS p_lft_id,
p.nstd_rgt_id     AS p_rgt_id,
p.object_name     AS p_object_name,
c.nstd_rgt_id     AS c_lft_id,
c.nstd_rgt_id + 1 AS c_rgt_id
FROM (SELECT
      nstd_lft_id,
      nstd_rgt_id,
      object_name
      FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_1 AS p
      GROUP BY 1,2,3
    ) AS p
INNER JOIN (SELECT
            nstd_lft_id,
            nstd_rgt_id
            FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_move_1
            GROUP BY 1,2
            ) AS c
  ON c.nstd_rgt_id >= p.nstd_lft_id AND  c.nstd_rgt_id <= p.nstd_rgt_id`,[]);

var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute(); 
$$;

