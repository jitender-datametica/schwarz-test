
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_{src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, lang_cd, int_org_key_type_cd,
 order_area_nr, int_org_nk, order_area_descr)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'WAWI_HQ' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'DE' AS lang_cd,
  'COUNTRY' AS int_org_key_type_cd,
  bestbereichnr AS order_area_nr,
   CASE
   WHEN wawi_instanz_kzl = 'CS'
   THEN 'ES'
   ELSE LEFT(wawi_instanz_kzl, 2)
   END AS int_org_nk,
  bestbereichbez AS order_area_descr
 FROM ${ldl_wawi_common_snflk_cl_db_name}.${src_input_table} AS src
 WHERE delete_fg IS NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY CASE
        WHEN wawi_instanz_kzl = 'CS'
        THEN 'ES'
        ELSE LEFT(wawi_instanz_kzl, 2)
        END, bestbereichnr ORDER BY extraction_tmsp IS NULL DESC, extraction_tmsp DESC)) = 1);