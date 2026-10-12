
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, lang_cd, prod_status_type_descr,
 prod_status_type_cd, prod_status_categ_cd)
(SELECT DISTINCT 'CBX_BUY_STATUS' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'CBX' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  'DE' AS lang_cd,
    clb.cust_text1 || '-' || cl.name AS prod_status_type_descr,
  cl.code AS prod_status_type_cd,
  'CBX_BUYING' AS prod_status_categ_cd
 FROM ${temp_db}.${t_src_input_table} AS cl
  LEFT JOIN ldl_data_production_etl.t_tcache_cbx_ctm_codelist_book_1 AS clb ON cl.id = clb.id
 WHERE cl.name = 'LIDL_CO_STATUS'
  AND clb.cust_text1 IS NOT NULL
  AND cl.code IS NOT NULL);