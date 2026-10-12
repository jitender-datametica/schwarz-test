

 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename
 , retail_event_line_scenario_id, bus_dt, cash_register_type_cd, retail_event_line_seq, cash_register_usg_type_cd,
 cust_sid, country_org_sid, cash_register_sid, store_sid, retail_event_sid, real_estate_sid, country_org_cd,
 cashier_hash, foreign_paym_val, paym_end_tmsp, paym_card_type_cd, round_diff, card_txn_type_cd, local_curr_cd,
 -- ****************
 foreign_curr_cd, paym_line_type_cd, card_txn_nr, card_auth_method_cd, paym_type_id, local_paym_val, paym_start_tmsp)
(SELECT 'EJR' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  -- ****************
 'EJR' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  'V_${SRC_INPUT_TABLE}' AS filename,
  receiptline_transactiontype_id AS retail_event_line_scenario_id,
  receipt_business_date AS bus_dt,
  pos_type AS cash_register_type_cd,
  posnr AS retail_event_line_seq,
  CAST(NULL AS STRING) AS cash_register_usg_type_cd,
  cust_sid,
  country_org_sid,
  cash_register_sid,
  store_sid,
  retail_event_sid,
  real_estate_sid,
  country_org_cd,
  checker_hash AS cashier_hash,
  val_retail_orig AS foreign_paym_val,
  CAST(receiptline_timestamp_end AS TIMESTAMP) AS paym_end_tmsp,
  CAST(NULL AS STRING) AS paym_card_type_cd,
  val_discount_base AS round_diff,
  CAST(NULL AS STRING) AS card_txn_type_cd,
  curr_cd AS local_curr_cd,
   CASE
   WHEN val_retail_orig IS NOT NULL
   THEN currency_iso_cd
   ELSE NULL
   END AS foreign_curr_cd,
   CASE
   WHEN posart = '4'
   THEN 'P'
   ELSE 'R'
   END AS paym_line_type_cd,
  CAST(NULL AS STRING) AS card_txn_nr,
  CAST(NULL AS STRING) AS card_auth_method_cd,
  tendertype_cd AS paym_type_id,
  price_sum_retail AS local_paym_val,
  CAST(COALESCE(receiptline_timestamp_begin, receiptline_timestamp_end) AS TIMESTAMP) AS
  paym_start_tmsp
 FROM ${temp_db}.v_${src_input_table} AS src
 WHERE receiptline_transactiontype_id IN ('110', '210')
  AND CAST(receipt_transactiontype_id AS INTEGER) BETWEEN 100 AND 399
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY context_country, CAST(orig_store_nr AS STRING), CAST(pos_terminal_id AS STRING)
       , CAST(orig_receipt_nr AS STRING), receipt_business_date, CAST(posnr AS STRING), receiptline_timestamp_begin
     ORDER BY receipt_timestamp_end IS NULL DESC, receipt_timestamp_end DESC)) = 1);