/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.T_MSI_EJR_LP_THRESHOLD_MANUAL_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  17.01.2018    Wieber.Harald            Release 2.2
#  1.3  30.01.2018    Wieber.Harald            Anpassung Index/Not Null/ PPI - Michael Üding
#  1.4  31.01.2018    Wieber.Harald            Release 2.3
#  1.5  31.01.2018    Wieber,Harald            Release 2.3
#  1.6  20.11.2019    Morris, Michael          20191114_2289_ZKP_SG_59_60 (LEAD-8205): Neue Felder mshow_price_val_cnt_checker & mshow_price_low_nxt_receipt_val.
#  1.7  23.10.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: New columns for discount (Rabatt) metrics
#  1.8  29.12.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: Complete column comments
#  1.9  22.01.2021    Wandtke, Andrzej         AP0056021 Migrate to SF
#  2.0  13.05.2021    Wandtke, Andrzej         AP0056038 20210216_2750_ZKP_RET_NO_RECEIPT: New column mreturn_no_orig_receipt_cnt_checker for metrics Money return with no original receipt
#  2.1  07.07.2023    Kowalik, Aleksander      AP0122629 Anpassung Kennzahlen Preisanzeige: New columns added for new threshold metrics: MSHOW_PRICE_VAL_NF_LOW and MSHOW_PRICE_CNT_VG_INFOLGE_LOW
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_lp_threshold_manual_2 (
client_id BIGNUMERIC(38,0),
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
mvoid_quote_cnt_checker NUMERIC(18,4),
mvoid_per100_trans_cnt_checker NUMERIC(18,4),
mvoid_val_cnt_checker NUMERIC(18,4),
mabo_qty_trans_cnt_checker NUMERIC(18,4),
mabo_val_cnt_checker NUMERIC(18,4),
msusp_qty_trans_cnt_checker NUMERIC(18,4),
mreturn_quote_cnt_checker NUMERIC(18,4),
mreturn_val_cnt_checker NUMERIC(18,4),
mret_amount_trans_cnt_checker NUMERIC(18,4),
mdeposit_quote_cnt_checker NUMERIC(18,4),
mdeposit_man_val_cnt_checker NUMERIC(18,4),
mdeposit_all_val_cnt_checker NUMERIC(18,4),
mothers_qty_lowval_cnt_checker NUMERIC(18,4),
mothers_qty_login_cnt_checker NUMERIC(18,4),
msusp_aborted_receipt_val NUMERIC(18,4),
mothers_low_receipt_val NUMERIC(18,4),
mvoid_same_item_cnt NUMERIC(18,4),
mvoid_item_val NUMERIC(18,4),
mreceipt_void_val NUMERIC(18,4),
mreturn_manual_cnt_checker NUMERIC(18,4),
mshow_price_val_cnt_checker NUMERIC(18,4),
mshow_price_low_nxt_receipt_val NUMERIC(18,4),
mdiscount_cnt_checker NUMERIC(18,4),
mdiscount_quote_checker NUMERIC(18,4),
mdiscount_cnt_receipt NUMERIC(18,4),
mdiscount_val_receipt NUMERIC(18,4),
mreturn_no_orig_receipt_cnt_checker NUMERIC(18,4),
requesting_user STRING(128) COLLATE 'und:ci' DEFAULT SESSION_USER() NOT NULL,
timestamp_request DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL,
approval_fg BIGNUMERIC(38,0) NOT NULL,
approval_user STRING(128) COLLATE 'und:ci',
timestamp_approval DATETIME,
approval2_user STRING(128) COLLATE 'und:ci',
timestamp_approval2 DATETIME,
mshow_price_val_nf_low NUMERIC(18,4),
mshow_price_cnt_vg_infolge_low NUMERIC(18,4)
);