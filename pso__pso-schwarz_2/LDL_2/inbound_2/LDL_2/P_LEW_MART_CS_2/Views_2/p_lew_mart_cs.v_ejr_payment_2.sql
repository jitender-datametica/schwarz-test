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
CREATE OR REPLACE VIEW p_lew_mart_cs.v_ejr_payment_2 (
  store_id
 ,client_id
 ,pos_terminal_id
 ,dat_formdate
 ,time_receipt_ejr
 ,orig_receipt_nr_ejr
 ,orig_receipt_serial_nr_ejr
 ,timezone_cd
 ,dat_dayend
 ,checker_id
 ,transactiontype_id
 ,tendertype_id
 ,cnt_payment_ejr
 ,val_retail_payment_ejr
 ,tendertype_cd_ejr
 ,val_foreign_curr_ejr
 ,val_diff_rounding_ejr
 ,currency_iso_cd
 ,timestamp_begin_ejr
 ,timestamp_end_ejr
 ,load_id
) AS
SELECT
  a.loc_sid                 AS store_id
 ,a.client_id
 ,a.register_id             AS pos_terminal_id
 ,a.receipt_dt              AS dat_formdate
 ,a.receipt_tmsp            AS time_receipt_ejr
 ,a.receipt_id              AS orig_receipt_nr_ejr
 ,a.receiptline_nr          AS orig_receipt_serial_nr_ejr
 ,a.timezone_id             AS timezone_cd
 ,a.dwh_cal_dt              AS dat_dayend
 ,a.cashier_id              AS checker_id
 ,a.transaction_type_cd     AS transactiontype_id
 ,a.payment_method_id       AS tendertype_id
 ,a.payment_fg              AS cnt_payment_ejr
 ,a.payment_val             AS val_retail_payment_ejr
 ,a.tendertype_ejr_cd       AS tendertype_cd_ejr
 ,a.payment_alt_val         AS val_foreign_curr_ejr
 ,a.diff_rounding_val       AS val_diff_rounding_ejr
 ,y.curr_iso_cd             AS currency_iso_cd
 ,a.transaction_begin_tmsp  AS timestamp_begin_ejr
 ,a.transaction_end_tmsp    AS timestamp_end_ejr
 ,0 AS load_id
FROM p_lew_core_ac.v_pos_ctrl_payment_2 a
LEFT OUTER JOIN p_lew_core_ac.v_currency_2 y
ON a.client_id = y.client_id
  AND a.curr_sid = y.curr_sid
;