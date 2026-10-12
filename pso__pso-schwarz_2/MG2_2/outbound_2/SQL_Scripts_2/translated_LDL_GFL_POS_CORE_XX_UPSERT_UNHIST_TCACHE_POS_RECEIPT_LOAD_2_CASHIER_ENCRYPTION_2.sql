
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, dwh_mapping_tmsp, country_org_cd, store_nr, cashier_hash, bus_dt, cashier_nr)
(SELECT dwh_node_cd,
  tf_error_fg,
  dwh_load_id,
   deleted_fg <> 0 AS deleted_fg,
  CAST(record_id AS STRING) AS record_id,
  filename,
  dwh_mapping_tmsp,
  country_org_cd,
  store_nr,
  cashier_hash,
  bus_dt,
  cashier_nr
 FROM (SELECT cashier_hash,
    bus_dt,
    store_nr,
    country_org_cd,
    cashier_nr,
    CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    '${V_SRC_INPUT_TABLE}' AS filename,
    'EJR' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
   FROM ldl_data_production_core_app_fraud_detection.t_cashier_encryption_2 AS src
   LIMIT 1000) AS t0);