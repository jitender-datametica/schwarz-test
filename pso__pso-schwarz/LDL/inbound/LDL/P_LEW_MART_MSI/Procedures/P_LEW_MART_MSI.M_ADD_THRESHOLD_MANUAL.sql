/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.M_ADD_THRESHOLD_MANUAL
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2017    Michael Ueding           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  20.11.2019    Morris, Michael          20191114_2289_ZKP_SG_59_60 (LEAD-8205): Neue Parameter: mshow_price_val_cnt_checker & mshow_price_low_nxt_receipt_val
#  1.3  23.10.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: New parameters for discount (Rabatt) metrics
#  1.4  29.12.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: Complete column comments
#  1.5  22.01.2021    Wandtke, Andrzej         AP0056021 Migrate to SF
#  1.6  13.05.2021    Wandtke, Andrzej         AP0056038 20210216_2750_ZKP_RET_NO_RECEIPT: New column mreturn_no_orig_receipt_cnt_checker for metrics Money return with no original receipt
#  1.7  05.11.2021    Wandtke, Andrzej         AP0089687 "EXECUTE AS CALLER" replaced by "EXECUTE AS OWNER" : this enables access to P_LEW_CORE_AC layer. Otherwise, when called by MSTR will give an error as MSTR user has no rights to access core layer
#  1.8  07.07.2023	 Kowalik, Aleksander	     AP0122629 BBT-4561 | ZKP | Anpassung Kennzahl Preisanzeige: new columns for 2 new Preisanzeige thresholds: Wert Preisanzeigen mit Non-Food Artikeln >= X LW and Anzahl Vorgänge >X Preisanzeigen in Folge
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.M_ADD_THRESHOLD_MANUAL
(CLIENT_ID FLOAT, MVOID_QUOTE_CNT_CHECKER FLOAT, MVOID_PER100_TRANS_CNT_CHECKER FLOAT, MVOID_VAL_CNT_CHECKER FLOAT, MABO_QTY_TRANS_CNT_CHECKER FLOAT, MABO_VAL_CNT_CHECKER FLOAT, MSUSP_QTY_TRANS_CNT_CHECKER FLOAT, MRETURN_QUOTE_CNT_CHECKER FLOAT, MRETURN_VAL_CNT_CHECKER FLOAT, MRET_AMOUNT_TRANS_CNT_CHECKER FLOAT, MDEPOSIT_QUOTE_CNT_CHECKER FLOAT, MDEPOSIT_MAN_VAL_CNT_CHECKER FLOAT, MDEPOSIT_ALL_VAL_CNT_CHECKER FLOAT, MOTHERS_QTY_LOWVAL_CNT_CHECKER FLOAT, MOTHERS_QTY_LOGIN_CNT_CHECKER FLOAT, MSUSP_ABORTED_RECEIPT_VAL FLOAT, MOTHERS_LOW_RECEIPT_VAL FLOAT, MVOID_SAME_ITEM_CNT FLOAT, MVOID_ITEM_VAL FLOAT, MRECEIPT_VOID_VAL FLOAT, MRETURN_MANUAL_CNT_CHECKER FLOAT, MSHOW_PRICE_VAL_CNT_CHECKER FLOAT, MSHOW_PRICE_LOW_NXT_RECEIPT_VAL FLOAT, MSHOW_PRICE_VAL_NF_LOW FLOAT, MSHOW_PRICE_CNT_VG_INFOLGE_LOW FLOAT, MDISCOUNT_CNT_CHECKER FLOAT, MDISCOUNT_QUOTE_CHECKER FLOAT, MDISCOUNT_CNT_RECEIPT FLOAT, MDISCOUNT_VAL_RECEIPT FLOAT, MRETURN_NO_ORIG_RECEIPT_CNT_CHECKER FLOAT, REQUESTING_USER VARCHAR(128))
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
/* Delete rows with selected CLIENT_ID that already exists.  */
EXEC(`DELETE FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_manual
WHERE  client_id = ?
AND approval_fg = -1`,[CLIENT_ID]);

/* Inserts new row if client_id exists and at least one row changed  */
EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_manual (
    client_id
    ,dat_rec_start
    ,dat_rec_end
    ,mvoid_quote_cnt_checker
    ,mvoid_per100_trans_cnt_checker
    ,mvoid_val_cnt_checker
    ,mabo_qty_trans_cnt_checker
    ,mabo_val_cnt_checker
    ,msusp_qty_trans_cnt_checker
    ,mreturn_quote_cnt_checker
    ,mreturn_val_cnt_checker
    ,mret_amount_trans_cnt_checker
    ,mdeposit_quote_cnt_checker
    ,mdeposit_man_val_cnt_checker
    ,mdeposit_all_val_cnt_checker
    ,mothers_qty_lowval_cnt_checker
    ,mothers_qty_login_cnt_checker
    ,msusp_aborted_receipt_val
    ,mothers_low_receipt_val
    ,mvoid_same_item_cnt
    ,mvoid_item_val
    ,mreceipt_void_val
    ,mreturn_manual_cnt_checker
    ,mshow_price_val_cnt_checker
    ,mshow_price_low_nxt_receipt_val
    ,mshow_price_val_nf_low
	 ,mshow_price_cnt_vg_infolge_low
    ,mdiscount_cnt_checker
    ,mdiscount_quote_checker
    ,mdiscount_cnt_receipt
    ,mdiscount_val_receipt
    ,mreturn_no_orig_receipt_cnt_checker
    ,requesting_user
    ,timestamp_request
    ,approval_fg)
SELECT
    cnt.client_id,
    CURRENT_DATE AS dat_rec_start,
    '9999-12-31'::DATE AS dat_rec_end,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ? requesting_user,
    CURRENT_TIMESTAMP(0) AS timestamp_request,
    -1 AS approval_fg
   FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
   LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_manual AS orig
   ON cnt.client_id = orig.client_id
   AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
   WHERE cnt.client_id = ?
   AND (
         Coalesce(orig.mvoid_quote_cnt_checker            ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mvoid_per100_trans_cnt_checker     ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mvoid_val_cnt_checker              ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mabo_qty_trans_cnt_checker         ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mabo_val_cnt_checker               ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.msusp_qty_trans_cnt_checker        ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mreturn_quote_cnt_checker          ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mreturn_val_cnt_checker            ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mret_amount_trans_cnt_checker      ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mdeposit_quote_cnt_checker         ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mdeposit_man_val_cnt_checker       ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mdeposit_all_val_cnt_checker       ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mothers_qty_lowval_cnt_checker     ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mothers_qty_login_cnt_checker      ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.msusp_aborted_receipt_val          ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mothers_low_receipt_val            ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mvoid_same_item_cnt                ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mvoid_item_val                     ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mreceipt_void_val                  ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mreturn_manual_cnt_checker         ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mshow_price_val_cnt_checker        ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mshow_price_low_nxt_receipt_val    ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mshow_price_val_nf_low             ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mshow_price_cnt_vg_infolge_low     ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mdiscount_cnt_checker              ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mdiscount_quote_checker            ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mdiscount_cnt_receipt              ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mdiscount_val_receipt              ,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR Coalesce(orig.mreturn_no_orig_receipt_cnt_checker,-99999999999999)  <> Coalesce(?, -99999999999999)
      OR orig.client_id IS NULL
)`,[MVOID_QUOTE_CNT_CHECKER,MVOID_PER100_TRANS_CNT_CHECKER,MVOID_VAL_CNT_CHECKER,MABO_QTY_TRANS_CNT_CHECKER,MABO_VAL_CNT_CHECKER,MSUSP_QTY_TRANS_CNT_CHECKER,MRETURN_QUOTE_CNT_CHECKER,MRETURN_VAL_CNT_CHECKER,MRET_AMOUNT_TRANS_CNT_CHECKER,MDEPOSIT_QUOTE_CNT_CHECKER,MDEPOSIT_MAN_VAL_CNT_CHECKER,MDEPOSIT_ALL_VAL_CNT_CHECKER,MOTHERS_QTY_LOWVAL_CNT_CHECKER,MOTHERS_QTY_LOGIN_CNT_CHECKER,MSUSP_ABORTED_RECEIPT_VAL,MOTHERS_LOW_RECEIPT_VAL,MVOID_SAME_ITEM_CNT,MVOID_ITEM_VAL,MRECEIPT_VOID_VAL,MRETURN_MANUAL_CNT_CHECKER,MSHOW_PRICE_VAL_CNT_CHECKER,MSHOW_PRICE_LOW_NXT_RECEIPT_VAL,MSHOW_PRICE_VAL_NF_LOW,MSHOW_PRICE_CNT_VG_INFOLGE_LOW,MDISCOUNT_CNT_CHECKER,MDISCOUNT_QUOTE_CHECKER,MDISCOUNT_CNT_RECEIPT,MDISCOUNT_VAL_RECEIPT,MRETURN_NO_ORIG_RECEIPT_CNT_CHECKER,REQUESTING_USER,CLIENT_ID,MVOID_QUOTE_CNT_CHECKER,MVOID_PER100_TRANS_CNT_CHECKER,MVOID_VAL_CNT_CHECKER,MABO_QTY_TRANS_CNT_CHECKER,MABO_VAL_CNT_CHECKER,MSUSP_QTY_TRANS_CNT_CHECKER,MRETURN_QUOTE_CNT_CHECKER,MRETURN_VAL_CNT_CHECKER,MRET_AMOUNT_TRANS_CNT_CHECKER,MDEPOSIT_QUOTE_CNT_CHECKER,MDEPOSIT_MAN_VAL_CNT_CHECKER,MDEPOSIT_ALL_VAL_CNT_CHECKER,MOTHERS_QTY_LOWVAL_CNT_CHECKER,MOTHERS_QTY_LOGIN_CNT_CHECKER,MSUSP_ABORTED_RECEIPT_VAL,MOTHERS_LOW_RECEIPT_VAL,MVOID_SAME_ITEM_CNT,MVOID_ITEM_VAL,MRECEIPT_VOID_VAL,MRETURN_MANUAL_CNT_CHECKER,MSHOW_PRICE_VAL_CNT_CHECKER,MSHOW_PRICE_LOW_NXT_RECEIPT_VAL,MSHOW_PRICE_VAL_NF_LOW,MSHOW_PRICE_CNT_VG_INFOLGE_LOW,MDISCOUNT_CNT_CHECKER,MDISCOUNT_QUOTE_CHECKER,MDISCOUNT_CNT_RECEIPT,MDISCOUNT_VAL_RECEIPT,MRETURN_NO_ORIG_RECEIPT_CNT_CHECKER]);

var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$
;

