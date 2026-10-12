
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, prod_grp_key_type_cd, prod_grp_status_type_cd,
 prod_grp_nr)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(MAX(extraction_tmsp) AS DATE) AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CAST(MAX(moddate) AS TIMESTAMP) AS dwh_mapping_tmsp,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'IGI' AS prod_grp_key_type_cd,
  'A' AS prod_grp_status_type_cd,
  CAST(wgi_id AS STRING) AS wgi_id
 FROM ${temp_db}.${t_src_input_table} AS src
 GROUP BY src.wgi_id);