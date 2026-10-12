INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd
 , tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, uom_cd,
 curr_cd, inv_stat_cnt, inv_stat_meas, inv_sid, inv_stat_val, inv_stat_pct, inv_stat_qty, inv_stat_type_cd)
(SELECT 'WAWI_WH' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'WAWI_WH' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  CAST(NULL AS STRING) AS uom_cd,
  io.curr_cd,
  NULL AS inv_stat_cnt,
  NULL AS inv_stat_meas,
  inv.inv_sid,
   CASE
   WHEN stat.inv_stat_type_cd = 'TURNOVER_NET'
   THEN inv.c182_turnoverval_net
   WHEN stat.inv_stat_type_cd = 'DIFF_NET'
   THEN inv.c182_diffval_net
   WHEN stat.inv_stat_type_cd = 'INVENTORY_NET'
   THEN inv.c182_inventoryval_net
   ELSE NULL
   END AS stat_val,
  NULL AS inv_stat_pct,
  NULL AS inv_stat_qty,
  stat.inv_stat_type_cd
 FROM ldl_data_production_etl.t_wawi_full_inventory AS inv
  INNER JOIN (SELECT 'TURNOVER_NET' AS inv_stat_type_cd
    UNION ALL
    SELECT 'DIFF_NET' AS inv_stat_type_cd
    UNION ALL
    SELECT 'INVENTORY_NET' AS inv_stat_type_cd) AS stat ON TRUE
  LEFT JOIN ldl_data_production_core_rel.t_internal_organization AS io ON inv.country_org_sid = io.int_org_sid AND CAST(inv.extraction_tmsp AS TIMESTAMP)
    BETWEEN io.dwh_valid_from_tmsp AND io.dwh_valid_to_tmsp);