
-- FRAMEWORK AND TECHNICAL COLUMNS


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 source_system, prod_status_type_cd, extraction_dt, prod_nr, deleted_fg, record_id, prod_status_categ_cd,
 dwh_mapping_tmsp, filename, prod_key_type_cd)
(SELECT dwh_node_cd,
  tf_error_fg,
  dwh_load_id,
  source_system,
  CAST(prod_status_type_cd AS STRING) AS prod_status_type_cd,
  extraction_dt,
  prod_nr,
   deleted_fg <> 0 AS deleted_fg,
  CAST(record_id AS STRING) AS record_id,
  prod_status_categ_cd,
  CAST(dwh_mapping_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  filename,
  prod_key_type_cd
 FROM (SELECT DISTINCT 'CBX' AS prod_key_type_cd,
     item_no AS prod_nr,
     'CBX_WORKFLOW' AS prod_status_categ_cd,
     status_1 AS prod_status_type_cd,
     'CBX' AS source_system,
     CURRENT_DATE AS extraction_dt,
     updated_on AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${t_SRC_INPUT_TABLE}' AS filename,
     'CBX' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM ${temp_db}.${t_src_input_table} AS src
    WHERE item_no <> '0'
    UNION ALL
    SELECT DISTINCT 'CBX' AS prod_key_type_cd,
     item_no AS prod_nr,
     'CBX_BUYING' AS prod_status_categ_cd,
     CAST(ldl_country_order_status AS INTEGER) AS prod_status_type_cd,
     'CBX' AS source_system,
     CURRENT_DATE AS extraction_dt,
     updated_on AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${t_SRC_INPUT_TABLE}' AS filename,
     'CBX' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM ${temp_db}.${t_src_input_table} AS src
    WHERE item_no <> '0'
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY item_no, status_1 ORDER BY updated_on IS NULL DESC, updated_on DESC)) = 1) AS
  t7);