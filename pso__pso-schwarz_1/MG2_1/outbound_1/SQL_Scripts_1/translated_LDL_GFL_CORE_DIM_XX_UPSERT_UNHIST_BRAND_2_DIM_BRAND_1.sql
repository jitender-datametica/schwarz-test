
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, record_id,
 filename, error_descr, brand_name)
(SELECT dwh_node_cd,
  0 AS tf_error_fg,
  ${load_id} AS dwh_load_id,
  CAST(0 AS STRING) AS record_id,
  'core_rel' AS filename,
  '' AS error_descr,
  UPPER(brand_name) AS brand_name
 FROM ldl_data_production_core_rel.t_brand_1
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY UPPER(brand_name) ORDER BY UPPER(brand_name) IS NULL DESC, UPPER(brand_name)
       DESC)) = 1);