
INSERT INTO ldl_data_production_etl.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, source_system,
 addr_type_cd, extraction_dt, deleted_fg, addr_usg_type_cd, record_id, dwh_mapping_tmsp, filename, addr_sid,
 real_estate_sid)
(SELECT dwh_node_cd,
  tf_error_fg,
  dwh_load_id,
  source_system,
  addr_type_cd,
  extraction_dt,
   deleted_fg <> 0 AS deleted_fg,
  addr_usg_type_cd,
  CAST(record_id AS STRING) AS record_id,
  CAST(dwh_mapping_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  filename,
  addr_sid,
  retail_estate_sid
 FROM (SELECT real_estate_sid AS retail_estate_sid,
     COALESCE(addr_sid, CAST(tel_sid AS BIGNUMERIC)) AS addr_sid,
     'SA_MN' AS addr_usg_type_cd,
     'STAD' AS addr_type_cd,
     'LISY' AS source_system,
     CURRENT_DATE AS extraction_dt,
     src_sinkmodifiedon AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${t_SRC_INPUT_TABLE}' AS filename,
     'LISY' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM ldl_data_production_etl_process.${t_src_input_table} AS src
    WHERE addr_sid IS NOT NULL
    UNION ALL
    SELECT real_estate_sid AS retail_estate_sid,
     ROUND(CAST(tel_sid AS BIGNUMERIC), 0) AS addr_sid,
     'TL_MN' AS addr_usg_type_cd,
     'TEL' AS addr_type_cd,
     'LISY' AS source_system,
     CURRENT_DATE AS extraction_dt,
     src_sinkmodifiedon AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${t_SRC_INPUT_TABLE}' AS filename,
     'LISY' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM ldl_data_production_etl_process.${t_src_input_table} AS src
    WHERE tel_sid IS NOT NULL) AS t3);