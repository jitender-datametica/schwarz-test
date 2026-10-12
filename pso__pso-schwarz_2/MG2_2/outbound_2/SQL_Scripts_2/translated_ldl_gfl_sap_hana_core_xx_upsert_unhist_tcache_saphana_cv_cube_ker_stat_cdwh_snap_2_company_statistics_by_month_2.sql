INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd
 , tf_error_fg, dwh_load_id, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, uom_cd, curr_cd,
 int_company_natural_key, int_company_key_type_cd, stat_type_cd, stat_qty, stat_dt, stat_cnt, cal_month, stat_meas,
 stat_val, curr_stat_fg)
(SELECT 'SAP_HANA' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  extraction_date AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  unit_2 AS uom_cd,
  CAST(NULL AS STRING) AS curr_cd,
    UPPER(SUBSTR(vlxmlcntr, 1, 2)) || '|' || UPPER(SUBSTR(gxxmlklag, 1, 3)) AS int_company_natural_key,
  'COMPANY' AS int_company_key_type_cd,
  '248' AS stat_type_cd,
  NULL AS stat_qty,
  extraction_date AS stat_dt,
  NULL AS stat_cnt,
  -- ?
 calmonth,
  ROUND(CAST(ist AS BIGNUMERIC), 0) AS stat_meas,
  NULL AS stat_val,
  CAST(1 AS BOOL) AS curr_stat_fg
 FROM ${temp_db}.t_${src_input_table} AS src);