
TRUNCATE TABLE ldl_data_production_etl.t_precore_price_group_to_internal_organization;


--'STORE' AS int_org_type_cd,


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_{src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, int_org_type_cd, party_nat_key_nr, close_dt,
 open_dt, int_org_key_type_cd, price_grp_prio, price_grp_key_type_cd, dateto, price_grp_nat_key_nr, datefrom)
(SELECT DISTINCT 'WAWI' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'WAWI' AS source_system,
  CAST(DATE_TRUNC(pg.extraction_tmsp, DAY) AS DATE) AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
   CASE
   WHEN pg.c200_warehouse = 0 AND pg.c200_storenr = 0
   THEN 'COUNTRY'
   WHEN pg.c200_storenr = 0
   THEN 'COMPANY'
   ELSE 'STORE'
   END AS int_org_type_cd,
   CASE
   WHEN pg.c200_warehouse = 0 AND pg.c200_storenr = 0
   THEN pg.ctrcode
   WHEN pg.c200_storenr = 0
   THEN pg.ctrcode || '|' || CAST(ROUND(CAST(pg.c200_warehouse AS BIGNUMERIC), 0) AS STRING)
   ELSE pg.ctrcode || '|' || CAST(ROUND(CAST(pg.c200_storenr AS BIGNUMERIC), 0) AS STRING)
   END AS party_nat_key_nr,
  COALESCE(rer.close_dt, DATE '9999-12-31') AS close_dt,
   CASE
   WHEN pg.c200_warehouse = 0 AND pg.c200_storenr = 0 OR pg.c200_storenr = 0
   THEN DATE('1900-01-01')
   ELSE rer.open_dt
   END AS open_dt,
   CASE
   WHEN pg.c200_warehouse = 0 AND pg.c200_storenr = 0
   THEN 'COUNTRY'
   WHEN pg.c200_storenr = 0
   THEN 'COMPANY'
   ELSE 'STORE'
   END AS int_org_key_type_cd,
  pg.c200_priority AS price_grp_prio,
  'WAWI' AS price_grp_key_type_cd,
  pg.c200_dateto,
    pg.ctrcode || '|' || CAST(ROUND(CAST(pg.c200_groupnr AS BIGNUMERIC), 0) AS STRING) AS price_grp_nat_key_nr,
  pg.c200_datefrom
 FROM ldl_data_production_etl.t_wawi_precore_t200_pricegroup AS pg
  LEFT JOIN ldl_data_production_meta.t_resource_item_key AS rk ON CASE
     WHEN pg.c200_warehouse = 0 AND pg.c200_storenr = 0
     THEN pg.ctrcode
     WHEN pg.c200_storenr = 0
     THEN pg.ctrcode || '|' || CAST(ROUND(CAST(pg.c200_warehouse AS BIGNUMERIC), 0) AS STRING)
     ELSE pg.ctrcode || '|' || CAST(ROUND(CAST(pg.c200_storenr AS BIGNUMERIC), 0) AS STRING)
     END = rk.resource_item_nat_key_nr AND rk.dwh_valid_fg
  LEFT JOIN ldl_data_production_core_rel.t_real_estate AS rer ON rk.resource_item_sid = rer.real_estate_sid AND rer.dwh_valid_fg
   );