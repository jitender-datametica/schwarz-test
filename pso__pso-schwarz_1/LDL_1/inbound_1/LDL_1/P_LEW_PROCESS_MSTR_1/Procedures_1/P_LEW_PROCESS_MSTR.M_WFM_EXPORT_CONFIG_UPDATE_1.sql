CREATE OR REPLACE PROCEDURE p_lew_process_mstr.m_wfm_export_config_update (INTERFACE_NAME VARCHAR(300), MIS_SFO_TYPE_ID FLOAT, MOVE_TYPE_DESCR VARCHAR(300), MIS_SFO_TYPE_DESCR VARCHAR(300), MOVE_REASON_DESCR VARCHAR(300), ORDER_TYPE_DESCR VARCHAR(300), WRITEOFF_ZERO_FG FLOAT, ACTIVE_FG FLOAT, ROW_ID FLOAT)
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
	EXEC(`
	/* SQL FOR CURRENT_SALES_PRICES */
	UPDATE p_lew_process_mstr.t_wfm_export_config_1
	SET active_fg = ?
	, dwh_updated = current_timestamp(6)
	WHERE interface_name = ?
	AND ? = 'current_sales_prices'
	AND row_id = ?`,[ACTIVE_FG,INTERFACE_NAME,INTERFACE_NAME,ROW_ID]);
	// ** MSC-WARNING - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
	EXEC(`
	/* SQL FOR Store_Delivery */
	UPDATE p_lew_process_mstr.t_wfm_export_config_1
	SET active_fg = ?
	, move_type_descr = ?
	, order_type_descr = ?
	, writeoff_zero_fg = ?
	, dwh_updated = current_timestamp(6)
	WHERE interface_name = ?
	AND ? = 'StoreDelivery'
	AND row_id = ?`,[ACTIVE_FG,MOVE_TYPE_DESCR,ORDER_TYPE_DESCR,WRITEOFF_ZERO_FG,INTERFACE_NAME,INTERFACE_NAME,ROW_ID]);
	// ** MSC-WARNING - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
	EXEC(`
	/* SQL FOR sfo_day */
	UPDATE p_lew_process_mstr.t_wfm_export_config_1
	SET active_fg = ?
	, move_type_descr = ?
	, order_type_descr = ?
	, writeoff_zero_fg = ?
	, mis_sfo_type_id = ?
	, mis_sfo_type_descr = ?
	, move_reason_descr = ?
	, dwh_updated = current_timestamp(6)
	WHERE interface_name = ?
	AND ? = 'sfo_day'
	AND row_id = ?`,[ACTIVE_FG,MOVE_TYPE_DESCR,ORDER_TYPE_DESCR,WRITEOFF_ZERO_FG,MIS_SFO_TYPE_ID,MIS_SFO_TYPE_DESCR,MOVE_REASON_DESCR,INTERFACE_NAME,INTERFACE_NAME,ROW_ID]);
	// ** MSC-WARNING - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
	EXEC(`
	/* SQL FOR writeoff_store */
	UPDATE p_lew_process_mstr.t_wfm_export_config_1
	SET active_fg = ?
	, move_reason_descr = ?
	, move_type_descr = ?
	, writeoff_zero_fg = ?
	, mis_sfo_type_id = ?
	, mis_sfo_type_descr = ?
	, dwh_updated = current_timestamp(6)
	WHERE interface_name = ?
	AND ? = 'writeoff_store'
	AND row_id = ?`,[ACTIVE_FG,MOVE_REASON_DESCR,MOVE_TYPE_DESCR,WRITEOFF_ZERO_FG,MIS_SFO_TYPE_ID,MIS_SFO_TYPE_DESCR,INTERFACE_NAME,INTERFACE_NAME,ROW_ID]);
	// ** MSC-WARNING - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
	EXEC(`
	/* SQL FOR writeoff_wh */
	UPDATE p_lew_process_mstr.t_wfm_export_config_1
	SET active_fg = ?
	, move_reason_descr = ?
	, move_type_descr = ?
	, writeoff_zero_fg = ?
	, mis_sfo_type_id = ?
	, mis_sfo_type_descr = ?
	, dwh_updated = current_timestamp(6)
	WHERE interface_name = ?
	AND ? = 'writeoff_wh'
	AND row_id = ?`,[ACTIVE_FG,MOVE_REASON_DESCR,MOVE_TYPE_DESCR,WRITEOFF_ZERO_FG,MIS_SFO_TYPE_ID,MIS_SFO_TYPE_DESCR,INTERFACE_NAME,INTERFACE_NAME,ROW_ID]);
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;