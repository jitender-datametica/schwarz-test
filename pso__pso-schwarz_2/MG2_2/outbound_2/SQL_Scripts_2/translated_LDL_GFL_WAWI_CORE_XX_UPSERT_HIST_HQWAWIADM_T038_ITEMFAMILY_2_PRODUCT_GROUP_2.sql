
-- FRAMEWORK AND TECHNICAL COLUMNS


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, prod_grp_key_type_cd, prod_grp_key_nr
 , prod_grp_type_cd, prod_grp_name, prod_grp_nr)
(SELECT DISTINCT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '726028' AS dwh_load_id,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
   0 <> 0 AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CAST(src.c038_mod_date AS TIMESTAMP) AS dwh_mapping_tmsp,
  't_hqwawiadm.t038_itemfamily_2' AS filename,
  'IFG' AS prod_grp_key_type_cd,
    CAST(src.c038_itemgrpnr AS STRING) || '|' || CAST(src.c038_family_code AS STRING) AS prod_grp_key_nr,
  'IFG' AS prod_grp_type_cd,
  src.c038_desc_long AS prod_grp_name,
    CAST(src.c038_itemgrpnr AS STRING) || '.' || LPAD(SUBSTR(CAST(src.c038_family_code AS STRING), 1, 10), 3, '0') AS
  prod_grp_nr
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
 QUALIFY csrc.eks_rank = (MIN(csrc.eks_rank) OVER (PARTITION BY CAST(src.c038_itemgrpnr AS STRING) || '.' || LPAD(SUBSTR(CAST(src.c038_family_code AS STRING)
           , 1, 10), 3, '0') RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AND (ROW_NUMBER() OVER (PARTITION BY CAST(src.c038_itemgrpnr AS STRING)
          || '.' || LPAD(SUBSTR(CAST(src.c038_family_code AS STRING), 1, 10), 3, '0'), src.wawi_instanz_kzl ORDER BY src
        .extraction_tmsp IS NULL DESC, src.extraction_tmsp DESC)) = 1);