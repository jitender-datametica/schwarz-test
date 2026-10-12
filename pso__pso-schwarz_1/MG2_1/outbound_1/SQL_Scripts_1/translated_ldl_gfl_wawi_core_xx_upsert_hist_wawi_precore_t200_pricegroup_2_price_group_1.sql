INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  country_org_key_type_cd,
  party_nat_key_nr,
  price_grp_key_type_cd,
  price_grp_nat_key_nr,
  price_grp_nr,
  price_grp_name,
  dwh_ending_tmsp,
  source_system,
  extraction_dt,
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename,
  dwh_node_cd,
  dwh_load_id
)
SELECT DISTINCT
  'COUNTRY_1' AS country_org_key_type_cd,
  pg.ctrcode AS party_nat_key_nr,
  'WAWI' AS price_grp_key_type_cd,
  CONCAT(pg.ctrcode, '|', CAST(CAST(pg.c200_groupnr AS NUMERIC) AS STRING)) AS price_grp_nat_key_nr,
  pg.c200_groupnr AS price_grp_nr,
  pg.c200_groupdesc AS price_grp_name,
  DATETIME_ADD(DATETIME_SUB(pg.c200_dateto, INTERVAL '1' NANOSECOND), INTERVAL '1' DAY) AS dwh_ending_tmsp,
  'WAWI' AS source_system,
  datetime_trunc(pg.extraction_tmsp, DAY) AS extraction_dt,
  pg.c200_datefrom AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${SRC_INPUT_TABLE}' AS filename,
  'WAWI' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM etl.t_wawi_precore_t200_pricegroup_1 AS pg
WHERE
  pg.c200_lastedited >= '${SRC_START_DATE}'
QUALIFY
  row_number() OVER (
    PARTITION BY price_grp_nat_key_nr, dwh_mapping_tmsp
    ORDER BY IF(dwh_ending_tmsp IS NULL, 0, 1), dwh_ending_tmsp DESC
  ) = 1;