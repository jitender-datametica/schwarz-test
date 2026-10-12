/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_ejr_payment_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_ejr_payment_2 (store_id, client_id, pos_terminal_id, dat_formdate,
time_receipt_ejr, orig_receipt_nr_ejr, orig_receipt_serial_nr_ejr, timezone_cd, dat_dayend, checker_id,
transactiontype_id, tendertype_id, cnt_payment_ejr, val_retail_payment_ejr, tendertype_cd_ejr, val_foreign_curr_ejr,
val_diff_rounding_ejr, currency_iso_cd, timestamp_begin_ejr, timestamp_end_ejr, load_id) AS SELECT A.loc_sid AS store_id
 ,
 A.client_id,
 A.register_id AS pos_terminal_id,
 A.receipt_dt AS dat_formdate,
 A.receipt_tmsp AS time_receipt_ejr,
 A.receipt_id AS orig_receipt_nr_ejr,
 A.receiptline_nr AS orig_receipt_serial_nr_ejr,
 A.timezone_id AS timezone_cd,
 A.dwh_cal_dt AS dat_dayend,
 A.cashier_id AS checker_id,
 A.transaction_type_cd AS transactiontype_id,
 A.payment_method_id AS tendertype_id,
 A.payment_fg AS cnt_payment_ejr,
 A.payment_val AS val_retail_payment_ejr,
 A.tendertype_ejr_cd AS tendertype_cd_ejr,
 A.payment_alt_val AS val_foreign_curr_ejr,
 A.diff_rounding_val AS val_diff_rounding_ejr,
 Y.curr_iso_cd AS currency_iso_cd,
 A.transaction_begin_tmsp AS timestamp_begin_ejr,
 A.transaction_end_tmsp AS timestamp_end_ejr,
 0 AS load_id
FROM ldl_p_lew_core_ac.v_pos_ctrl_payment_2 AS A
 LEFT JOIN ldl_p_lew_core_ac.v_currency_2 AS Y ON A.client_id = Y.client_id AND A.curr_sid = Y.curr_sid;