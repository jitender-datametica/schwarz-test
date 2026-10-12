
-- FRAMEWORK AND TECHNICAL COLUMNS


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, prod_grp_key_type_cd, prod_grp_nr,
 prod_grp_key_nr, prod_grp_type_cd, prod_grp_name)
(SELECT DISTINCT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
   0 <> 0 AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CAST(src.moddate AS TIMESTAMP) AS dwh_mapping_tmsp,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'IGI' AS prod_grp_key_type_cd,
  CAST(src.wgi_id AS STRING) AS prod_grp_nr,
  CAST(src.wgi_id AS STRING) AS prod_grp_key_nr,
  'IGI' AS prod_grp_type_cd,
  src.int_desc AS prod_grp_name
 FROM ${temp_db}.${t_src_input_table} AS src
  INNER JOIN (SELECT ctrcode,
    RANK() OVER (ORDER BY CASE
        WHEN ctrcode = 'DE'
        THEN 1
        WHEN ctrcode NOT IN ('BG', 'CY', 'GR')
        THEN 2
        WHEN ctrcode = 'GR'
        THEN 3
        WHEN ctrcode IN ('BG', 'CY')
        THEN 4
        ELSE NULL
        END IS NULL, CASE
        WHEN ctrcode = 'DE'
        THEN 1
        WHEN ctrcode NOT IN ('BG', 'CY', 'GR')
        THEN 2
        WHEN ctrcode = 'GR'
        THEN 3
        WHEN ctrcode IN ('BG', 'CY')
        THEN 4
        ELSE NULL
        END, ctrcode IS NULL, ctrcode) AS eks_rank
   FROM (SELECT DISTINCT ctrcode
     FROM ${temp_db}.${t_src_input_table}) AS a) AS csrc ON src.ctrcode = csrc.ctrcode
 QUALIFY csrc.eks_rank = (MIN(csrc.eks_rank) OVER (PARTITION BY src.wgi_id RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) AND (ROW_NUMBER() OVER (PARTITION BY src.wgi_id, src.ctrcode ORDER BY src.extraction_tmsp
        IS NULL DESC, src.extraction_tmsp DESC)) = 1);