
-- framework and technical columns


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, lang_cd, prod_status_type_descr,
 prod_status_type_cd, prod_status_categ_cd, dwh_updated_tmsp, dwh_created_tmsp)
(SELECT 'WAWI' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  't_wawi_precore_t117_itemstatus_1' AS filename,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  official_lang_cd AS lang_cd,
  statusdesc AS prod_status_type_descr,
  CAST(status_1 AS STRING) AS prod_status_type_cd,
  prod_status_categ_cd,
  CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
  CURRENT_TIMESTAMP() AS dwh_created_tmsp
 FROM (SELECT 'WAWI_HQ_LIFECYCLE' AS prod_status_categ_cd,
     t118.c118_status AS status_1,
     ANY_VALUE(TRIM(t118.c118_statusdesc)) AS statusdesc,
     t118.official_lang_cd
    FROM whwawiadm.t118_statusdesc_1 AS t118
     INNER JOIN ldl_data_production_core_rel.t_country_1 AS ctr ON ctr.iso_country_cd = LEFT(t118.wawi_instanz_kzl, 2) AND
      t118.dwh_valid_fg
    WHERE t118.c118_hq = 1
     AND t118.delete_fg IS NULL
     AND t118.official_lang_cd IS NOT NULL
    GROUP BY status_1,
     t118.official_lang_cd
    UNION DISTINCT
    SELECT 'WAWI_WH_LIFECYCLE' AS prod_status_categ_cd,
     t118.c118_status AS status_1,
     ANY_VALUE(TRIM(t118.c118_statusdesc)) AS statusdesc,
     t118.official_lang_cd
    FROM whwawiadm.t118_statusdesc_1 AS t118
     INNER JOIN ldl_data_production_core_rel.t_country_1 AS ctr ON ctr.iso_country_cd = LEFT(t118.wawi_instanz_kzl, 2) AND
      t118.dwh_valid_fg
    WHERE t118.c118_wh = 1
     AND t118.delete_fg IS NULL
     AND t118.official_lang_cd IS NOT NULL
    GROUP BY status_1,
     t118.official_lang_cd) AS src
 WHERE status_1 IS NOT NULL
  AND official_lang_cd IS NOT NULL
  AND statusdesc IS NOT NULL);