CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_cntr_transact_2 AS SELECT loc_sid AS store_id,
 client_id,
 register_id AS pos_terminal_id,
 dwh_cal_dt AS dat_formdate,
 CAST(TRIM(SUBSTR(CAST(CAST(receipt_tmsp AS TIME) AS STRING), 1, 8)) AS TIME) AS time_receipt_ejr,
 receipt_id AS orig_receipt_nr_ejr,
 timezone_id AS timezone_cd,
 dwh_cal_dt AS dat_dayend,
 cashier_id AS checker_id,
 transaction_type_cd AS transactiontype_id,
 CAST(SUBSTR(CAST(transaction_begin_tmsp AS STRING), 1, 19) AS DATETIME) AS timestamp_begin_ejr,
 CAST(SUBSTR(CAST(transaction_end_tmsp AS STRING), 1, 19) AS DATETIME) AS timestamp_end_ejr,
 transaction_type_detail_id AS trans_detail_type_id
FROM ldl_p_lew_core_ac.v_pos_ctrl_register_transaction_2;