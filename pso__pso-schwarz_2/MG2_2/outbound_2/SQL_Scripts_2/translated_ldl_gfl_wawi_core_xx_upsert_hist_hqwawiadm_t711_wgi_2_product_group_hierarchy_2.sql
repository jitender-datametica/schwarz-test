
-- FRAMEWORK AND TECHNICAL COLUMNS


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, prod_grp_nr, prod_grp_type_cd,
 prod_grp_hierarchy_type_cd, parent_prod_grp_nr, parent_prod_grp_type_cd)
(SELECT DISTINCT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
   0 <> 0 AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CAST(src.c711_moddate AS TIMESTAMP) AS dwh_mapping_tmsp,
  '${t_SRC_INPUT_TABLE}' AS filename,
  CAST(UPPER(src.c711_item_group) AS STRING) AS prod_grp_nr,
  'SIG' AS prod_grp_type_cd,
  'IGH' AS prod_grp_hierarchy_type_cd,
  CAST(UPPER(src.c711_wgi_id) AS STRING) AS parent_prod_grp_nr,
  'IGI' AS parent_prod_grp_type_cd
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
     WHERE delete_fg IS NULL) AS a) AS csrc ON src.wawi_instanz_kzl = csrc.wawi_instanz_kzl
 WHERE src.delete_fg IS NULL
 QUALIFY csrc.eks_rank = (MIN(csrc.eks_rank) OVER (PARTITION BY src.c711_wgi_id RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) AND (ROW_NUMBER() OVER (PARTITION BY src.c711_wgi_id, src.c711_item_group, src.wawi_instanz_kzl
        ORDER BY src.extraction_tmsp IS NULL DESC, src.extraction_tmsp DESC)) = 1);