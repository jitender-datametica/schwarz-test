 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename
 , prod_grp_type_cd, prod_grp_nr, prod_grp_hierarchy_type_cd, 
 -- FRAMEWORK AND TECHNICAL COLUMNS
 parent_prod_grp_nr, parent_prod_grp_type_cd)
(SELECT DISTINCT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
   0 <> 0 AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CAST(src.mod_date AS TIMESTAMP) AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  'IFG' AS prod_grp_type_cd,
  UPPER(CAST(src.itemgrpnr AS STRING) || '.' || LPAD(SUBSTR(CAST(src.family_code AS STRING), 1, 10), 3, '0')) AS
  prod_grp_nr,
  'IGH' AS prod_grp_hierarchy_type_cd,
  CAST(UPPER(src.itemgrpnr) AS STRING) AS parent_prod_grp_nr,
  'SIG' AS parent_prod_grp_type_cd
 FROM ${temp_db}.t_${src_input_table} AS src
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
     FROM ${temp_db}.t_${src_input_table}) AS a) AS csrc ON src.ctrcode = csrc.ctrcode
   
 QUALIFY csrc.eks_rank = (MIN(csrc.eks_rank) OVER (PARTITION BY CAST(src.itemgrpnr AS STRING) || '.' || LPAD(SUBSTR(CAST(src.family_code AS STRING)
           , 1, 10), 3, '0') RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AND (ROW_NUMBER() OVER (PARTITION BY CAST(src.itemgrpnr AS STRING)
          || '.' || LPAD(SUBSTR(CAST(src.family_code AS STRING), 1, 10), 3, '0'), src.ctrcode ORDER BY src.extraction_tmsp
        IS NULL DESC, src.extraction_tmsp DESC)) = 1);