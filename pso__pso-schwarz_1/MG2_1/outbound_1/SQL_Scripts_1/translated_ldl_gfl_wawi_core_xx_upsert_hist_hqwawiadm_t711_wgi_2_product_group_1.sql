
-- FRAMEWORK AND TECHNICAL COLUMNS


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, prod_grp_key_type_cd, prod_grp_nr,
 prod_grp_key_nr, prod_grp_type_cd, prod_grp_name)
(SELECT DISTINCT t7.dwh_node_cd,
  t7.tf_error_fg,
  t7.dwh_load_id,
  t7.source_system,
  t7.extraction_dt,
   t7.deleted_fg <> 0 AS deleted_fg,
  CAST(t7.record_id AS STRING) AS record_id,
  CAST(t7.dwh_mapping_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  t7.filename,
  t7.prod_grp_key_type_cd,
  CAST(t7.prod_grp_nr AS STRING) AS prod_grp_nr,
  CAST(t7.prod_grp_key_nr AS STRING) AS prod_grp_key_nr,
  t7.prod_grp_type_cd,
  t7.prod_grp_name
 FROM (SELECT DISTINCT 'IGI' AS prod_grp_key_type_cd,
    src.c711_wgi_id AS prod_grp_key_nr,
    'IGI' AS prod_grp_type_cd,
    src.c711_wgi_id AS prod_grp_nr,
    src.c711_int_desc AS prod_grp_name,
    'WAWI' AS source_system,
    CURRENT_DATE AS extraction_dt,
    src.c711_moddate AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    '${t_SRC_INPUT_TABLE}' AS filename,
    'WAWI_HQ' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id,
    csrc.wawi_instanz_kzl AS wawi_instanz_kzl0,
    src.c711_wgi_id,
    src.wawi_instanz_kzl,
    src.extraction_tmsp
   FROM ${ldl_wawi_common_snflk_cl_db_name}.${src_input_table} AS src
    INNER JOIN (SELECT wawi_instanz_kzl,
      RANK() OVER (ORDER BY CASE
          WHEN wawi_instanz_kzl = 'DE'
          THEN 1
          WHEN wawi_instanz_kzl NOT IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN wawi_instanz_kzl = 'GR'
          THEN 3
          WHEN wawi_instanz_kzl IN ('BG', 'CY')
          THEN 4
          ELSE NULL
          END IS NULL, CASE
          WHEN wawi_instanz_kzl = 'DE'
          THEN 1
          WHEN wawi_instanz_kzl NOT IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN wawi_instanz_kzl = 'GR'
          THEN 3
          WHEN wawi_instanz_kzl IN ('BG', 'CY')
          THEN 4
          ELSE NULL
          END, wawi_instanz_kzl IS NULL, wawi_instanz_kzl) AS eks_rank
     FROM (SELECT DISTINCT wawi_instanz_kzl
       FROM ${ldl_wawi_common_snflk_cl_db_name}.${src_input_table}
       WHERE delete_fg IS NULL) AS a) AS csrc ON src.wawi_instanz_kzl = src.c711_item_group
   WHERE src.delete_fg IS NULL
   QUALIFY wawi_instanz_kzl0 = (MIN(wawi_instanz_kzl0) OVER (PARTITION BY src.c711_wgi_id RANGE BETWEEN
        UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AND (ROW_NUMBER() OVER (PARTITION BY src.c711_wgi_id, src.wawi_instanz_kzl
          ORDER BY src.extraction_tmsp IS NULL DESC, src.extraction_tmsp DESC)) = 1) AS t7);