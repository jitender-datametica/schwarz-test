CREATE OR REPLACE PROCEDURE p_lew_process_mstr.m_saule_tables_reload ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
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
	EXEC(`DELETE FROM p_lew_process_mstr.t_pillar_1`,[]);
	EXEC(`INSERT INTO p_lew_process_mstr.t_pillar_1 ( pillar_id
	, pillar_name
	, main_pillar_id
	, dwh_created
	, dwh_updated) SELECT
	pillar_id,
	pillar_name,
	main_pillar_id,
	CURRENT_TIMESTAMP AS dwh_created,
	CURRENT_TIMESTAMP AS dwh_updated
	FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction_1
	GROUP BY 1,2,3,4`,[]);
	EXEC(`DELETE FROM p_lew_process_mstr.t_main_pillar_1`,[]);
	EXEC(`INSERT INTO p_lew_process_mstr.t_main_pillar_1 ( main_pillar_id
	, main_pillar_name
	, dwh_created, dwh_updated) SELECT
	main_pillar_id,
	main_pillar_name,
	CURRENT_TIMESTAMP AS dwh_created,
	CURRENT_TIMESTAMP AS dwh_updated
	FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction_1
	GROUP BY 1,2,3,4`,[]);
	EXEC(`DELETE FROM p_lew_process_mstr.t_itm_fam_pillar_map_1`,[]);
	EXEC(`INSERT INTO p_lew_process_mstr.t_itm_fam_pillar_map_1 ( client_id
	, item_familygroup_id
	, src_familygrp_cd
	, pillar_id) 
SELECT
	ifg.client_id                                        AS client_id,
	COALESCE(ifg.src_familygrp_id, ifg.item_fam_grp_sid) AS item_familygroup_id,
	ifam.src_familygrp_cd                                AS src_familygrp_cd,
	ifam.pillar_id                                       AS pillar_id
	FROM p_lew_bil_ac.v_item_familygroup_1 AS ifg
	
	INNER JOIN p_lew_core_ac.v_subitemgroup_1 AS sig
	ON ifg.sub_item_grp_sid = sig.sub_item_grp_sid
	
	INNER JOIN p_lew_core_ac.v_subitemgroup_hist_1 AS sig_h
	ON sig.sub_item_grp_sid = sig_h.sub_item_grp_sid
	AND CURRENT_DATE BETWEEN sig_h.dwh_valid_from AND sig_h.dwh_valid_to
	
	INNER JOIN p_lew_core_ac.v_itemgroup_international_1 AS igri
	ON sig_h.item_grp_int_sid = igri.item_grp_int_sid
	
	INNER JOIN p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction_1 AS ifam
	ON ifg.SRC_FAMILYGRP_CD = ifam.src_familygrp_cd
GROUP BY 1,2,3,4`,[]);
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$
;