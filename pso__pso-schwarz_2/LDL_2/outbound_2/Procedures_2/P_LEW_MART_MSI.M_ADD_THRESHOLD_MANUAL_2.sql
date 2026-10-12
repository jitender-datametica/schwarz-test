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

CREATE OR REPLACE PROCEDURE `p_lew_mart_msi.m_add_threshold_manual`(
  CLIENT_ID FLOAT64,
  MVOID_QUOTE_CNT_CHECKER FLOAT64,
  MVOID_PER100_TRANS_CNT_CHECKER FLOAT64,
  MVOID_VAL_CNT_CHECKER FLOAT64,
  MABO_QTY_TRANS_CNT_CHECKER FLOAT64,
  MABO_VAL_CNT_CHECKER FLOAT64,
  MSUSP_QTY_TRANS_CNT_CHECKER FLOAT64,
  MRETURN_QUOTE_CNT_CHECKER FLOAT64,
  MRETURN_VAL_CNT_CHECKER FLOAT64,
  MRET_AMOUNT_TRANS_CNT_CHECKER FLOAT64,
  MDEPOSIT_QUOTE_CNT_CHECKER FLOAT64,
  MDEPOSIT_MAN_VAL_CNT_CHECKER FLOAT64,
  MDEPOSIT_ALL_VAL_CNT_CHECKER FLOAT64,
  MOTHERS_QTY_LOWVAL_CNT_CHECKER FLOAT64,
  MOTHERS_QTY_LOGIN_CNT_CHECKER FLOAT64,
  MSUSP_ABORTED_RECEIPT_VAL FLOAT64,
  MOTHERS_LOW_RECEIPT_VAL FLOAT64,
  MVOID_SAME_ITEM_CNT FLOAT64,
  MVOID_ITEM_VAL FLOAT64,
  MRECEIPT_VOID_VAL FLOAT64,
  MRETURN_MANUAL_CNT_CHECKER FLOAT64,
  MSHOW_PRICE_VAL_CNT_CHECKER FLOAT64,
  MSHOW_PRICE_LOW_NXT_RECEIPT_VAL FLOAT64,
  MSHOW_PRICE_VAL_NF_LOW FLOAT64,
  MSHOW_PRICE_CNT_VG_INFOLGE_LOW FLOAT64,
  MDISCOUNT_CNT_CHECKER FLOAT64,
  MDISCOUNT_QUOTE_CHECKER FLOAT64,
  MDISCOUNT_CNT_RECEIPT FLOAT64,
  MDISCOUNT_VAL_RECEIPT FLOAT64,
  MRETURN_NO_ORIG_RECEIPT_CNT_CHECKER FLOAT64,
  REQUESTING_USER STRING
)
BEGIN
  /* Delete rows with selected CLIENT_ID that already exists.  */
  EXECUTE IMMEDIATE """
    DELETE FROM `p_lew_mart_msi.t_msi_ejr_lp_threshold_manual_2`
    WHERE client_id = @client_id
      AND approval_fg = -1
  """ USING CLIENT_ID AS client_id;

  /* Inserts new row if client_id exists and at least one row changed  */
  EXECUTE IMMEDIATE """
    INSERT INTO `p_lew_mart_msi.t_msi_ejr_lp_threshold_manual_2` (
      client_id, dat_rec_start, dat_rec_end, mvoid_quote_cnt_checker, mvoid_per100_trans_cnt_checker,
      mvoid_val_cnt_checker, mabo_qty_trans_cnt_checker, mabo_val_cnt_checker, msusp_qty_trans_cnt_checker,
      mreturn_quote_cnt_checker, mreturn_val_cnt_checker, mret_amount_trans_cnt_checker, mdeposit_quote_cnt_checker,
      mdeposit_man_val_cnt_checker, mdeposit_all_val_cnt_checker, mothers_qty_lowval_cnt_checker,
      mothers_qty_login_cnt_checker, msusp_aborted_receipt_val, mothers_low_receipt_val, mvoid_same_item_cnt,
      mvoid_item_val, mreceipt_void_val, mreturn_manual_cnt_checker, mshow_price_val_cnt_checker,
      mshow_price_low_nxt_receipt_val, mshow_price_val_nf_low, mshow_price_cnt_vg_infolge_low,
      mdiscount_cnt_checker, mdiscount_quote_checker, mdiscount_cnt_receipt, mdiscount_val_receipt,
      mreturn_no_orig_receipt_cnt_checker, requesting_user, timestamp_request, approval_fg
    )
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin") AS dat_rec_start,
      DATE '9999-12-31' AS dat_rec_end,
      @mvoid_quote_cnt_checker,
      @mvoid_per100_trans_cnt_checker,
      @mvoid_val_cnt_checker,
      @mabo_qty_trans_cnt_checker,
      @mabo_val_cnt_checker,
      @msusp_qty_trans_cnt_checker,
      @mreturn_quote_cnt_checker,
      @mreturn_val_cnt_checker,
      @mret_amount_trans_cnt_checker,
      @mdeposit_quote_cnt_checker,
      @mdeposit_man_val_cnt_checker,
      @mdeposit_all_val_cnt_checker,
      @mothers_qty_lowval_cnt_checker,
      @mothers_qty_login_cnt_checker,
      @msusp_aborted_receipt_val,
      @mothers_low_receipt_val,
      @mvoid_same_item_cnt,
      @mvoid_item_val,
      @mreceipt_void_val,
      @mreturn_manual_cnt_checker,
      @mshow_price_val_cnt_checker,
      @mshow_price_low_nxt_receipt_val,
      @mshow_price_val_nf_low,
      @mshow_price_cnt_vg_infolge_low,
      @mdiscount_cnt_checker,
      @mdiscount_quote_checker,
      @mdiscount_cnt_receipt,
      @mdiscount_val_receipt,
      @mreturn_no_orig_receipt_cnt_checker,
      @requesting_user AS requesting_user,
      CAST(CURRENT_TIMESTAMP() AS DATETIME) AS timestamp_request,
      -1 AS approval_fg
    FROM `p_lew_core_ac.v_wawi_ref_client_country_2` AS cnt
    LEFT OUTER JOIN `p_lew_mart_msi.t_msi_ejr_lp_threshold_manual_2` AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
    WHERE cnt.client_id = @client_id
      AND (
            COALESCE(orig.mvoid_quote_cnt_checker            , -99999999999999) <> COALESCE(@mvoid_quote_cnt_checker, -99999999999999)
         OR COALESCE(orig.mvoid_per100_trans_cnt_checker     , -99999999999999) <> COALESCE(@mvoid_per100_trans_cnt_checker, -99999999999999)
         OR COALESCE(orig.mvoid_val_cnt_checker              , -99999999999999) <> COALESCE(@mvoid_val_cnt_checker, -99999999999999)
         OR COALESCE(orig.mabo_qty_trans_cnt_checker         , -99999999999999) <> COALESCE(@mabo_qty_trans_cnt_checker, -99999999999999)
         OR COALESCE(orig.mabo_val_cnt_checker               , -99999999999999) <> COALESCE(@mabo_val_cnt_checker, -99999999999999)
         OR COALESCE(orig.msusp_qty_trans_cnt_checker        , -99999999999999) <> COALESCE(@msusp_qty_trans_cnt_checker, -99999999999999)
         OR COALESCE(orig.mreturn_quote_cnt_checker          , -99999999999999) <> COALESCE(@mreturn_quote_cnt_checker, -99999999999999)
         OR COALESCE(orig.mreturn_val_cnt_checker            , -99999999999999) <> COALESCE(@mreturn_val_cnt_checker, -99999999999999)
         OR COALESCE(orig.mret_amount_trans_cnt_checker      , -99999999999999) <> COALESCE(@mret_amount_trans_cnt_checker, -99999999999999)
         OR COALESCE(orig.mdeposit_quote_cnt_checker         , -99999999999999) <> COALESCE(@mdeposit_quote_cnt_checker, -99999999999999)
         OR COALESCE(orig.mdeposit_man_val_cnt_checker       , -99999999999999) <> COALESCE(@mdeposit_man_val_cnt_checker, -99999999999999)
         OR COALESCE(orig.mdeposit_all_val_cnt_checker       , -99999999999999) <> COALESCE(@mdeposit_all_val_cnt_checker, -99999999999999)
         OR COALESCE(orig.mothers_qty_lowval_cnt_checker     , -99999999999999) <> COALESCE(@mothers_qty_lowval_cnt_checker, -99999999999999)
         OR COALESCE(orig.mothers_qty_login_cnt_checker      , -99999999999999) <> COALESCE(@mothers_qty_login_cnt_checker, -99999999999999)
         OR COALESCE(orig.msusp_aborted_receipt_val          , -99999999999999) <> COALESCE(@msusp_aborted_receipt_val, -99999999999999)
         OR COALESCE(orig.mothers_low_receipt_val            , -99999999999999) <> COALESCE(@mothers_low_receipt_val, -99999999999999)
         OR COALESCE(orig.mvoid_same_item_cnt                , -99999999999999) <> COALESCE(@mvoid_same_item_cnt, -99999999999999)
         OR COALESCE(orig.mvoid_item_val                     , -99999999999999) <> COALESCE(@mvoid_item_val, -99999999999999)
         OR COALESCE(orig.mreceipt_void_val                  , -99999999999999) <> COALESCE(@mreceipt_void_val, -99999999999999)
         OR COALESCE(orig.mreturn_manual_cnt_checker         , -99999999999999) <> COALESCE(@mreturn_manual_cnt_checker, -99999999999999)
         OR COALESCE(orig.mshow_price_val_cnt_checker        , -99999999999999) <> COALESCE(@mshow_price_val_cnt_checker, -99999999999999)
         OR COALESCE(orig.mshow_price_low_nxt_receipt_val    , -99999999999999) <> COALESCE(@mshow_price_low_nxt_receipt_val, -99999999999999)
         OR COALESCE(orig.mshow_price_val_nf_low             , -99999999999999) <> COALESCE(@mshow_price_val_nf_low, -99999999999999)
         OR COALESCE(orig.mshow_price_cnt_vg_infolge_low     , -99999999999999) <> COALESCE(@mshow_price_cnt_vg_infolge_low, -99999999999999)
         OR COALESCE(orig.mdiscount_cnt_checker              , -99999999999999) <> COALESCE(@mdiscount_cnt_checker, -99999999999999)
         OR COALESCE(orig.mdiscount_quote_checker            , -99999999999999) <> COALESCE(@mdiscount_quote_checker, -99999999999999)
         OR COALESCE(orig.mdiscount_cnt_receipt              , -99999999999999) <> COALESCE(@mdiscount_cnt_receipt, -99999999999999)
         OR COALESCE(orig.mdiscount_val_receipt              , -99999999999999) <> COALESCE(@mdiscount_val_receipt, -99999999999999)
         OR COALESCE(orig.mreturn_no_orig_receipt_cnt_checker, -99999999999999) <> COALESCE(@mreturn_no_orig_receipt_cnt_checker, -99999999999999)
         OR orig.client_id IS NULL
      )
  """ USING
    CLIENT_ID AS client_id,
    CAST(MVOID_QUOTE_CNT_CHECKER AS NUMERIC) AS mvoid_quote_cnt_checker,
    CAST(MVOID_PER100_TRANS_CNT_CHECKER AS NUMERIC) AS mvoid_per100_trans_cnt_checker,
    CAST(MVOID_VAL_CNT_CHECKER AS NUMERIC) AS mvoid_val_cnt_checker,
    CAST(MABO_QTY_TRANS_CNT_CHECKER AS NUMERIC) AS mabo_qty_trans_cnt_checker,
    CAST(MABO_VAL_CNT_CHECKER AS NUMERIC) AS mabo_val_cnt_checker,
    CAST(MSUSP_QTY_TRANS_CNT_CHECKER AS NUMERIC) AS msusp_qty_trans_cnt_checker,
    CAST(MRETURN_QUOTE_CNT_CHECKER AS NUMERIC) AS mreturn_quote_cnt_checker,
    CAST(MRETURN_VAL_CNT_CHECKER AS NUMERIC) AS mreturn_val_cnt_checker,
    CAST(MRET_AMOUNT_TRANS_CNT_CHECKER AS NUMERIC) AS mret_amount_trans_cnt_checker,
    CAST(MDEPOSIT_QUOTE_CNT_CHECKER AS NUMERIC) AS mdeposit_quote_cnt_checker,
    CAST(MDEPOSIT_MAN_VAL_CNT_CHECKER AS NUMERIC) AS mdeposit_man_val_cnt_checker,
    CAST(MDEPOSIT_ALL_VAL_CNT_CHECKER AS NUMERIC) AS mdeposit_all_val_cnt_checker,
    CAST(MOTHERS_QTY_LOWVAL_CNT_CHECKER AS NUMERIC) AS mothers_qty_lowval_cnt_checker,
    CAST(MOTHERS_QTY_LOGIN_CNT_CHECKER AS NUMERIC) AS mothers_qty_login_cnt_checker,
    CAST(MSUSP_ABORTED_RECEIPT_VAL AS NUMERIC) AS msusp_aborted_receipt_val,
    CAST(MOTHERS_LOW_RECEIPT_VAL AS NUMERIC) AS mothers_low_receipt_val,
    CAST(MVOID_SAME_ITEM_CNT AS NUMERIC) AS mvoid_same_item_cnt,
    CAST(MVOID_ITEM_VAL AS NUMERIC) AS mvoid_item_val,
    CAST(MRECEIPT_VOID_VAL AS NUMERIC) AS mreceipt_void_val,
    CAST(MRETURN_MANUAL_CNT_CHECKER AS NUMERIC) AS mreturn_manual_cnt_checker,
    CAST(MSHOW_PRICE_VAL_CNT_CHECKER AS NUMERIC) AS mshow_price_val_cnt_checker,
    CAST(MSHOW_PRICE_LOW_NXT_RECEIPT_VAL AS NUMERIC) AS mshow_price_low_nxt_receipt_val,
    CAST(MSHOW_PRICE_VAL_NF_LOW AS NUMERIC) AS mshow_price_val_nf_low,
    CAST(MSHOW_PRICE_CNT_VG_INFOLGE_LOW AS NUMERIC) AS mshow_price_cnt_vg_infolge_low,
    CAST(MDISCOUNT_CNT_CHECKER AS NUMERIC) AS mdiscount_cnt_checker,
    CAST(MDISCOUNT_QUOTE_CHECKER AS NUMERIC) AS mdiscount_quote_checker,
    CAST(MDISCOUNT_CNT_RECEIPT AS NUMERIC) AS mdiscount_cnt_receipt,
    CAST(MDISCOUNT_VAL_RECEIPT AS NUMERIC) AS mdiscount_val_receipt,
    CAST(MRETURN_NO_ORIG_RECEIPT_CNT_CHECKER AS NUMERIC) AS mreturn_no_orig_receipt_cnt_checker,
    REQUESTING_USER AS requesting_user;
END;