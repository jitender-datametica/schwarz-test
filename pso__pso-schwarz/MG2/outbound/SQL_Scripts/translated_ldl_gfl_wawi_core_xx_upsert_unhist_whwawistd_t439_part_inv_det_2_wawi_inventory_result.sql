INSERT INTO ldl_data_production.${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  inv_key_type_cd,
  inv_natural_key,
  wawi_item_sid,
  inv_dt,
  inv_type_cd,
  int_org_key_type_cd,
  int_org_natural_key,
  int_org_type_cd,
  country_org_cd,
  country_org_natural_key,
  country_org_key_type_cd,
  inv_sales_unit_cnt,
  inv_diff_sales_unit_cnt,
  inv_qty,
  inv_diff_qty,
  uom_cd,
  inv_prod_reason_id,
  inv_result_status_type_id,
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
WITH t439 AS (
  SELECT
    src.*
  FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawistd.t439_part_inv_det AS src
  INNER JOIN ldl_data_production.etl_process.t_wawi_extract_control AS co
    ON co.schema_name = upper('whwawistd')
    AND co.table_name = upper('t439_part_inv_det')
  INNER JOIN ldl_data_production.etl_process.t_wawi_extract_control_status AS st
    ON st.schema_name = upper('whwawistd')
    AND st.table_name = upper('t439_part_inv_det')
    AND ai_graph_name = '${AI_GRAPH_NAME}'
    AND src.wawi_instanz_kzl = st.wawi_instanz_kzl
    AND src.wh_nr = st.wh_nr
    AND src.scn >= IF(co.delta_fg, st.last_scn, CAST('0' AS NUMERIC))
  WHERE
    delete_fg IS NULL
  QUALIFY
    row_number() OVER (
      PARTITION BY src.wawi_instanz_kzl, src.wh_nr, c439_inv_id
      ORDER BY IF(extraction_tmsp IS NULL, 0, 1), extraction_tmsp DESC
    ) = CAST('1' AS NUMERIC)
), t438 AS (
  SELECT
    src.*
  FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawistd.t438_part_inv_head AS src
  INNER JOIN ldl_data_production.etl_process.t_wawi_extract_control AS co
    ON co.schema_name = upper('whwawistd')
    AND co.table_name = upper('t438_part_inv_head')
  INNER JOIN ldl_data_production.etl_process.t_wawi_extract_control_status AS st
    ON st.schema_name = upper('whwawistd')
    AND st.table_name = upper('t438_part_inv_head')
    AND ai_graph_name = '${AI_GRAPH_NAME}'
    AND src.wawi_instanz_kzl = st.wawi_instanz_kzl
    AND src.wh_nr = st.wh_nr
    AND src.scn >= IF(co.delta_fg, st.last_scn, CAST('0' AS NUMERIC))
  WHERE
    delete_fg IS NULL
  QUALIFY
    row_number() OVER (
      PARTITION BY src.wawi_instanz_kzl, src.wh_nr, c438_inv_id
      ORDER BY IF(extraction_tmsp IS NULL, 0, 1), extraction_tmsp DESC
    ) = CAST('1' AS NUMERIC)
)
SELECT
  'PART' AS inv_key_type_cd,
  CONCAT(o.country_org_cd, '|', src.wh_nr, '|', src.c438_inv_id) AS inv_natural_key,
  wawi_itm.wawi_item_sid,
  src.c438_inventorydate AS inv_dt,
  'PART' AS inv_type_cd,
  'STORE' AS int_org_key_type_cd,
  CONCAT(o.country_org_cd, '|', src.c438_storenr) AS int_org_natural_key,
  'STORE' AS int_org_type_cd,
  o.country_org_cd AS country_org_cd,
  o.country_org_cd AS country_org_natural_key,
  'COUNTRY' AS country_org_key_type_cd,
  CASE
    WHEN wawi_itm.dist_wbf = CAST('1' AS NUMERIC)
    AND wawi_itm.weight_based_fg = CAST('0' AS NUMERIC)
    THEN src.c439_count_stock
    WHEN wawi_itm.dist_wbf > CAST('1' AS NUMERIC)
    AND src.decimal_fg = CAST('0' AS NUMERIC)
    THEN src.c439_count_stock
    ELSE NULL
  END AS inv_sales_unit_cnt, /* Workaround has been applied for unit_cnt and qty fields. if we have multiple weight_based_fg for the item we try to find out using the stock information to distinguish whether the stock weight based or not. */
  CASE
    WHEN wawi_itm.dist_wbf = CAST('1' AS NUMERIC)
    AND wawi_itm.weight_based_fg = CAST('0' AS NUMERIC)
    THEN src.c439_count_stock - src.c439_calc_stock
    WHEN wawi_itm.dist_wbf > CAST('1' AS NUMERIC)
    AND src.decimal_fg = CAST('0' AS NUMERIC)
    THEN src.c439_count_stock - src.c439_calc_stock
    ELSE NULL
  END AS inv_diff_sales_unit_cnt,
  CASE
    WHEN wawi_itm.dist_wbf = CAST('1' AS NUMERIC)
    AND wawi_itm.weight_based_fg = CAST('1' AS NUMERIC)
    THEN src.c439_count_stock
    WHEN wawi_itm.dist_wbf > CAST('1' AS NUMERIC)
    AND src.decimal_fg = CAST('1' AS NUMERIC)
    THEN src.c439_count_stock
    ELSE NULL
  END AS inv_qty,
  CASE
    WHEN wawi_itm.dist_wbf = CAST('1' AS NUMERIC)
    AND wawi_itm.weight_based_fg = CAST('1' AS NUMERIC)
    THEN src.c439_count_stock - src.c439_calc_stock
    WHEN wawi_itm.dist_wbf > CAST('1' AS NUMERIC)
    AND src.decimal_fg = CAST('1' AS NUMERIC)
    THEN src.c439_count_stock - src.c439_calc_stock
    ELSE NULL
  END AS inv_diff_qty,
  CASE
    WHEN wawi_itm.dist_wbf = CAST('1' AS NUMERIC)
    AND wawi_itm.weight_based_fg = CAST('0' AS NUMERIC)
    OR wawi_itm.dist_wbf > CAST('1' AS NUMERIC)
    AND src.decimal_fg = CAST('0' AS NUMERIC)
    THEN NULL
    WHEN (
      wawi_itm.dist_wbf = CAST('1' AS NUMERIC)
      AND wawi_itm.weight_based_fg = CAST('1' AS NUMERIC)
      OR wawi_itm.dist_wbf > CAST('1' AS NUMERIC)
      AND src.decimal_fg = CAST('1' AS NUMERIC)
    )
    AND src.wawi_instanz_kzl <> 'US'
    THEN 'KG'
    WHEN (
      wawi_itm.dist_wbf = CAST('1' AS NUMERIC)
      AND wawi_itm.weight_based_fg = CAST('1' AS NUMERIC)
      OR wawi_itm.dist_wbf > CAST('1' AS NUMERIC)
      AND src.decimal_fg = CAST('1' AS NUMERIC)
    )
    AND src.wawi_instanz_kzl = 'US'
    THEN 'LB'
    ELSE NULL
  END AS uom_cd,
  CASE
    WHEN src.c439_add_reason BETWEEN CAST('10' AS NUMERIC) AND CAST('60' AS NUMERIC)
    OR src.c439_add_reason >= CAST('63' AS NUMERIC)
    THEN -CAST('2' AS NUMERIC)
    ELSE src.c439_add_reason
  END AS inv_prod_reason_id,
  src.c439_countflag AS inv_result_status_type_cd,
  'WAWI_WH' AS source_system,
  src.extraction_tmsp AS extraction_dt,
  current_timestamp() AS dwh_mapping_tmsp,
  CAST('0' AS NUMERIC) AS tf_error_fg,
  CAST('0' AS NUMERIC) AS deleted_fg,
  CAST('0' AS NUMERIC) AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI_WH' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM (
  SELECT
    src_0.wawi_instanz_kzl,
    src_0.wh_nr,
    src_438.c438_inv_id,
    src_438.c438_inventorydate,
    src_438.c438_storenr,
    src_0.c439_itemnr,
    src_0.c439_count_stock,
    src_0.c439_calc_stock,
    src_0.c439_add_reason,
    src_0.c439_countflag,
    src_0.extraction_tmsp,
    CASE
      WHEN src_0.c439_count_stock <> CAST(src_0.c439_count_stock AS BIGNUMERIC)
      OR src_0.c439_calc_stock <> CAST(src_0.c439_calc_stock AS BIGNUMERIC)
      THEN CAST('1' AS NUMERIC)
      ELSE CAST('0' AS NUMERIC)
    END AS decimal_fg
  FROM t439 AS src_0
  INNER JOIN t438 AS src_438
    ON src_438.wawi_instanz_kzl = src_0.wawi_instanz_kzl
    AND src_438.wh_nr = src_0.wh_nr
    AND src_438.c438_inv_id = src_0.c439_inv_id
) AS src
INNER JOIN ldl_data_production.meta.t_party_key AS k
  ON left(src.wawi_instanz_kzl, 2) = k.party_nat_key_nr
  AND k.dwh_valid_fg
  AND k.party_key_type_cd = 'COUNTRY'
INNER JOIN ldl_data_production.core_rel.t_internal_organization AS o
  ON k.party_sid = o.int_org_sid AND o.dwh_valid_fg
INNER JOIN (
  SELECT
    wik.wawi_item_nat_key_nr,
    wik.wawi_item_sid,
    CAST(count(DISTINCT wiv.weight_based_fg) AS BIGNUMERIC) AS dist_wbf,
    ANY_VALUE(wiv.weight_based_fg) AS weight_based_fg
  FROM ldl_data_production.meta.t_wawi_item_key AS wik
  INNER JOIN ldl_data_production.core_rel.t_wawi_item_variant AS wiv
    ON wiv.dwh_valid_fg
    AND wiv.wawi_item_sid = wik.wawi_item_sid
    AND wik.dwh_valid_fg
    AND wik.wawi_item_key_type_cd = 'WAWI'
  GROUP BY
    1,
    2
) AS wawi_itm
  ON wawi_itm.wawi_item_nat_key_nr = CONCAT(o.country_org_cd, '|', CAST(CAST(src.c439_itemnr AS BIGNUMERIC) AS STRING));