/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.m_add_threshold_receipt
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2017    Michael Ueding           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  26.04.2018    Wandtke,Andrzej          20180419_1646_ZKP_Creation_Threshold_Team1 Add 2 columns in the table t_msi_ejr_lp_threshold_receipt and in the parameter list
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


CREATE OR REPLACE PROCEDURE `p_lew_mart_msi.m_add_threshold_receipt`(
  CLIENT_ID FLOAT64,
  VOID_TOT_VAL_AFT_SUBTOT FLOAT64,
  SUSP_TOT_VAL FLOAT64,
  SUSP_SUBSEQUENT_TRANS_LOW_VAL FLOAT64,
  SUSP_VOIDED_EXP_LAST_VOID_VAL FLOAT64,
  RETURN_ITEM_PRICE FLOAT64,
  RETURN_TOT_VAL FLOAT64,
  RETURN_VALUE FLOAT64,
  RETURN_TOT_VAL_NF FLOAT64,
  DEPOSIT_SCANNED_VALUE FLOAT64,
  DEPOSIT_SCANNED_QTY_INTEGER FLOAT64,
  DEPOSIT_1ITM_PLUS_EMPTY_RET FLOAT64,
  DEPOSIT_AMT_PLUS_EMPTY_RET FLOAT64,
  PRICE_SUBSEQ_TRANS_LOW_VAL FLOAT64,
  SUSP_VOIDED_EXP_LAST_VOID_VAL2 FLOAT64,
  DEPOSIT_1ITM_RECEIPT_VAL FLOAT64,
  DEPOSIT_1ITM_ITEM_VAL FLOAT64,
  DEPOSIT_NOITM_TOT_VAL FLOAT64,
  PRICE_SERIES_RECEIPT_CNT FLOAT64,
  PRICE_SERIES_RECEIPT_TOTAL_VAL FLOAT64,
  RETURN_SAME_RECEIPT_QTY FLOAT64,
  RETURN_SAME_RECEIPT_VAL FLOAT64,
  RETURN_NOT_AUTHORISED_VAL FLOAT64,
  RETURN_NOT_AUTHORISED_VAL2 FLOAT64,
  PRICE_SUBSEQ_TRANS_LOW_VAL2 FLOAT64,
  SUSP_SUBSEQENT_TRANS_LOW_VAL_MC FLOAT64,
  RETURN_SAME_CHECKER_VAL FLOAT64,
  RETURN_SAME_CHECKER_VAL_EBB_M FLOAT64,
  RETURN_SAME_CHECKER_VAL_EBB_L FLOAT64,
  void_1itm_receipt_val FLOAT64,
  return_no_receipt_val FLOAT64,
  return_many_itm_cnt FLOAT64,
  return_many_itm_val FLOAT64,
  void_itm_cnt FLOAT64,
  void_tot_val_cnt FLOAT64,
  void_tot_itm_in_receipt FLOAT64,
  void_receipt_cnt FLOAT64,
  void_1itm_receipt_val_2 FLOAT64,
  plus_rec_month FLOAT64,
  plus_rec_day FLOAT64,
  SUSP_ABORTED_TOT_QTY FLOAT64,
  SUSP_ABORTED_TOT_VAL FLOAT64,
  SUSP_ABORTED_SUBSEQUENT_TRANS_LOW_VAL FLOAT64,
  REQUESTING_USER STRING
)
BEGIN

  EXECUTE IMMEDIATE """
    DELETE FROM `p_lew_mart_msi.t_msi_ejr_lp_threshold_receipt`
    WHERE client_id = @CLIENT_ID
    AND approval_fg = -1
  """ USING CLIENT_ID AS CLIENT_ID;

  EXECUTE IMMEDIATE """
    INSERT INTO `p_lew_mart_msi.t_msi_ejr_lp_threshold_receipt` (
      client_id, dat_rec_start, dat_rec_end, void_tot_val_aft_subtot, susp_tot_val,
      susp_subsequent_trans_low_val, susp_voided_exp_last_void_val, return_item_price,
      return_tot_val, return_value, return_tot_val_nf, deposit_scanned_value,
      deposit_scanned_qty_integer, deposit_1itm_plus_empty_ret, deposit_amt_plus_empty_ret,
      price_subseq_trans_low_val, susp_voided_exp_last_void_val2, deposit_1itm_receipt_val,
      deposit_1itm_item_val, deposit_noitm_tot_val, price_series_receipt_cnt,
      price_series_receipt_total_val, return_same_receipt_qty, return_same_receipt_val,
      return_not_authorised_val, return_not_authorised_val2, price_subseq_trans_low_val2,
      susp_subseqent_trans_low_val_mc, return_same_checker_val, return_same_checker_val_ebb_m,
      return_same_checker_val_ebb_l, void_1itm_receipt_val, return_no_receipt_val,
      return_many_itm_cnt, return_many_itm_val, void_itm_cnt, void_tot_val_cnt,
      void_tot_itm_in_receipt, void_receipt_cnt, void_1itm_receipt_val_2, plus_rec_month,
      plus_rec_day, susp_aborted_tot_qty, susp_aborted_tot_val,
      susp_aborted_subsequent_trans_low_val, requesting_user, timestamp_request, approval_fg
    )
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin") AS dat_rec_start,
      DATE'9999-12-31' AS dat_rec_end,
      @VOID_TOT_VAL_AFT_SUBTOT, @SUSP_TOT_VAL, @SUSP_SUBSEQUENT_TRANS_LOW_VAL,
      @SUSP_VOIDED_EXP_LAST_VOID_VAL, @RETURN_ITEM_PRICE, @RETURN_TOT_VAL,
      @RETURN_VALUE, @RETURN_TOT_VAL_NF, @DEPOSIT_SCANNED_VALUE,
      @DEPOSIT_SCANNED_QTY_INTEGER, @DEPOSIT_1ITM_PLUS_EMPTY_RET,
      @DEPOSIT_AMT_PLUS_EMPTY_RET, @PRICE_SUBSEQ_TRANS_LOW_VAL,
      @SUSP_VOIDED_EXP_LAST_VOID_VAL2, @DEPOSIT_1ITM_RECEIPT_VAL,
      @DEPOSIT_1ITM_ITEM_VAL, @DEPOSIT_NOITM_TOT_VAL, @PRICE_SERIES_RECEIPT_CNT,
      @PRICE_SERIES_RECEIPT_TOTAL_VAL, @RETURN_SAME_RECEIPT_QTY,
      @RETURN_SAME_RECEIPT_VAL, @RETURN_NOT_AUTHORISED_VAL,
      @RETURN_NOT_AUTHORISED_VAL2, @PRICE_SUBSEQ_TRANS_LOW_VAL2,
      @SUSP_SUBSEQENT_TRANS_LOW_VAL_MC, @RETURN_SAME_CHECKER_VAL,
      @RETURN_SAME_CHECKER_VAL_EBB_M, @RETURN_SAME_CHECKER_VAL_EBB_L,
      @void_1itm_receipt_val, @return_no_receipt_val, @return_many_itm_cnt,
      @return_many_itm_val, @void_itm_cnt, @void_tot_val_cnt,
      @void_tot_itm_in_receipt, @void_receipt_cnt, @void_1itm_receipt_val_2,
      @plus_rec_month, @plus_rec_day, @SUSP_ABORTED_TOT_QTY,
      @SUSP_ABORTED_TOT_VAL, @SUSP_ABORTED_SUBSEQUENT_TRANS_LOW_VAL,
      @REQUESTING_USER AS requesting_user,
      CAST(CURRENT_TIMESTAMP() AS DATETIME) AS timestamp_request,
      -1 AS approval_fg
    FROM `p_lew_core_ac.v_wawi_ref_client_country` AS cnt
    LEFT OUTER JOIN `p_lew_mart_msi.t_msi_ejr_lp_threshold_receipt` AS orig
    ON cnt.client_id = orig.client_id
    AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
    WHERE cnt.client_id = @CLIENT_ID
    AND
    (
       COALESCE(orig.void_tot_val_aft_subtot, -99999999999999) <> COALESCE(@VOID_TOT_VAL_AFT_SUBTOT, -99999999999999)
    OR COALESCE(orig.susp_tot_val, -99999999999999) <> COALESCE(@SUSP_TOT_VAL, -99999999999999)
    OR COALESCE(orig.susp_subsequent_trans_low_val, -99999999999999) <> COALESCE(@SUSP_SUBSEQUENT_TRANS_LOW_VAL, -99999999999999)
    OR COALESCE(orig.susp_voided_exp_last_void_val, -99999999999999) <> COALESCE(@SUSP_VOIDED_EXP_LAST_VOID_VAL, -99999999999999)
    OR COALESCE(orig.return_item_price, -99999999999999) <> COALESCE(@RETURN_ITEM_PRICE, -99999999999999)
    OR COALESCE(orig.return_tot_val, -99999999999999) <> COALESCE(@RETURN_TOT_VAL, -99999999999999)
    OR COALESCE(orig.return_value, -99999999999999) <> COALESCE(@RETURN_VALUE, -99999999999999)
    OR COALESCE(orig.return_tot_val_nf, -99999999999999) <> COALESCE(@RETURN_TOT_VAL_NF, -99999999999999)
    OR COALESCE(orig.deposit_scanned_value, -99999999999999) <> COALESCE(@DEPOSIT_SCANNED_VALUE, -99999999999999)
    OR COALESCE(orig.deposit_scanned_qty_integer, -99999999999999) <> COALESCE(@DEPOSIT_SCANNED_QTY_INTEGER, -99999999999999)
    OR COALESCE(orig.deposit_1itm_plus_empty_ret, -99999999999999) <> COALESCE(@DEPOSIT_1ITM_PLUS_EMPTY_RET, -99999999999999)
    OR COALESCE(orig.deposit_amt_plus_empty_ret, -99999999999999) <> COALESCE(@DEPOSIT_AMT_PLUS_EMPTY_RET, -99999999999999)
    OR COALESCE(orig.price_subseq_trans_low_val, -99999999999999) <> COALESCE(@PRICE_SUBSEQ_TRANS_LOW_VAL, -99999999999999)
    OR COALESCE(orig.susp_voided_exp_last_void_val2, -99999999999999) <> COALESCE(@SUSP_VOIDED_EXP_LAST_VOID_VAL2, -99999999999999)
    OR COALESCE(orig.deposit_1itm_receipt_val, -99999999999999) <> COALESCE(@DEPOSIT_1ITM_RECEIPT_VAL, -99999999999999)
    OR COALESCE(orig.deposit_1itm_item_val, -99999999999999) <> COALESCE(@DEPOSIT_1ITM_ITEM_VAL, -99999999999999)
    OR COALESCE(orig.deposit_noitm_tot_val, -99999999999999) <> COALESCE(@DEPOSIT_NOITM_TOT_VAL, -99999999999999)
    OR COALESCE(orig.price_series_receipt_cnt, -99999999999999) <> COALESCE(@PRICE_SERIES_RECEIPT_CNT, -99999999999999)
    OR COALESCE(orig.price_series_receipt_total_val, -99999999999999) <> COALESCE(@PRICE_SERIES_RECEIPT_TOTAL_VAL, -99999999999999)
    OR COALESCE(orig.return_same_receipt_qty, -99999999999999) <> COALESCE(@RETURN_SAME_RECEIPT_QTY, -99999999999999)
    OR COALESCE(orig.return_same_receipt_val, -99999999999999) <> COALESCE(@RETURN_SAME_RECEIPT_VAL, -99999999999999)
    OR COALESCE(orig.return_not_authorised_val, -99999999999999) <> COALESCE(@RETURN_NOT_AUTHORISED_VAL, -99999999999999)
    OR COALESCE(orig.return_not_authorised_val2, -99999999999999) <> COALESCE(@RETURN_NOT_AUTHORISED_VAL2, -99999999999999)
    OR COALESCE(orig.price_subseq_trans_low_val2, -99999999999999) <> COALESCE(@PRICE_SUBSEQ_TRANS_LOW_VAL2, -99999999999999)
    OR COALESCE(orig.susp_subseqent_trans_low_val_mc, -99999999999999) <> COALESCE(@SUSP_SUBSEQENT_TRANS_LOW_VAL_MC, -99999999999999)
    OR COALESCE(orig.return_same_checker_val, -99999999999999) <> COALESCE(@RETURN_SAME_CHECKER_VAL, -99999999999999)
    OR COALESCE(orig.return_same_checker_val_ebb_m, -99999999999999) <> COALESCE(@RETURN_SAME_CHECKER_VAL_EBB_M, -99999999999999)
    OR COALESCE(orig.return_same_checker_val_ebb_l, -99999999999999) <> COALESCE(@RETURN_SAME_CHECKER_VAL_EBB_L, -99999999999999)
    OR COALESCE(orig.void_1itm_receipt_val, -99999999999999) <> COALESCE(@void_1itm_receipt_val, -99999999999999)
    OR COALESCE(orig.return_no_receipt_val, -99999999999999) <> COALESCE(@return_no_receipt_val, -99999999999999)
    OR COALESCE(orig.return_many_itm_cnt, -99999999999999) <> COALESCE(@return_many_itm_cnt, -99999999999999)
    OR COALESCE(orig.return_many_itm_val, -99999999999999) <> COALESCE(@return_many_itm_val, -99999999999999)
    OR COALESCE(orig.void_itm_cnt, -99999999999999) <> COALESCE(@void_itm_cnt, -99999999999999)
    OR COALESCE(orig.void_tot_val_cnt, -99999999999999) <> COALESCE(@void_tot_val_cnt, -99999999999999)
    OR COALESCE(orig.void_tot_itm_in_receipt, -99999999999999) <> COALESCE(@void_tot_itm_in_receipt, -99999999999999)
    OR COALESCE(orig.void_receipt_cnt, -99999999999999) <> COALESCE(@void_receipt_cnt, -99999999999999)
    OR COALESCE(orig.void_1itm_receipt_val_2, -99999999999999) <> COALESCE(@void_1itm_receipt_val_2, -99999999999999)
    OR COALESCE(orig.plus_rec_month, -99999999999999) <> COALESCE(@plus_rec_month, -99999999999999)
    OR COALESCE(orig.plus_rec_day, -99999999999999) <> COALESCE(@plus_rec_day, -99999999999999)
    OR COALESCE(orig.susp_aborted_tot_qty, -99999999999999) <> COALESCE(@SUSP_ABORTED_TOT_QTY, -99999999999999)
    OR COALESCE(orig.susp_aborted_tot_val, -99999999999999) <> COALESCE(@SUSP_ABORTED_TOT_VAL, -99999999999999)
    OR COALESCE(orig.susp_aborted_subsequent_trans_low_val, -99999999999999) <> COALESCE(@SUSP_ABORTED_SUBSEQUENT_TRANS_LOW_VAL, -99999999999999)
    OR orig.client_id IS NULL)
  """ USING
    CLIENT_ID AS CLIENT_ID,
    CAST(VOID_TOT_VAL_AFT_SUBTOT AS NUMERIC) AS VOID_TOT_VAL_AFT_SUBTOT,
    CAST(SUSP_TOT_VAL AS NUMERIC)  AS SUSP_TOT_VAL,
    CAST(SUSP_SUBSEQUENT_TRANS_LOW_VAL AS NUMERIC) AS SUSP_SUBSEQUENT_TRANS_LOW_VAL,
    CAST(SUSP_VOIDED_EXP_LAST_VOID_VAL AS NUMERIC) AS SUSP_VOIDED_EXP_LAST_VOID_VAL,
    CAST(RETURN_ITEM_PRICE AS NUMERIC) AS RETURN_ITEM_PRICE,
    CAST(RETURN_TOT_VAL AS NUMERIC) AS RETURN_TOT_VAL,
    CAST(RETURN_VALUE AS NUMERIC) AS RETURN_VALUE,
    CAST(RETURN_TOT_VAL_NF AS NUMERIC) AS RETURN_TOT_VAL_NF,
    CAST(DEPOSIT_SCANNED_VALUE AS NUMERIC) AS DEPOSIT_SCANNED_VALUE,
    CAST(DEPOSIT_SCANNED_QTY_INTEGER AS NUMERIC) AS DEPOSIT_SCANNED_QTY_INTEGER,
    CAST(DEPOSIT_1ITM_PLUS_EMPTY_RET AS NUMERIC) AS DEPOSIT_1ITM_PLUS_EMPTY_RET,
    CAST(DEPOSIT_AMT_PLUS_EMPTY_RET AS NUMERIC) AS DEPOSIT_AMT_PLUS_EMPTY_RET,
    CAST(PRICE_SUBSEQ_TRANS_LOW_VAL AS NUMERIC) AS PRICE_SUBSEQ_TRANS_LOW_VAL,
    CAST(SUSP_VOIDED_EXP_LAST_VOID_VAL2 AS NUMERIC) AS SUSP_VOIDED_EXP_LAST_VOID_VAL2,
    CAST(DEPOSIT_1ITM_RECEIPT_VAL AS NUMERIC) AS DEPOSIT_1ITM_RECEIPT_VAL,
    CAST(DEPOSIT_1ITM_ITEM_VAL AS NUMERIC) AS DEPOSIT_1ITM_ITEM_VAL,
    CAST(DEPOSIT_NOITM_TOT_VAL AS NUMERIC) AS DEPOSIT_NOITM_TOT_VAL,
    CAST(PRICE_SERIES_RECEIPT_CNT AS NUMERIC) AS PRICE_SERIES_RECEIPT_CNT,
    CAST(PRICE_SERIES_RECEIPT_TOTAL_VAL AS NUMERIC) AS PRICE_SERIES_RECEIPT_TOTAL_VAL,
    CAST(RETURN_SAME_RECEIPT_QTY AS NUMERIC) AS RETURN_SAME_RECEIPT_QTY,
    CAST(RETURN_SAME_RECEIPT_VAL AS NUMERIC) AS RETURN_SAME_RECEIPT_VAL,
    CAST(RETURN_NOT_AUTHORISED_VAL AS NUMERIC) AS RETURN_NOT_AUTHORISED_VAL,
    CAST(RETURN_NOT_AUTHORISED_VAL2 AS NUMERIC) AS RETURN_NOT_AUTHORISED_VAL2,
    CAST(PRICE_SUBSEQ_TRANS_LOW_VAL2 AS NUMERIC) AS PRICE_SUBSEQ_TRANS_LOW_VAL2,
    CAST(SUSP_SUBSEQENT_TRANS_LOW_VAL_MC AS NUMERIC) AS SUSP_SUBSEQENT_TRANS_LOW_VAL_MC,
    CAST(RETURN_SAME_CHECKER_VAL AS NUMERIC) AS RETURN_SAME_CHECKER_VAL,
    CAST(RETURN_SAME_CHECKER_VAL_EBB_M AS NUMERIC) AS RETURN_SAME_CHECKER_VAL_EBB_M,
    CAST(RETURN_SAME_CHECKER_VAL_EBB_L AS NUMERIC) AS RETURN_SAME_CHECKER_VAL_EBB_L,
    CAST(void_1itm_receipt_val AS NUMERIC) AS void_1itm_receipt_val,
    CAST(return_no_receipt_val AS NUMERIC) AS return_no_receipt_val,
    CAST(return_many_itm_cnt AS NUMERIC) AS return_many_itm_cnt,
    CAST(return_many_itm_val AS NUMERIC) AS return_many_itm_val,
    CAST(void_itm_cnt AS NUMERIC) AS void_itm_cnt,
    CAST(void_tot_val_cnt AS NUMERIC) AS void_tot_val_cnt,
    CAST(void_tot_itm_in_receipt AS NUMERIC) AS void_tot_itm_in_receipt,
    CAST(void_receipt_cnt AS NUMERIC) AS void_receipt_cnt,
    CAST(void_1itm_receipt_val_2 AS NUMERIC) AS void_1itm_receipt_val_2,
    CAST(plus_rec_month AS NUMERIC) AS plus_rec_month,
    CAST(plus_rec_day AS NUMERIC) AS plus_rec_day,
    CAST(SUSP_ABORTED_TOT_QTY AS NUMERIC) AS SUSP_ABORTED_TOT_QTY,
    CAST(SUSP_ABORTED_TOT_VAL AS NUMERIC) AS SUSP_ABORTED_TOT_VAL,
    CAST(SUSP_ABORTED_SUBSEQUENT_TRANS_LOW_VAL AS NUMERIC) AS SUSP_ABORTED_SUBSEQUENT_TRANS_LOW_VAL,
    REQUESTING_USER AS REQUESTING_USER;

END;