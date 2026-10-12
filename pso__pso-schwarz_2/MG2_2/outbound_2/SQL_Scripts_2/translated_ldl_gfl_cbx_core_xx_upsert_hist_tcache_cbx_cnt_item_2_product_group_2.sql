

 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename
 , prod_grp_key_type_cd, -- FRAMEWORK AND TECHNICAL COLUMNS
 prod_grp_key_nr, prod_grp_type_cd, prod_grp_name, prod_grp_nr)
(SELECT dwh_node_cd,
  tf_error_fg,
  dwh_load_id,
  source_system,
  extraction_dt,
   deleted_fg <> 0 AS deleted_fg,
  CAST(record_id AS STRING) AS record_id,
  CAST(dwh_mapping_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  filename,
  prod_grp_key_type_cd,
  prod_grp_key_nr,
  prod_grp_type_cd,
  prod_grp_name,
  prod_grp_nr
 FROM (SELECT DISTINCT 'MP' AS prod_grp_key_type_cd,
      CASE
      WHEN product_category_value = 'Hartware'
      THEN 'HG'
      WHEN product_category_value = 'Textil'
      THEN 'TX'
      ELSE '@'
      END AS prod_grp_key_nr,
     'MP' AS prod_grp_type_cd,
      CASE
      WHEN product_category_value = 'Hartware'
      THEN 'HG'
      WHEN product_category_value = 'Textil'
      THEN 'TX'
      ELSE '@'
      END AS prod_grp_nr,
     COALESCE(product_category_value, '@') AS prod_grp_name,
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
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY prod_grp_key_nr ORDER BY updated_on IS NULL DESC, updated_on DESC)) = 1
    UNION ALL
    SELECT DISTINCT 'P' AS prod_grp_key_type_cd,
     UPPER(ldl_pillar) AS prod_grp_key_nr,
     'P' AS prod_grp_type_cd,
     UPPER(ldl_pillar) AS prod_grp_nr,
     ldl_pillar AS prod_grp_name,
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
     AND ldl_pillar IS NOT NULL
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY prod_grp_key_nr ORDER BY updated_on IS NULL DESC, updated_on DESC)) = 1) AS
  t9);