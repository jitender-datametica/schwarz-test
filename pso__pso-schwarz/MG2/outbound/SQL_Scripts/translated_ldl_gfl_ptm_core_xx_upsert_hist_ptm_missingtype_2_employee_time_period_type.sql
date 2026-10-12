INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd
 , tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename,
 active_from_dt, perf_relevant_fg, emp_tm_period_type_natural_key, emp_tm_period_type_key_type_cd, on_site_fg,
 int_company_natural_key, emp_tm_period_type_id, int_company_key_type_cd, active_to_dt, emp_tm_period_type_short_descr,
 emp_tm_period_type_cd, emp_tm_period_type_descr)
(SELECT 'SAP_PTM' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'SAP_PTM' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  DATE('1900-01-01') AS active_from_dt,
   missingtype_perf_rel_fg <> 0 AS perf_relevant_fg,
     UPPER(SUBSTR(bic_zmlila, 1, 2)) || LTRIM(SUBSTR(CAST(wh_id AS STRING), 1, 39), '0') || '|' || LTRIM(sap_cd, '') AS
  emp_tm_period_type_natural_key,
  'GPS' AS emp_tm_period_type_key_type_cd,
   presence_fg <> 0 AS on_site_fg,
    UPPER(bic_zmlila) || '|' || LTRIM(SUBSTR(CAST(wh_id AS STRING), 1, 39), '0') AS int_company_natural_key,
  ROUND(CAST(missingtype_id AS BIGNUMERIC), 0) AS emp_tm_period_type_id,
  'COMPANY' AS int_company_key_type_cd,
  DATE('9999-12-31') AS active_to_dt,
  missingtype_short_desc AS emp_tm_period_type_short_descr,
  sap_cd AS emp_tm_period_type_cd,
  missingtype_desc AS emp_tm_period_type_descr
 FROM ldl_data_production_etl_process.t_${src_input_table} AS src);