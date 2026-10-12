INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd
 , tf_error_fg, dwh_load_id, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, real_estate_key_type_cd,
 int_org_key_type_cd, int_org_natural_key, real_estate_natural_key, plan_pos_nr, planned_val_type_key_type_cd,
 planned_val_type_natural_key, planned_kpi_meas, int_org_type_cd, cal_month)
(SELECT 'SAP_HANA' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  extraction_date AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  'DUMMY_2' AS real_estate_key_type_cd,
  'COMPANY' AS int_org_key_type_cd,
    UPPER(SUBSTR(vlxmlcntr, 1, 2)) || '|' || UPPER(SUBSTR(gxxmlklag, 1, 3)) AS int_org_natural_key,
  'DUMMY_2|DUMMY_2' AS real_estate_natural_key,
  '' AS plan_pos_nr,
  'PVAL' AS planned_val_type_key_type_cd,
  '248|WH_DLV' AS planned_val_type_natural_key,
  ROUND(CAST(plan AS BIGNUMERIC), 0) AS planned_kpi_meas,
  'COMPANY' AS int_org_type_cd,
  calmonth
 FROM ${temp_db}.t_${src_input_table} AS src
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY UPPER(SUBSTR(vlxmlcntr, 1, 2)) || '|' || UPPER(SUBSTR(gxxmlklag, 1, 3)),
       'COMPANY', 'DUMMY_2|DUMMY_2', calmonth, '248|WH_DLV', '' ORDER BY extraction_date IS NULL DESC, extraction_date DESC
       , extraction_ts IS NULL DESC, extraction_ts DESC)) = 1);