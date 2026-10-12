/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.m_add_threshold_receipt
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2017    Michael Ueding           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  26.04.2018    Wandtke,Andrzej          20180419_1646_ZKP_Creation_Threshold_Team1 Add 2 columns in the table t_msi_ejr_lp_threshold_receipt_1 and in the parameter list
#  1.3  21.10.2019    Morris, Michael          20191021_2259_ZKP_BBT_272_398 (Jira: LEAD-7462): New parameter susp_subseqent_trans_low_val_mc
#  1.4  04.12.2019    Morris, Michael          20191114_2287_ZKP_SG_61 (REP1-6730) New column return_same_checker_val
#  1.5  24.05.2021    Wandtke,Andrzej          AP0056037 20210428_2816_ZKP_Void_Tran: Add column void_1itm_receipt_val
#  1.6  03.11.2021    Wandtke,Andrzej          AP0089687 Correct misplaced line: OR orig.client_id IS NULL
#  1.7  04.11.2021    Wandtke,Andrzej          AP0089687 "EXECUTE AS CALLER" replaced by "EXECUTE AS OWNER" : this enables access to P_LEW_CORE_AC layer. Otherwise, when called by MSTR will give an error as MSTR user has no rights to access core layer
#  1.8  02.08.2022    Rekovsky,Marvin          AP0105940_ZKP_Pfandbon_manuell+rein: Add column deposit_noitm_tot_val
#  1.9  20.03.2023    Wandtke,Andrzej          AP0152808 : Add parameter return_no_receipt_val
#  2.0  13.04.2023    Wandtke,Andrzej          AP0170366 : Add parameters return_many_itm_cnt, return_many_itm_val
#  2.1  28.08.2023    Kowalik,Aleksander       AP0177990 : Add parameters return_same_checker_val_ebb_m, return_same_checker_val_ebb_l
#  2.2  11.01.2024    Szewczyk,Milosz          AP0182639 : Add parameters void_itm_cnt, void_tot_val_cnt, void_tot_itm_in_receipt, void_receipt_cnt, void_1itm_receipt_val_2
#  2.3  12.03.2024    Szewczyk,Milosz          AP0188368 : Add parameters plus_rec_month, plus_rec_day
#  2.4  22.04.2024    Kowalik,Aleksander       AP0198132 : Add parameters susp_aborted_tot_qty, susp_aborted_tot_val, susp_aborted_subsequent_trans_low_val
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.M_ADD_THRESHOLD_RECEIPT
(CLIENT_ID FLOAT, VOID_TOT_VAL_AFT_SUBTOT FLOAT, SUSP_TOT_VAL FLOAT, SUSP_SUBSEQUENT_TRANS_LOW_VAL FLOAT, SUSP_VOIDED_EXP_LAST_VOID_VAL FLOAT, RETURN_ITEM_PRICE FLOAT, RETURN_TOT_VAL FLOAT, RETURN_VALUE FLOAT, RETURN_TOT_VAL_NF FLOAT, DEPOSIT_SCANNED_VALUE FLOAT, DEPOSIT_SCANNED_QTY_INTEGER FLOAT, DEPOSIT_1ITM_PLUS_EMPTY_RET FLOAT, DEPOSIT_AMT_PLUS_EMPTY_RET FLOAT, PRICE_SUBSEQ_TRANS_LOW_VAL FLOAT, SUSP_VOIDED_EXP_LAST_VOID_VAL2 FLOAT, DEPOSIT_1ITM_RECEIPT_VAL FLOAT, DEPOSIT_1ITM_ITEM_VAL FLOAT, DEPOSIT_NOITM_TOT_VAL FLOAT, PRICE_SERIES_RECEIPT_CNT FLOAT, PRICE_SERIES_RECEIPT_TOTAL_VAL FLOAT, RETURN_SAME_RECEIPT_QTY FLOAT, RETURN_SAME_RECEIPT_VAL FLOAT, RETURN_NOT_AUTHORISED_VAL FLOAT, RETURN_NOT_AUTHORISED_VAL2 FLOAT, PRICE_SUBSEQ_TRANS_LOW_VAL2 FLOAT, SUSP_SUBSEQENT_TRANS_LOW_VAL_MC FLOAT, RETURN_SAME_CHECKER_VAL FLOAT, RETURN_SAME_CHECKER_VAL_EBB_M FLOAT, RETURN_SAME_CHECKER_VAL_EBB_L FLOAT, void_1itm_receipt_val FLOAT, return_no_receipt_val FLOAT, return_many_itm_cnt FLOAT, return_many_itm_val FLOAT, void_itm_cnt FLOAT, void_tot_val_cnt FLOAT, void_tot_itm_in_receipt FLOAT, void_receipt_cnt FLOAT, void_1itm_receipt_val_2 FLOAT, plus_rec_month FLOAT, plus_rec_day FLOAT, SUSP_ABORTED_TOT_QTY FLOAT, SUSP_ABORTED_TOT_VAL FLOAT, SUSP_ABORTED_SUBSEQUENT_TRANS_LOW_VAL FLOAT, REQUESTING_USER VARCHAR(128))
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

/* Delete rows with selected CLIENT_ID that already exists. */
EXEC(`DELETE FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_receipt_1
WHERE  client_id = ?
AND approval_fg = -1`,[CLIENT_ID]);

/* Inserts new row if client_id exists and at least one row changed */
EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_receipt_1 (
client_id
,dat_rec_start
,dat_rec_end
,void_tot_val_aft_subtot
,susp_tot_val
,susp_subsequent_trans_low_val
,susp_voided_exp_last_void_val
,return_item_price
,return_tot_val
,return_value
,return_tot_val_nf
,deposit_scanned_value
,deposit_scanned_qty_integer
,deposit_1itm_plus_empty_ret
,deposit_amt_plus_empty_ret
,price_subseq_trans_low_val
,susp_voided_exp_last_void_val2
,deposit_1itm_receipt_val
,deposit_1itm_item_val
,deposit_noitm_tot_val
,price_series_receipt_cnt
,price_series_receipt_total_val
,return_same_receipt_qty
,return_same_receipt_val
,return_not_authorised_val
,return_not_authorised_val2
,price_subseq_trans_low_val2
,susp_subseqent_trans_low_val_mc
,return_same_checker_val
,return_same_checker_val_ebb_m
,return_same_checker_val_ebb_l
,void_1itm_receipt_val
,return_no_receipt_val
,return_many_itm_cnt
,return_many_itm_val
,void_itm_cnt
,void_tot_val_cnt
,void_tot_itm_in_receipt
,void_receipt_cnt
,void_1itm_receipt_val_2
,plus_rec_month
,plus_rec_day
,susp_aborted_tot_qty
,susp_aborted_tot_val
,susp_aborted_subsequent_trans_low_val
,requesting_user
,timestamp_request
,approval_fg)
SELECT
cnt.client_id,
Current_Date AS dat_rec_start,
'9999-12-31' AS dat_rec_end,
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
Current_Timestamp(0) AS timestamp_request,
-1 AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_receipt_1 AS orig
ON cnt.client_id = orig.client_id
AND Current_Date BETWEEN orig.dat_rec_start AND orig.dat_rec_end
WHERE cnt.client_id = ?
AND
(
   Coalesce(orig.void_tot_val_aft_subtot          ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.susp_tot_val                     ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.susp_subsequent_trans_low_val    ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.susp_voided_exp_last_void_val    ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.return_item_price                ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.return_tot_val                   ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.return_value                     ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.return_tot_val_nf                ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.deposit_scanned_value            ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.deposit_scanned_qty_integer      ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.deposit_1itm_plus_empty_ret      ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.deposit_amt_plus_empty_ret       ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.price_subseq_trans_low_val       ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.susp_voided_exp_last_void_val2   ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.deposit_1itm_receipt_val         ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.deposit_1itm_item_val            ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.deposit_noitm_tot_val            ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.price_series_receipt_cnt         ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.price_series_receipt_total_val   ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.return_same_receipt_qty          ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.return_same_receipt_val          ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.return_not_authorised_val        ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.return_not_authorised_val2       ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.price_subseq_trans_low_val2      ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.susp_subseqent_trans_low_val_mc  ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.return_same_checker_val          ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.return_same_checker_val_ebb_m    ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.return_same_checker_val_ebb_l    ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.void_1itm_receipt_val            ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.return_no_receipt_val            ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.return_many_itm_cnt              ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.return_many_itm_val              ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.void_itm_cnt                     ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.void_tot_val_cnt                 ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.void_tot_itm_in_receipt          ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.void_receipt_cnt                 ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.void_1itm_receipt_val_2          ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.plus_rec_month                   ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.plus_rec_day                     ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.susp_aborted_tot_qty             ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.susp_aborted_tot_val             ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.susp_aborted_subsequent_trans_low_val             ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR orig.client_id IS NULL)`
,[VOID_TOT_VAL_AFT_SUBTOT,SUSP_TOT_VAL,SUSP_SUBSEQUENT_TRANS_LOW_VAL,SUSP_VOIDED_EXP_LAST_VOID_VAL,RETURN_ITEM_PRICE,RETURN_TOT_VAL,RETURN_VALUE,RETURN_TOT_VAL_NF,DEPOSIT_SCANNED_VALUE,DEPOSIT_SCANNED_QTY_INTEGER,DEPOSIT_1ITM_PLUS_EMPTY_RET,DEPOSIT_AMT_PLUS_EMPTY_RET,PRICE_SUBSEQ_TRANS_LOW_VAL,SUSP_VOIDED_EXP_LAST_VOID_VAL2,DEPOSIT_1ITM_RECEIPT_VAL,DEPOSIT_1ITM_ITEM_VAL,DEPOSIT_NOITM_TOT_VAL,PRICE_SERIES_RECEIPT_CNT,PRICE_SERIES_RECEIPT_TOTAL_VAL,RETURN_SAME_RECEIPT_QTY,RETURN_SAME_RECEIPT_VAL,RETURN_NOT_AUTHORISED_VAL,RETURN_NOT_AUTHORISED_VAL2,PRICE_SUBSEQ_TRANS_LOW_VAL2,SUSP_SUBSEQENT_TRANS_LOW_VAL_MC,RETURN_SAME_CHECKER_VAL,RETURN_SAME_CHECKER_VAL_EBB_M,RETURN_SAME_CHECKER_VAL_EBB_L,VOID_1ITM_RECEIPT_VAL,RETURN_NO_RECEIPT_VAL, RETURN_MANY_ITM_CNT, RETURN_MANY_ITM_VAL, VOID_ITM_CNT, VOID_TOT_VAL_CNT, VOID_TOT_ITM_IN_RECEIPT, VOID_RECEIPT_CNT,VOID_1ITM_RECEIPT_VAL_2,PLUS_REC_MONTH,PLUS_REC_DAY,SUSP_ABORTED_TOT_QTY, SUSP_ABORTED_TOT_VAL, SUSP_ABORTED_SUBSEQUENT_TRANS_LOW_VAL, REQUESTING_USER,CLIENT_ID,VOID_TOT_VAL_AFT_SUBTOT,SUSP_TOT_VAL,SUSP_SUBSEQUENT_TRANS_LOW_VAL,SUSP_VOIDED_EXP_LAST_VOID_VAL,RETURN_ITEM_PRICE,RETURN_TOT_VAL,RETURN_VALUE,RETURN_TOT_VAL_NF,DEPOSIT_SCANNED_VALUE,DEPOSIT_SCANNED_QTY_INTEGER,DEPOSIT_1ITM_PLUS_EMPTY_RET,DEPOSIT_AMT_PLUS_EMPTY_RET,PRICE_SUBSEQ_TRANS_LOW_VAL,SUSP_VOIDED_EXP_LAST_VOID_VAL2,DEPOSIT_1ITM_RECEIPT_VAL,DEPOSIT_1ITM_ITEM_VAL,DEPOSIT_NOITM_TOT_VAL,PRICE_SERIES_RECEIPT_CNT,PRICE_SERIES_RECEIPT_TOTAL_VAL,RETURN_SAME_RECEIPT_QTY,RETURN_SAME_RECEIPT_VAL,RETURN_NOT_AUTHORISED_VAL,RETURN_NOT_AUTHORISED_VAL2,PRICE_SUBSEQ_TRANS_LOW_VAL2,SUSP_SUBSEQENT_TRANS_LOW_VAL_MC,RETURN_SAME_CHECKER_VAL,RETURN_SAME_CHECKER_VAL_EBB_M,RETURN_SAME_CHECKER_VAL_EBB_L,VOID_1ITM_RECEIPT_VAL,RETURN_NO_RECEIPT_VAL, RETURN_MANY_ITM_CNT, RETURN_MANY_ITM_VAL, VOID_ITM_CNT, VOID_TOT_VAL_CNT, VOID_TOT_ITM_IN_RECEIPT, VOID_RECEIPT_CNT,VOID_1ITM_RECEIPT_VAL_2,PLUS_REC_MONTH,PLUS_REC_DAY,SUSP_ABORTED_TOT_QTY, SUSP_ABORTED_TOT_VAL, SUSP_ABORTED_SUBSEQUENT_TRANS_LOW_VAL]);

var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;