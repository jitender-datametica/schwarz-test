INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd
 , tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename,
 country_org_key_type_cd, country_org_cd, int_org_key_type_cd, int_org_natural_key, country_org_natural_key,
 int_org_type_cd, inv_period_start_dt, inv_reason_id, inv_type_cd, inv_key_type_cd, inv_nr, inv_period_end_dt, inv_dt,
 inv_natural_key)
(SELECT 'WAWI_WH' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'WAWI_WH' AS source_system,
  CAST(src.extraction_tmsp AS DATE) AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  'COUNTRY' AS country_org_key_type_cd,
  LEFT(src.ctrcode, 2) AS country_org_cd,
  'STORE' AS int_org_key_type_cd,
    src.ctrcode || '|' || CAST(src.c438_storenr AS STRING) AS int_org_natural_key,
  LEFT(src.ctrcode, 2) AS country_org_natural_key,
  'STORE' AS int_org_type_cd,
  CAST(src.c438_inventorydate AS DATE) AS inv_period_start_dt,
  src.c438_inv_type AS inv_reason_id,
  'PART' AS inv_type_cd,
  'PART' AS inv_key_type_cd,
  src.c438_inv_id AS inv_nr,
  CAST(src.c438_inventorydate AS DATE) AS inv_period_end_dt,
  CAST(src.c438_inventorydate AS DATE) AS inv_dt,
      src.ctrcode || '|' || CAST(src.wh_nr AS STRING) || '|' || CAST(src.c438_inv_id AS STRING) AS inv_natural_key
 FROM ldl_data_production_etl_process.t_${src_input_table} AS src
  INNER JOIN ${temp_db}.wawi_control_table AS ctrl ON ctrl.source_table_name = UPPER('LDL_DATA_PRODUCTION.${TEMP_DB}.t438_part_inv_head_wh'
      ) AND ctrl.source_status = 'A' AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp);