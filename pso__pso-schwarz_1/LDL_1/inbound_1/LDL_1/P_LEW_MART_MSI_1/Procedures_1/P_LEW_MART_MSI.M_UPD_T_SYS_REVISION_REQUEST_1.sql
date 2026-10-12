/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for M_UPD_T_SYS_REVISION_REQUEST
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2017    Michael Ueding           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  27.06.2022    Wandtke,Andrzej          BS0011299_ZKP_CLEAN "EXECUTE AS CALLER" replaced by "EXECUTE AS OWNER"
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.M_UPD_T_SYS_REVISION_REQUEST (APPROVAL_USER VARCHAR(100), WH_OR_STORE_FG FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
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

EXEC(`UPDATE p_lew_mart_msi.t_msi_sys_revision_request_1 
SET   approval_fg        = 1
     ,approval_user      = ?
     ,timestamp_approval = Current_Timestamp(0)
WHERE approval_fg        = 0
AND ? <> requesting_user
AND (
     (orig_store_nr IS NULL     AND ? = 1) -- 1    => WH
  OR (orig_store_nr IS NOT NULL AND ? = 2) -- 2    => Store
  OR ? = 0                                -- 0    => All
  OR ? IS NULL                            -- Null => All
)`,[APPROVAL_USER,APPROVAL_USER,WH_OR_STORE_FG,WH_OR_STORE_FG,WH_OR_STORE_FG,WH_OR_STORE_FG]);

var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute(); 
$$
   ;

