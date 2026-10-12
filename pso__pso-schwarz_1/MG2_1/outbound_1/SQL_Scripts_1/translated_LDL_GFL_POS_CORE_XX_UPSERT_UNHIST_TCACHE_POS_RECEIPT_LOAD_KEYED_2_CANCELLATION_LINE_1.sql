
--****************


--****************


--QUALIFY new (temporal), keep just first cancel line with matching number  - Changed following solace switch


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, real_estate_sid, cash_register_sid,
 retail_event_line_scenario_id, bus_dt, cash_register_type_cd, retail_event_line_seq, cash_register_usg_type_cd,
 cust_sid, country_org_sid, store_sid, retail_event_sid, country_org_cd, cashier_hash, auth_by_hash, input_cancel_nr,
 event_tmsp)
(SELECT 'EJR' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'EJR' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  '${V_SRC_INPUT_TABLE}' AS filename,
  real_estate_sid,
  cash_register_sid,
  receiptline_transactiontype_id AS retail_event_line_scenario_id,
  receipt_business_date AS bus_dt,
  pos_type AS cash_register_type_cd,
  posnr AS retail_event_line_seq,
  CAST(NULL AS STRING) AS cash_register_usg_type_cd,
  cust_sid,
  country_org_sid,
  store_sid,
  retail_event_sid,
  country_org_cd,
  checker_hash AS cashier_hash,
  receiptline_authority_hash AS auth_by_hash,
  barcode AS input_cancel_nr,
  CAST(receiptline_timestamp_begin AS TIMESTAMP) AS event_tmsp
 FROM ${temp_db}.${v_src_input_table} AS src
 WHERE receiptline_transactiontype_id IN ('171', '173', '181', '183', '271', '273', '281', '283', '471', '473', '481',
    '483', '571', '573', '581', '583', '671', '673', '681', '683', '771', '773', '781', '783')
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY context_country, CAST(orig_store_nr AS STRING), CAST(pos_terminal_id AS STRING)
       , CAST(orig_receipt_nr AS STRING), receipt_business_date, CAST(posnr AS STRING) ORDER BY
       receiptline_timestamp_begin IS NULL, receiptline_timestamp_begin, receipt_timestamp_end IS NULL DESC,
       receipt_timestamp_end DESC)) = 1);