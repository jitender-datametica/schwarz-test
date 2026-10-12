/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.M_UPD_T_SYS_REVISION_LOG
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2017    Michael Ueding           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  04.11.2021    Wandtke,Andrzej          AP0089687 "EXECUTE AS CALLER" replaced by "EXECUTE AS OWNER" : this enables access to P_LEW_CORE_AC layer. Otherwise, when called by MSTR will give an error as MSTR user has no rights to access core layer
#                                              AP0089687 Set condition ORIG_STORE_NR IS NULL AND ? =0 instead of ? IS NULL (caused problems by binding). When passing argument, zeroifnull has to be used
#  1.3  28.06.2022    Wandtke,Andrzej          BS0011299_ZKP_CLEAN Apply date conversion on DAT_FORMDATE_FROM, DAT_FORMDATE_UNTIL
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.M_UPD_T_SYS_REVISION_LOG("CLIENT_ID" FLOAT, "WH_ID" FLOAT, "ORIG_STORE_NR" FLOAT, "DAT_FORMDATE_FROM" DATE, "DAT_FORMDATE_UNTIL" DATE, "REVISION_FG" FLOAT, "REVISION_USER" VARCHAR(100), "REVISION_REASON_CD" VARCHAR(10))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
              var _RS, ROW_COUNT, _ROWS, MESSAGE_TEXT, SQLCODE = 0, SQLSTATE = ''00000'', ERROR_HANDLERS, ACTIVITY_COUNT, INTO;
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

// USER mit CURRENT_USER substituiert
// https://docs.teradata.com/r/1DcoER_KpnGTfgPinRAFUw/HkJNyJR2i~MjMP7bMbOZ1g
EXEC(`
UPDATE p_lew_mart_msi.t_msi_sys_revision_log_2 
   SET REVISION_FG              = Coalesce(?, 1)
     , REVISION_USER            = Coalesce(?, CURRENT_USER())
     , timestamp_revision_start = Current_Timestamp(0)
     , revision_reason_cd = ?
WHERE client_id          = ?
AND   wh_loc_sid         = (
       SELECT loc_sid
       FROM p_lew_core_ac.v_loc_map_key_2 WHERE client_id = ? AND wawi_dwh_wh_id = ?
       )
AND   dat_formdate_from  = ?::date 
 AND   dat_formdate_until = ?::date
AND ( orig_store_nr      = ?
    OR (ORIG_STORE_NR IS NULL     AND ? =0)
     )
AND   REVISION_FG        = 0
AND   timestamp_delete   IS NULL`
,[REVISION_FG,REVISION_USER,REVISION_REASON_CD,CLIENT_ID,CLIENT_ID,WH_ID,DAT_FORMDATE_FROM.getFullYear().toString()+''-''+(DAT_FORMDATE_FROM.getMonth() +1 ).toString().padStart(2,''0'')+''-''+DAT_FORMDATE_FROM.getDate().toString().padStart(2,''0''),DAT_FORMDATE_UNTIL.getFullYear().toString()+''-''+(DAT_FORMDATE_UNTIL.getMonth() +1 ).toString().padStart(2,''0'')+''-''+DAT_FORMDATE_UNTIL.getDate().toString().padStart(2,''0''),ORIG_STORE_NR,ORIG_STORE_NR]);

var sql_commit = `COMMIT;`
   snowflake.createStatement({
                  sqlText : sql_commit
               }).execute();
';
