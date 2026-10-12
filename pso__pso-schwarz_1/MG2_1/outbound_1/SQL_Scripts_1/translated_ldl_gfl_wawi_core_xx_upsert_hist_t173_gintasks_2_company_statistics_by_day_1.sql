
 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename
 , uom_cd, bus_dt, curr_cd, int_company_natural_key, int_company_key_type_cd, stat_type_cd, stat_qty, stat_dt, stat_cnt
 , stat_meas, stat_val, curr_stat_fg)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  -- 
 'WAWI' AS source_system,
  CAST(MAX(extraction_tmsp) AS DATE) AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CAST(MAX(extraction_tmsp) AS TIMESTAMP) AS dwh_mapping_tmsp,
  '${SRC_INPUT_TABLE}' AS filename,
  CAST(NULL AS STRING) AS uom_cd,
  DATE(c173_create_date) AS bus_dt,
  CAST(NULL AS STRING) AS curr_cd,
    ctrcode || '|' || CAST(CAST(wh_nr AS BIGNUMERIC) AS STRING) AS int_company_natural_key,
  'COMPANY' AS int_company_key_type_cd,
  CAST(138 AS STRING) AS stat_type_cd,
   SUM(c173_pal_dd_goods * 0.5) + SUM(c173_pal_eu_goods) AS stat_qty,
  CAST(CURRENT_TIMESTAMP() AS DATE) AS stat_dt,
  NULL AS stat_cnt,
  NULL AS stat_meas,
  NULL AS stat_val,
   1 <> 0 AS curr_stat_fg
 FROM (SELECT ctrcode,
    wh_nr,
    c173_create_date,
    c173_pal_dd_goods,
    c173_pal_eu_goods,
    c173_taskstatus,
    c173_gatetypeid,
    extraction_tmsp
   FROM ldl_data_production_etl.t173_gintasks_1 AS gt
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY LEFT(ctrcode, 2), c173_taskid ORDER BY extraction_tmsp IS NULL DESC,
         extraction_tmsp DESC)) = 1) AS GT
 WHERE c173_taskstatus = 99
  AND c173_gatetypeid IS NOT NULL
 GROUP BY int_company_natural_key,
  int_company_key_type_cd,
  stat_type_cd,
  stat_dt,
  bus_dt,
  curr_stat_fg,
  stat_val,
  curr_cd,
  stat_cnt,
  stat_meas,
  uom_cd,
  source_system);