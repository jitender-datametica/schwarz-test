 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename
 , event_start_tmsp, event_end_tmsp, bus_dt, turnover_relevant_fg, cash_register_type_cd, cash_register_usg_type_cd,
 cust_sid, country_org_sid, cash_register_sid, store_sid, retail_event_sid, real_estate_sid, country_org_cd, curr_cd,
 cash_register_event_nr, cashier_hash, training_fg, suspend_fg, cancel_fg, offline_fg, txn_vat_val, cust_ident_type_cd,
 paym_tm_sec_meas, txn_net_val, keyed_lines_cnt, txn_gross_val, scanned_lines_cnt, retail_event_type_cd,
 service_tm_sec_meas, retail_event_scenario_id, auth_by_hash, susp_retail_event_sid)
(SELECT 'EJR' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'EJR' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  'T_${SRC_INPUT_TABLE}' AS filename,
  CAST(receipt_timestamp_begin AS TIMESTAMP) AS event_start_tmsp,
  CAST(receipt_timestamp_end AS TIMESTAMP) AS event_end_tmsp,
  receipt_business_date AS bus_dt,
  (receipt_transactiontype_id IN ('100', '150')) IS TRUE AS turnover_relevant_fg,
  pos_type AS cash_register_type_cd,
  CAST(NULL AS STRING) AS cash_register_usg_type_cd,
  cust_sid,
  country_org_sid,
  cash_register_sid,
  store_sid,
  retail_event_sid,
  real_estate_sid,
  country_org_cd,
  curr_cd,
  orig_receipt_nr AS cash_register_event_nr,
  checker_hash AS cashier_hash,
  training_fg IS TRUE AS training_fg,
   SUBSTR(receipt_transactiontype_id, 1, 1) = '3' AS suspend_fg, /* 300, 301, 350, 351 */
   SUBSTR(receipt_transactiontype_id, 1, 1) = '2' AS cancel_fg, /* 200, 201, 250, 251 */ 
  offline_fg IS TRUE AS offline_fg,
   val_retail - val_retail_net AS txn_vat_val,
  lidlplus_ident_type_cd AS cust_ident_type_cd,
   dur_pay_change_time / 1000 AS paym_tm_sec_meas,
  val_retail_net AS txn_net_val,
  orig_cnt_dirpos AS keyed_lines_cnt,
  val_retail AS txn_gross_val,
  orig_cnt_scanpos AS scanned_lines_cnt,
   CASE
   WHEN SUBSTR(receipt_transactiontype_id, 2, 1) = '5'
   THEN 'R' /* RETURN ... 150, 151, 250, 251, 350, 351 */
   ELSE 'S' /* SALES ... 100, 101, 200, 201, 300, 301 */
   END AS retail_event_type_cd,
   dur_service_time / 1000 AS service_tm_sec_meas,
  ROUND(CAST(receipt_transactiontype_id AS BIGNUMERIC), 0) AS retail_event_scenario_id,
  receipt_authority_hash AS auth_by_hash,
     ((((ROUND(CAST(FORMAT_DATE('%Y%m%d', resumed_trans_date) AS BIGNUMERIC), 0) * 100 + ASCII(SUBSTR(context_country, 1
                 , 1))) * 100 + ASCII(SUBSTR(context_country, 2, 1))) * 100000000 + resumed_trans_store_nr) * 10000 +
      resumed_trans_terminal_id) * 10000000000 + resumed_trans_receipt_nr AS susp_retail_event_sid
 FROM ldl_data_production_etl.t_${src_input_table} AS src
 WHERE receipt_transactiontype_id BETWEEN '100' AND '399'
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY context_country, CAST(orig_store_nr AS STRING), CAST(pos_terminal_id AS STRING)
       , CAST(orig_receipt_nr AS STRING), receipt_business_date ORDER BY receipt_timestamp_end IS NULL DESC,
       receipt_timestamp_end DESC, posnr IS NULL, posnr)) = 1);