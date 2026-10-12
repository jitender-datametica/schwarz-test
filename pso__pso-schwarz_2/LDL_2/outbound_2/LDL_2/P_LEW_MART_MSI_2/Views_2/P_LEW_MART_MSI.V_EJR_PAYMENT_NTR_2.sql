CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_payment_ntr_2 AS SELECT loc_sid AS store_id,
 client_id,
 register_id AS pos_terminal_id,
 dwh_cal_dt AS dat_formdate,
 CAST(TRIM(SUBSTR(CAST(CAST(receipt_tmsp AS TIME) AS STRING), 1, 8)) AS TIME) AS time_receipt_ejr,
 receipt_id AS orig_receipt_nr_ejr,
 receiptline_nr AS orig_receipt_serial_nr_ejr,
 timezone_id AS timezone_cd,
 receipt_dt AS dat_dayend,
 cashier_id AS checker_id,
 transaction_type_cd AS transactiontype_id,
 payment_fg AS cnt_payment_ejr,
 payment_val AS val_retail_payment_ejr,
 tendertype_ejr_cd AS tendertype_cd_ejr
FROM ldl_p_lew_core_ac.v_pos_ctrl_payment_2
WHERE turnover_relevant_fg = 0;