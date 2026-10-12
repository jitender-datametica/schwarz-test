INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  prod_variant_sid,
  price_grp_sid,
  sales_gross_price,
  curr_cd,
  price_reason_cd,
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
SELECT
  prod_variant_sid, /* FRAMEWORK AND TECHNICAL COLUMNS */
  price_grp_sid,
  p.c201_price AS sales_gross_price,
  org.curr_cd AS curr_cd,
  p.c201_reason_id AS price_reason_cd,
  p.c201_dateto AS dwh_ending_tmsp,
  'WAWI' AS source_system,
  p.extraction_tmsp AS extraction_dt,
  p.c201_datefrom AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  'wawi_precore_t201_itemprices_hq' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t201_itemprices AS p
INNER JOIN meta.t_party_key AS k
  ON party_key_type_cd = 'COUNTRY'
  AND party_nat_key_nr = left(p.wawi_instanz_kzl, 2)
  AND k.dwh_valid_fg
INNER JOIN core_rel.t_internal_organization AS org
  ON int_org_sid = k.party_sid AND org.dwh_valid_fg
INNER JOIN meta.t_product_variant_key AS kv
  ON prod_variant_key_type_cd = 'LOG'
  AND prod_variant_nat_key_nr = CONCAT(
    left(p.wawi_instanz_kzl, 2),
    '|',
    CAST(round(
      CAST(substr(p.c201_itemno, 1, CAST(length(p.c201_itemno) - 4 AS INT64)) AS NUMERIC),
      0
    ) AS STRING),
    '|',
    CAST(round(CAST(right(CAST(p.c201_itemno AS STRING), 4) AS NUMERIC), 0) AS STRING)
  )
  AND kv.dwh_valid_fg
INNER JOIN meta.t_price_group_key AS pgk
  ON price_grp_key_type_cd = 'WAWI'
  AND price_grp_nat_key_nr = CONCAT(left(p.wawi_instanz_kzl, 2), '|', CAST(CAST(p.c201_groupnr AS NUMERIC) AS STRING))
  AND k.dwh_valid_fg
WHERE
  NOT p.c201_price IS NULL
  AND c201_lastedited >= '${SRC_START_DATE}'
  AND c201_dateto > c201_datefrom /* to address dq issues */
QUALIFY
  row_number() OVER (
    PARTITION BY prod_variant_sid, p.c201_groupnr, dwh_mapping_tmsp
    ORDER BY IF(round(CAST(right(CAST(p.c201_itemno AS STRING), 4) AS NUMERIC), 0) IS NULL, 0, 1), round(CAST(right(CAST(p.c201_itemno AS STRING), 4) AS NUMERIC), 0) DESC
  ) = 1;