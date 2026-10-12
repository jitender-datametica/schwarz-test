INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  int_org_key_type_cd,
  party_nat_key_nr,
  price_grp_key_type_cd,
  price_grp_nat_key_nr,
  int_org_type_cd,
  price_grp_prio,
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
  CASE
    WHEN c200_storenr = 0
    THEN 'COUNTRY_1'
    WHEN c200_storenr = c200_warehouse
    THEN 'COMPANY'
    ELSE 'STORE'
  END AS int_org_key_type_cd,
  CASE
    WHEN c200_storenr = 0
    THEN left(pg.wawi_instanz_kzl, 2)
    WHEN c200_storenr = c200_warehouse
    THEN CONCAT(
      left(pg.wawi_instanz_kzl, 2),
      '|',
      CAST(CAST(pg.c200_warehouse AS NUMERIC) AS STRING)
    )
    ELSE CONCAT(left(pg.wawi_instanz_kzl, 2), '|', CAST(CAST(pg.c200_storenr AS NUMERIC) AS STRING))
  END AS party_nat_key_nr,
  'WAWI' AS price_grp_key_type_cd,
  CONCAT(left(pg.wawi_instanz_kzl, 2), '|', CAST(CAST(pg.c200_groupnr AS NUMERIC) AS STRING)) AS price_grp_nat_key_nr,
  CASE
    WHEN c200_storenr = 0 OR c200_storenr = c200_warehouse
    THEN 'COMPANY'
    ELSE 'STORE'
  END AS int_org_type_cd,
  c200_priority AS price_grp_prio,
  c200_dateto AS dwh_ending_tmsp,
  'WAWI' AS source_system,
  datetime_trunc(extraction_tmsp, DAY) AS extraction_dt,
  c200_datefrom AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${SRC_INPUT_TABLE}' AS filename,
  'WAWI' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t200_pricegroup_1 AS pg
LEFT OUTER JOIN meta.t_resource_item_key_1 AS rk
  ON CASE
    WHEN c200_storenr = 0
    THEN left(pg.wawi_instanz_kzl, 2)
    WHEN c200_storenr = c200_warehouse
    THEN CONCAT(
      left(pg.wawi_instanz_kzl, 2),
      '|',
      CAST(CAST(pg.c200_warehouse AS NUMERIC) AS STRING)
    )
    ELSE CONCAT(left(pg.wawi_instanz_kzl, 2), '|', CAST(CAST(pg.c200_storenr AS NUMERIC) AS STRING))
  END = rk.resource_item_nat_key_nr
  AND rk.dwh_valid_fg
LEFT OUTER JOIN core_rel.t_real_estate_1 AS rer
  ON rk.resource_item_sid = rer.real_estate_sid AND rer.dwh_valid_fg
WHERE
  c200_lastedited >= '${SRC_START_DATE}'
  AND pg.c200_datefrom BETWEEN CASE
    WHEN c200_storenr = 0 OR c200_storenr = c200_warehouse
    THEN CAST('1900-01-01' AS DATE)
    ELSE rer.open_dt
  END AND coalesce(rer.close_dt, CAST('9999-12-31' AS DATE))
QUALIFY
  row_number() OVER (
    PARTITION BY party_nat_key_nr, price_grp_nat_key_nr, dwh_mapping_tmsp
    ORDER BY IF(dwh_ending_tmsp IS NULL, 0, 1), dwh_ending_tmsp DESC
  ) = 1;