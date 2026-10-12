
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, inv_key_type_cd, inv_natural_key,
 inv_status_type_cd)
(SELECT 'WAWI_WH' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'WAWI_WH' AS source_system,
  CAST(src.extraction_tmsp AS DATE) AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'PART' AS inv_key_type_cd,
      src.ctrcode || '|' || CAST(src.wh_nr AS STRING) || '|' || CAST(src.c438_inv_id AS STRING) AS inv_natural_key,
  CAST(CASE
    WHEN src.c438_status = 10
    THEN - 10
    WHEN src.c438_status = 20
    THEN - 20
    WHEN src.c438_status = 99
    THEN - 99
    ELSE src.c438_status
    END AS STRING) AS inv_status_type_cd
 FROM etl_process.${t_src_input_table} AS src
  INNER JOIN ${temp_db}.wawi_control_table_1 AS ctrl ON ctrl.source_table_name = UPPER('${TEMP_DB}.t438_part_inv_head_wh_1'
      ) AND ctrl.source_status = 'A' AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp);