/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.M_THRESHOLD_APPROVAL
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2017    Michael Ueding           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  08.11.2021    Wandtke,Andrzej          AP0089687 Section Update manual threshold table, Opens rows with -1 flag: put approval_fg <> 1 instead of ? <> 1. Literal approval_fg refers now to the field in a table, not a parameter.
#  1.3  27.06.2022    Wandtke,Andrzej          BS0011299_ZKP_CLEAN "EXECUTE AS CALLER" replaced by "EXECUTE AS OWNER"
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.M_THRESHOLD_APPROVAL 
(CLIENT_ID FLOAT, APPROVAL_FG FLOAT, APPROVAL_USER VARCHAR(128), APPROVAL_RECEIPT_FG FLOAT, APPROVAL_MANUAL_FG FLOAT, APPROVAL_CUMULATION_FG FLOAT, APPROVAL_SCENARIO_FG FLOAT)
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
//===================================================================
//Update receipt threshold table
//===================================================================
//Closes opened records with same client_id if there is a new value in with flag -1 in a table.
EXEC(`UPDATE p_lew_mart_msi.t_msi_ejr_lp_threshold_receipt_2 
SET dat_rec_end = Current_Date - 1
WHERE client_id = ?
AND dat_rec_end = '9999-12-31'::DATE
AND approval_fg = ?
AND ? = 1
AND EXISTS (
   SELECT 1
   FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_receipt_2
   WHERE client_id = ?
   AND APPROVAL_FG <> 1
   AND ? = 1
   AND requesting_user <> ?
)`,[CLIENT_ID,APPROVAL_FG,APPROVAL_RECEIPT_FG,CLIENT_ID,APPROVAL_FG,APPROVAL_USER]);

// Opens rows with -1 flag, correct client_id.
EXEC(`UPDATE p_lew_mart_msi.t_msi_ejr_lp_threshold_receipt_2 
SET dat_rec_start = Current_Date
,approval_fg = ?
,approval_user = ?
,timestamp_approval = Current_Timestamp(0)
WHERE client_id = ?
AND dat_rec_end = '9999-12-31'::DATE
AND APPROVAL_FG <> 1
AND ? = 1
AND requesting_user <> ?`,
[APPROVAL_FG,APPROVAL_USER,CLIENT_ID,APPROVAL_RECEIPT_FG,APPROVAL_USER]);

// Deletes all rows that were closed before being in use. Solves if row is updated multiple times per day.
EXEC(`
DELETE FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_receipt_2
WHERE dat_rec_start > dat_rec_end`,[]);

//===================================================================
//Update manual threshold table
//===================================================================
//Closes opened records with same client_id if there is a new value in with flag -1 in a table.
EXEC(`UPDATE p_lew_mart_msi.t_msi_ejr_lp_threshold_manual_2 
SET dat_rec_end = Current_Date - 1
WHERE client_id = ?
AND dat_rec_end = '9999-12-31'::DATE
AND approval_fg = ?
AND ? = 1
AND EXISTS (
   SELECT 1
   FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_manual_2
   WHERE client_id = ?
   AND APPROVAL_FG <> 1
   AND ? = 1
   AND requesting_user <> ?
)`,[CLIENT_ID,APPROVAL_FG,APPROVAL_MANUAL_FG,CLIENT_ID,APPROVAL_FG,APPROVAL_USER]);

//Opens rows with -1 flag, correct client_id.
EXEC(`UPDATE p_lew_mart_msi.t_msi_ejr_lp_threshold_manual_2 
SET dat_rec_start = Current_Date
,approval_fg = ?
,approval_user = ?
,timestamp_approval = Current_Timestamp(0)
WHERE client_id = ?
AND dat_rec_end = '9999-12-31'::DATE
AND approval_fg <> 1
AND ? = 1
AND requesting_user <> ?`,
[APPROVAL_FG,APPROVAL_USER,CLIENT_ID,APPROVAL_MANUAL_FG,APPROVAL_USER]);

//Deletes all rows that were closed before being in use. Solves if row is updated multiple times per day.
EXEC(`
DELETE FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_manual_2
WHERE dat_rec_start > dat_rec_end`,[]);

//===================================================================
//Update cumulation threshold table
//===================================================================
//Closes opened records with same client_id if there is a new value in with flag -1 in a table.
EXEC(`UPDATE p_lew_mart_msi.t_msi_ejr_lp_threshold_cumulation_2 
SET dat_rec_end = Current_Date - 1
WHERE client_id = ?
AND dat_rec_end = '9999-12-31'::DATE
AND approval_fg = ?
AND ? = 1
AND EXISTS (
   SELECT 1
   FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_cumulation_2
   WHERE client_id = ?
   AND APPROVAL_FG <> 1
   AND ? = 1
   AND requesting_user <> ?
)`,[CLIENT_ID,APPROVAL_FG,APPROVAL_CUMULATION_FG,CLIENT_ID,APPROVAL_FG,APPROVAL_USER]);

//Opens rows with -1 flag, correct client_id.
EXEC(`UPDATE p_lew_mart_msi.t_msi_ejr_lp_threshold_cumulation_2 
SET dat_rec_start = Current_Date
,approval_fg = ?
,approval_user = ?
,timestamp_approval = Current_Timestamp(0)
WHERE client_id = ?
AND dat_rec_end = '9999-12-31'::DATE
AND APPROVAL_FG <> 1
AND ? = 1
AND requesting_user <> ?`
,[APPROVAL_FG,APPROVAL_USER,CLIENT_ID,APPROVAL_CUMULATION_FG,APPROVAL_USER]);

// Deletes all rows that were closed before being in use. Solves if row is updated multiple times per day.
EXEC(`
DELETE FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_cumulation_2
WHERE dat_rec_start > dat_rec_end`,[]);

//===================================================================
//Update scenario threshold table (Attention: threshold_group_id is part of PK)
//===================================================================

//Closes opened records with same client_id/threshold_group_id if at least one of the values had changed.
EXEC(`UPDATE p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_2 
SET dat_rec_end = Current_Date - 1
WHERE client_id = ?
AND dat_rec_end = '9999-12-31'::DATE
AND approval_fg = ?
AND ? = 1
AND EXISTS (
   SELECT 1
   FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_2 s
   WHERE s.client_id = ?
   AND s.approval_fg <> 1
   AND ? = 1
   AND s.requesting_user <> ?
   AND s.threshold_group_id = p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario.threshold_group_id
)`,[CLIENT_ID,APPROVAL_FG,APPROVAL_SCENARIO_FG,CLIENT_ID,APPROVAL_FG,APPROVAL_USER]);

//Opens rows with -1 flag, correct client_id.
EXEC(`UPDATE p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_2 
SET dat_rec_start = Current_Date
   ,approval_fg = ?
   ,approval_user = ?
   ,timestamp_approval = Current_Timestamp(0)
WHERE client_id = ?
AND dat_rec_end = '9999-12-31'::DATE
AND APPROVAL_FG <> 1
AND ? = 1
AND requesting_user <> ?`,[APPROVAL_FG,APPROVAL_USER,CLIENT_ID,APPROVAL_SCENARIO_FG,APPROVAL_USER]);

// Deletes all rows that were closed before being in use. Solves if row is updated multiple times per day.
EXEC(`
DELETE FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_2
WHERE dat_rec_start > dat_rec_end`,[]);

var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
$$
;

