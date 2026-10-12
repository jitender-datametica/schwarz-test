CREATE OR REPLACE PROCEDURE p_lew_process_mstr.m_saule_excel_import (SRC_FAMILYGRP_CD VARCHAR(100), ITEM_FAM_GRP_NAME VARCHAR(100), PILLAR_ID FLOAT, PILLAR_NAME VARCHAR(100), MAIN_PILLAR_ID FLOAT, MAIN_PILLAR_NAME VARCHAR(100))
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
	// ** MSC-WARNING - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
	EXEC(`INSERT INTO p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction ( src_familygrp_cd
	, item_fam_grp_name
	, pillar_id
	, pillar_name
	, main_pillar_id
	, main_pillar_name) VALUES (?
	, ?
	, ?
	, ?
	, ?
	, ?)`,[SRC_FAMILYGRP_CD,ITEM_FAM_GRP_NAME,PILLAR_ID,PILLAR_NAME,MAIN_PILLAR_ID,MAIN_PILLAR_NAME]);

var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$
;
