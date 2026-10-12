

 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, prod_nr, deleted_fg, record_id, dwh_mapping_tmsp,
 filename, prod_key_type_cd, -- FRAMEWORK AND TECHNICAL COLUMNS
 int_org_key_type_cd, ctrcode, prod_status_type_cd, prod_status_categ_cd)
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
  int_org_key_type_cd,
  CAST(ctrcode AS STRING) AS ctrcode,
  prod_status_type_cd,
  prod_status_categ_cd
 FROM (SELECT DISTINCT 1 AS ctrcode,
     'TRUST' AS int_org_key_type_cd,
     item_no AS prod_nr,
     'CBX' AS prod_key_type_cd,
     ldl_country_order_status AS prod_status_type_cd,
     'CBX_BUYING' AS prod_status_categ_cd,
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
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY item_no, ldl_country_order_status ORDER BY updated_on IS NULL DESC,
          updated_on DESC)) = 1 -- <<<  verify dedup logic interpretation

    UNION ALL
    SELECT DISTINCT 1 AS ctrcode,
     'TRUST' AS int_org_key_type_cd,
     item_no AS prod_nr,
     'CBX' AS prod_key_type_cd,
      CAST(status AS STRING) || '1' AS prod_status_type_cd,
     'CBX_WORKFLOW' AS prod_status_categ_cd,
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
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY item_no, status ORDER BY updated_on IS NULL DESC, updated_on DESC)) = 1
      -- <<<  verify dedup logic interpretation
) AS t9);