
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, resource_item_key_type_cd,
 export_warehouse_name)
(SELECT DISTINCT ct.dwh_src_file_name,
  ct.tf_error_fg,
  ct.dwh_src_1_tmsp,
   ct.deleted_fg <> 0 AS deleted_fg,
  CAST(ct.record_id AS STRING) AS record_id,
  ct.dwh_mapping_tmsp,
  ct.filename,
  ct.resource_item_key_type_cd,
  ct.export_warehouse_name
 FROM (SELECT DISTINCT 'EXPORT_WAREHOUSE' AS resource_item_key_type_cd,
    UPPER(TRIM(entitaetsnr)) AS export_warehouse_name,
    dwh_src_file_name,
    dwh_src_1_tmsp,
    dwh_src_1_tmsp AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    dwh_src_file_name AS filename
   FROM szd_production_etl.t_cache_sventitaet_2
   WHERE entitaetsart = 'PLAG'
    AND entitaetsnr IS NOT NULL
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY export_warehouse_name ORDER BY dwh_src_file_name IS NULL, dwh_src_file_name
       )) = 1) AS ct
  LEFT JOIN szd_production_meta.t_resource_item_key_2 AS rk ON ct.resource_item_key_type_cd = rk.resource_item_key_type_cd
     AND ct.export_warehouse_name = rk.resource_item_nat_key_nr
  LEFT JOIN szd_production_core_rel.t_export_warehouse_2 AS c ON rk.resource_item_sid = c.resource_item_sid
 WHERE c.resource_item_sid IS NULL);