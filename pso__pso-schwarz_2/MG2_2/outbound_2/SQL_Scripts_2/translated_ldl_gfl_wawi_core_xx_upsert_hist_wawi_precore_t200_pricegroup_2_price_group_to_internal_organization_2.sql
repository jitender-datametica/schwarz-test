INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd
 , tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename,
 int_org_key_type_cd, int_org_type_cd, party_nat_key_nr, dwh_ending_tmsp, price_grp_key_type_cd, price_grp_nat_key_nr,
 price_grp_prio)
(SELECT DISTINCT 'WAWI' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'WAWI' AS source_system,
  CAST(DATE_TRUNC(extraction_tmsp, DAY) AS DATE) AS extraction_dt,
   0 <> 0 AS `A12185`,
  CAST(0 AS STRING) AS record_id,
  CAST(c200_datefrom AS TIMESTAMP) AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  'STORE' AS int_org_key_type_cd,
  'STORE' AS int_org_type_cd,
    ctrcode || '|' || CAST(ROUND(CAST(c200_storenr AS BIGNUMERIC), 0) AS STRING) AS party_nat_key_nr,
  CAST(c200_dateto AS TIMESTAMP) AS dwh_ending_tmsp,
  'WAWI' AS price_grp_key_type_cd,
    ctrcode || '|' || CAST(ROUND(CAST(c200_groupnr AS BIGNUMERIC), 0) AS STRING) AS price_grp_nat_key_nr,
  c200_priority AS price_grp_prio
 FROM ldl_data_production_etl.t_wawi_precore_t200_pricegroup_2 AS pg
 WHERE c200_lastedited >= CAST('${SRC_START_DATE}' AS DATETIME)
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY price_grp_nat_key_nr, dwh_mapping_tmsp ORDER BY dwh_ending_tmsp IS NULL DESC,
       dwh_ending_tmsp DESC)) = 1);