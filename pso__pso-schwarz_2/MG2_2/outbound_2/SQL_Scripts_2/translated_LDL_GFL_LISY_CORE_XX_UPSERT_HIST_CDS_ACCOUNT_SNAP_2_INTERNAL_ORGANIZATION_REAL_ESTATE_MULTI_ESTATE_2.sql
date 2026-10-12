
INSERT INTO ldl_data_production_etl.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id
 , source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, real_estate_nk,
 real_estate_key_type_cd, int_org_real_estate_usg_type_cd, int_org_key_type_cd, int_org_nk)
(SELECT 'LISY' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'LISY' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CAST(CASE
    WHEN CAST(src.igl_expectedopeningdate AS DATE) > CURRENT_DATE OR CAST(src.igl_neodate AS DATE) >= CURRENT_DATE
    THEN src.sinkmodifiedon
    ELSE IFNULL(src.igl_neodate, src.sinkmodifiedon)
    END AS TIMESTAMP) AS dwh_mapping_tmsp,
  '${t_SRC_INPUT_TABLE}' AS filename,
    LOWER(SUBSTR(src.igl_number, 1, 2)) || '|' || CAST(ROUND(CAST(SUBSTR(src.igl_number, 3, 5) AS BIGNUMERIC), 0) AS
    STRING) AS real_estate_nk,
  'RE_2' AS real_estate_key_type_cd,
  'USED_BY' AS int_org_real_estate_usg_type_cd,
  'STORE' AS int_org_key_type_cd,
    LOWER(SUBSTR(src.igl_number, 1, 2)) || '|' || CAST(ROUND(CAST(SUBSTR(src.igl_number, 3, 5) AS BIGNUMERIC), 0) AS
    STRING) AS int_org_nk
 FROM ldl_data_production_etl_process.${t_src_input_table} AS src
  INNER JOIN ldl_data_production_meta.t_party_key_2 AS store ON store.dwh_valid_from_tmsp = UPPER(SUBSTR(src.igl_number, 1
        , 2)) || '|' || CAST(ROUND(CAST(SUBSTR(src.igl_number, 3, 5) AS BIGNUMERIC), 0) AS STRING) AND src.igl_contractdate
     = 'STORE'
  INNER JOIN ldl_data_production_meta.t_resource_item_key_2 AS building ON building.dwh_valid_from_tmsp = UPPER(SUBSTR(src
        .igl_number, 1, 2)) || '|' || CAST(ROUND(CAST(SUBSTR(src.igl_number, 3, 5) AS BIGNUMERIC), 0) AS STRING) AND
    store.dwh_load_id = 'RE_2'
 WHERE CAST(src.igl_expectedopeningdate AS DATE) <= CURRENT_DATE
  OR CAST(src.igl_neodate AS DATE) < CURRENT_DATE);