/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for m_ins_t_sys_revision_request
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2017    Michael Ueding           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  22.03.2018    Andrzej Wandtke          20180315_1616_Change_Time_Range_Macro_Team1 - modify the fields x_dat_formdate_from, x_dat_formdate_until
#  1.3  05.03.2021    Andrzej Wandtke          20210305_2774_ZKP_Rabatt_PrufThema AP0056021 - new column for discount (Rabatt) metrics
#  1.4  05.11.2021    Wandtke,Andrzej          AP0089687  "EXECUTE AS CALLER" replaced by "EXECUTE AS OWNER" : this enables access to P_LEW_CORE_AC layer. Otherwise, when called by MSTR will give an error as MSTR user has no rights to access core layer
#  1.5  08.03.2023    Wandtke,Andrzej          AP0163973 - NSR3520115 - Prüfungszeitraum (proofing period) on test environment changed from 4 to 8, calculation of x_dat_formdate_until
#  1.6  11.12.2023    Wandtke,Andrzej          AP0191702 - Prüfungszeitraum (proofing period): set it to 8 weeks for warehouses, 12 weeks for stores, same on Q and P
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.M_INS_T_SYS_REVISION_REQUEST
(CLIENT_ID FLOAT, WH_ID FLOAT, ORIG_STORE_NR FLOAT, REQUESTING_USER VARCHAR(100), DAT_FORMDATE_FROM DATE, DAT_FORMDATE_UNTIL DATE, VOID_FG FLOAT, DEPOSIT_FG FLOAT, RETURN_FG FLOAT, ABORTED_SUSPENDED_FG FLOAT, DISCOUNT_FG FLOAT, OTHER_FG FLOAT, REVISION_TEST_FG FLOAT)
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

EXEC(`INSERT INTO p_lew_mart_msi.t_msi_sys_revision_request (
  client_id
, wh_loc_sid
, orig_store_nr
, requesting_user
, dat_formdate_until
, dat_formdate_from
, void_fg
, deposit_fg
, return_fg
, aborted_suspended_fg
, discount_fg
, other_fg
, revision_test_fg)
SELECT ?
   , (SELECT loc_sid 
      FROM p_lew_core_ac.v_loc_map_key WHERE client_id = ? AND wawi_dwh_wh_id = ?)
   , ? AS x_orig_store_nr
   , ?
   , CASE WHEN ? IN (0, 1)
          THEN ((Current_Date - (MOD((Current_Date - DATE '0001-01-01'), 7)))) + 4
          WHEN ? IS NOT NULL AND ? <> DATE '1900-01-01'
          THEN ?
     END AS x_dat_formdate_until
   , CASE WHEN ? IN (0, 1) THEN 
		  CASE WHEN x_orig_store_nr IS NULL THEN x_dat_formdate_until - (7 * 8) + 3 -- warehouse: 8 weeks period
		  ELSE x_dat_formdate_until - (7 * 12) + 3                                  -- store: 8 weeks period
		  END
          WHEN ? IS NOT NULL AND ? <> DATE '1900-01-01'
          THEN ?
     END AS x_dat_formdate_from
   , ?
   , ?
   , ?
   , ?
   , ?
   , ?
   , ?
WHERE EXISTS
  (SELECT 1
   FROM p_lew_core_ac.v_wawi_org_store_skey a
   WHERE (?, wh_loc_sid) IN (SELECT 
                              client_id,
                              loc_sid
                             FROM p_lew_core_ac.v_loc_map_key
                             WHERE client_id = ?
                             AND wawi_dwh_wh_id = ?
                              )
      )`
,[CLIENT_ID,CLIENT_ID,WH_ID,ORIG_STORE_NR,REQUESTING_USER,REVISION_TEST_FG,DAT_FORMDATE_UNTIL,DAT_FORMDATE_UNTIL,DAT_FORMDATE_UNTIL,REVISION_TEST_FG,DAT_FORMDATE_FROM,DAT_FORMDATE_FROM,DAT_FORMDATE_FROM,VOID_FG,DEPOSIT_FG,RETURN_FG,ABORTED_SUSPENDED_FG,DISCOUNT_FG,OTHER_FG,REVISION_TEST_FG,CLIENT_ID,CLIENT_ID,WH_ID]);

var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
$$
;

