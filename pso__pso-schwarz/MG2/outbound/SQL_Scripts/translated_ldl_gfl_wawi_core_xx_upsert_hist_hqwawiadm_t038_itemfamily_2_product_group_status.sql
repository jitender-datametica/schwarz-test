INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, prod_grp_key_type_cd, family_code, item_grp_nr,
 prod_grp_status_type_cd)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(extraction_tmsp AS DATE) AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CAST(c038_mod_date AS TIMESTAMP) AS dwh_mapping_tmsp,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'IGF' AS prod_grp_key_type_cd,
  c038_family_code,
  CAST(c038_itemgrpnr AS STRING) AS c038_itemgrpnr,
  'A' AS prod_grp_status_type_cd
 FROM ${ldl_wawi_common_snflk_cl_db_name}.${src_input_table}
 WHERE delete_fg IS NULL);