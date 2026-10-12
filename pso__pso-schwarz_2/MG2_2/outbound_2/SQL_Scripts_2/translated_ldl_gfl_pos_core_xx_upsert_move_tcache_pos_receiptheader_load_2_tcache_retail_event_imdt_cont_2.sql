CREATE OR REPLACE TEMPORARY TABLE
vt_$_2{src2tgt_temp_table1}_${src_context_area}_process AS
SELECT *
FROM ldl_data_production_etl.t_${src_input_table} AS src
WHERE LOWER(context_country) IN (${src_country_list})
 AND receipt_transactiontype_id BETWEEN '100' AND '399'
QUALIFY (ROW_NUMBER() OVER (PARTITION BY context_country, CAST(orig_store_nr AS STRING), CAST(pos_terminal_id AS STRING)
      , CAST(orig_receipt_nr AS STRING), receipt_business_date ORDER BY receipt_timestamp_end IS NULL DESC,
      receipt_timestamp_end DESC)) = 1;


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename
 , country_org_key_type_cd, receipt_business_date, store_key_type_cd, orig_store_nr, event_start_tmsp, context_country,
 event_end_tmsp, bus_dt, cashier_nr, auth_by_nr, cash_register_key_type_cd, real_estate_key_type_cd,
 lidlplus_customer_cd, cash_register_natural_key, orig_receipt_nr, turnover_relevant_fg, cust_key_type_cd,
 pos_terminal_id, cash_register_type_cd, retail_event_key_type_cd, cash_register_usg_type_cd, cash_register_event_nr,
 training_fg, suspend_fg, cancel_fg, offline_fg, txn_vat_val, resumed_trans_date, cust_ident_type_cd, paym_tm_sec_meas,
 cont_retail_event_key_type_cd, txn_net_val, keyed_lines_cnt, txn_gross_val, resumed_trans_receipt_nr, scanned_lines_cnt
 , retail_event_type_cd, resumed_trans_store_nr, service_tm_sec_meas, retail_event_scenario_id,
 resumed_trans_terminal_id)
(SELECT 'EJR' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'EJR' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  'COUNTRY_2' AS country_org_key_type_cd,
  receipt_business_date,
  'STORE' AS store_key_type_cd,
  orig_store_nr,
  CAST(receipt_timestamp_begin AS TIMESTAMP) AS event_start_tmsp,
  context_country,
  CAST(receipt_timestamp_end AS TIMESTAMP) AS event_end_tmsp,
  dwh_mapping_dt AS bus_dt,
  CAST(- 1 AS STRING) AS cashier_nr,
  CAST(- 1 AS STRING) AS auth_by_nr,
  'DUMMY_2' AS cash_register_key_type_cd,
  'RE_2' AS real_estate_key_type_cd,
  lidlplus_customer_cd,
  'DUMMY_2|DUMMY_2' AS cash_register_natural_key,
  orig_receipt_nr,
  (receipt_transactiontype_id IN ('100', '150')) IS TRUE AS turnover_relevant_fg,
  'CUST' AS cust_key_type_cd,
  pos_terminal_id,
  CAST(NULL AS STRING) AS cash_register_type_cd,
  'RET' AS retail_event_key_type_cd,
  CAST(NULL AS STRING) AS cash_register_usg_type_cd,
  orig_receipt_nr AS cash_register_event_nr,
  training_fg IS TRUE AS training_fg,
   SUBSTR(receipt_transactiontype_id, 1, 1) = '3' AS suspend_fg, /* 300, 301, 350, 351 */ 
   SUBSTR(receipt_transactiontype_id, 1, 1) = '2' AS cancel_fg, /* 200, 201, 250, 251 */ 
  offline_fg IS TRUE AS offline_fg,
   val_retail - val_retail_net AS txn_vat_val,
  resumed_trans_date,
  lidlplus_ident_type_cd AS cust_ident_type_cd,
  dur_pay_change_time AS paym_tm_sec_meas,
  'RET' AS cont_retail_event_key_type_cd,
  val_retail_net AS txn_net_val,
  NULL AS keyed_lines_cnt,
  val_retail AS txn_gross_val,
  resumed_trans_receipt_nr,
  NULL AS scanned_lines_cnt,
   CASE
   WHEN SUBSTR(receipt_transactiontype_id, 2, 1) = '5'
   THEN 'R' /* RETURN ... 150, 151, 250, 251, 350, 351 */
   ELSE 'S' /* SALES_2 ... 100, 101, 200, 201, 300, 301 */
   END AS retail_event_type_cd,
  resumed_trans_store_nr,
  dur_service_time AS service_tm_sec_meas,
  ROUND(CAST(receipt_transactiontype_id AS BIGNUMERIC), 0) AS retail_event_scenario_id,
  resumed_trans_terminal_id
 FROM vt_$_2{src2tgt_temp_table1}_${src_context_area}_process AS src);


-- Delete those records from source using the PK


DELETE FROM ldl_data_production_etl.t_${src_input_table} AS src
WHERE EXISTS (SELECT 1
 FROM vt_$_2{src2tgt_temp_table1}_${src_context_area}_process AS process
 WHERE src.context_country = context_country
  AND src.orig_store_nr = orig_store_nr
  AND src.pos_terminal_id = pos_terminal_id
  AND src.orig_receipt_nr = orig_receipt_nr
  AND src.receipt_business_date = receipt_business_date);
  