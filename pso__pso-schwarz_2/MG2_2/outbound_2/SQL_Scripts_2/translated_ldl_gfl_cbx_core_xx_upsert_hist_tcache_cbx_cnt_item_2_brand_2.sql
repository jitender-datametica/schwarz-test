
 
 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename
 , brand_name-- BRAND_TYPE_CD,
 )
(SELECT DISTINCT 'CBX' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'CBX' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  UPPER(ldl_brand_name) AS brand_name
  -- , ldl_brand_type as BRAND_TYPE_CD
 FROM ${temp_db}.t_${src_input_table} AS src
 WHERE item_no <> '0'
  AND ldl_brand IS NOT NULL);