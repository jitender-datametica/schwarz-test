

 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, prod_nr, deleted_fg, record_id, dwh_mapping_tmsp,
 filename, prod_key_type_cd, prod_grp_key_type_cd, -- FRAMEWORK AND TECHNICAL COLUMNS
 prod_grp_type_cd, prod_grp_nr)
(SELECT dwh_node_cd,
  tf_error_fg,
  dwh_load_id,
  source_system,
  extraction_dt,
  prod_nr,
   deleted_fg <> 0 AS deleted_fg,
  CAST(record_id AS STRING) AS record_id,
  CAST(dwh_mapping_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  filename,
  prod_key_type_cd,
  prod_grp_key_type_cd,
  prod_grp_type_cd,
  prod_grp_nr
 FROM (SELECT -- CBX_P
 'CBX' AS prod_key_type_cd,
     item_no AS prod_nr,
     'P' AS prod_grp_key_type_cd,
     COALESCE(ldl_pillar, '@') AS prod_grp_nr,
     'P' AS prod_grp_type_cd,
     -- FRAMEWORK AND TECHNICAL COLUMNS
 'CBX' AS source_system,
     CURRENT_DATE AS extraction_dt,
     updated_on AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     't_${SRC_INPUT_TABLE}' AS filename,
     'CBX' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM ${temp_db}.t_${src_input_table} AS src
    WHERE item_no <> '0'
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY item_no, COALESCE(ldl_pillar, '@') ORDER BY updated_on IS NULL DESC,
          updated_on DESC)) = 1
    UNION DISTINCT
    SELECT -- CBX_IFG
 'CBX' AS prod_key_type_cd,
     item_no AS prod_nr,
     'IFG' AS prod_grp_key_type_cd,
       LTRIM(SPLIT(ldl_article_group, '_')[OFFSET(0)], '0') || '|' || LTRIM(SPLIT(ldl_article_group, '_')[OFFSET(1)],
       '0') AS prod_grp_nr,
     'IFG' AS prod_grp_type_cd,
     -- FRAMEWORK AND TECHNICAL COLUMNS
 'CBX' AS source_system,
     CURRENT_DATE AS extraction_dt,
     updated_on AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     't_${SRC_INPUT_TABLE}' AS filename,
     'CBX' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM ${temp_db}.t_${src_input_table} AS src
    WHERE item_no <> '0'
     AND ldl_article_group IS NOT NULL
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY item_no, LTRIM(SPLIT(ldl_article_group, '_')[OFFSET(0)], '0') || '|' ||
           LTRIM(SPLIT(ldl_article_group, '_')[OFFSET(1)], '0') ORDER BY updated_on IS NULL DESC, updated_on DESC)) = 1
   ) AS t7);