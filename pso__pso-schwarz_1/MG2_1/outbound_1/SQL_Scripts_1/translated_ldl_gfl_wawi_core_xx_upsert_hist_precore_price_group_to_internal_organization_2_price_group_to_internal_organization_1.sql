
-- 


-- 


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, int_org_sid, int_org_type_cd, dwh_ending_tmsp,
 price_grp_prio, price_grp_sid)
(SELECT 'WAWI' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(datefrom AS TIMESTAMP) AS dwh_mapping_tmsp,
  int_org_sid,
  int_org_type_cd,
  CAST(dateto AS TIMESTAMP) AS dwh_ending_tmsp,
  price_grp_prio,
  price_grp_sid
 FROM ldl_data_production_etl.t_precore_price_group_to_internal_organization_1 AS pg
 WHERE CAST(datefrom AS DATE) BETWEEN open_dt AND close_dt
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(int_org_sid AS STRING), CAST(price_grp_sid AS STRING) ORDER BY datefrom
       IS NULL DESC, datefrom DESC)) = 1);