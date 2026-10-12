INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd
 , tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, bus_dt,
 cash_register_type_cd, cash_register_usg_type_cd, country_org_sid, cash_register_sid, store_sid, real_estate_sid,
 country_org_cd, curr_cd, cash_register_event_nr, cashier_hash, training_fg, event_tmsp, suspend_fg, cancel_fg,
 offline_fg, prod_variant_key_type_cd, prod_bought_fg, price_info_event_sid, prod_variant_natural_key,
 wawi_item_nat_key_nr, prod_price, wawi_item_key_type_cd)
(SELECT 'EJR' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  -- Awaiting populated field from source,
 'EJR' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  'V_${SRC_INPUT_TABLE}' AS filename,
  receipt_business_date AS bus_dt,
  pos_type AS cash_register_type_cd,
  CAST(NULL AS STRING) AS cash_register_usg_type_cd,
  country_org_sid,
  cash_register_sid,
  store_sid,
  real_estate_sid,
  country_org_cd,
  curr_cd,
  orig_receipt_nr AS cash_register_event_nr,
  checker_hash AS cashier_hash,
  training_fg IS TRUE AS training_fg,
  CAST(receipt_timestamp_begin AS TIMESTAMP) AS event_tmsp,
  FALSE AS suspend_fg,
  FALSE AS cancel_fg,
  offline_fg IS TRUE AS offline_fg,
  'SLS_UNK' AS prod_variant_key_type_cd,
   - 1 <> 0 AS prod_bought_fg,
     ((((ROUND(CAST(FORMAT_DATE('%Y%m%d', receipt_business_date) AS BIGNUMERIC), 0) * 100 + ASCII(SUBSTR(context_country
                 , 1, 1))) * 100 + ASCII(SUBSTR(context_country, 2, 1))) * 100000000 + orig_store_nr) * 10000 +
      pos_terminal_id) * 10000000000 + orig_receipt_nr AS price_info_event_sid,
    context_country || '|' || CAST(orig_item_nr AS STRING) AS prod_variant_natural_key,
    UPPER(CASE
      WHEN context_country = 'CS'
      THEN 'ES'
      ELSE context_country
      END) || '|' || CAST(orig_item_nr AS STRING) AS wawi_item_nat_key_nr,
  val_retail AS prod_price,
  'WAWI' AS wawi_item_key_type_cd
 FROM ldl_data_production_etl.v_${src_input_table} AS src
 WHERE receipt_transactiontype_id = '480'
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY context_country, CAST(orig_store_nr AS STRING), CAST(pos_terminal_id AS STRING)
       , CAST(orig_receipt_nr AS STRING), receipt_business_date, receipt_transactiontype_id, receipt_timestamp_begin
     ORDER BY receipt_timestamp_end IS NULL DESC, receipt_timestamp_end DESC)) = 1);