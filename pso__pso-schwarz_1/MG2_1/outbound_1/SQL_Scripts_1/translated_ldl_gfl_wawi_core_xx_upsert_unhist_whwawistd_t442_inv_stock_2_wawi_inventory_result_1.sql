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
WITH t180 AS (
  SELECT
    src.wawi_instanz_kzl,
    src.wh_nr,
    src.c180_id,
    c180_inventorydate,
    src.c180_storenr,
    src.c180_inv_flag
  FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t180_stinventory_1 AS src
  INNER JOIN ldl_data_production.etl_process.t_wawi_extract_control_1 AS co
    ON co.schema_name = upper('whwawiadm') AND co.table_name = upper('t180_stinventory_1')
  INNER JOIN ldl_data_production.etl_process.t_wawi_extract_control_status_1 AS st
    ON st.schema_name = upper('whwawiadm')
    AND st.table_name = upper('t180_stinventory_1')
    AND ai_graph_name = '${AI_GRAPH_NAME}'
    AND src.wawi_instanz_kzl = st.wawi_instanz_kzl
    AND src.wh_nr = st.wh_nr
    AND src.scn >= IF(co.delta_fg, st.last_scn, CAST('0' AS NUMERIC))
  WHERE
    delete_fg IS NULL
    AND src.c180_inv_flag = CAST('71' /* AND t182.c182_status = 64 Getting all statuses */ AS NUMERIC)
  QUALIFY
    row_number() OVER (
      PARTITION BY src.wawi_instanz_kzl, src.wh_nr, c180_id
      ORDER BY IF(extraction_tmsp IS NULL, 0, 1), extraction_tmsp DESC
    ) = CAST('1' AS NUMERIC)
), t182 AS (
  SELECT
    src.wawi_instanz_kzl,
    src.wh_nr,
    src.c182_id,
    src.c182_status
  FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t182_sic_inventory_1 AS src
  INNER JOIN ldl_data_production.etl_process.t_wawi_extract_control_1 AS co
    ON co.schema_name = upper('whwawiadm')
    AND co.table_name = upper('t182_sic_inventory_1')
  INNER JOIN ldl_data_production.etl_process.t_wawi_extract_control_status_1 AS st
    ON st.schema_name = upper('whwawiadm')
    AND st.table_name = upper('t182_sic_inventory_1')
    AND ai_graph_name = '${AI_GRAPH_NAME}'
    AND src.wawi_instanz_kzl = st.wawi_instanz_kzl
    AND src.wh_nr = st.wh_nr
    AND src.scn >= IF(co.delta_fg, st.last_scn, CAST('0' AS NUMERIC))
  WHERE
    delete_fg IS NULL
  QUALIFY
    row_number() OVER (
      PARTITION BY src.wawi_instanz_kzl, src.wh_nr, c182_id
      ORDER BY IF(extraction_tmsp IS NULL, 0, 1), extraction_tmsp DESC
    ) = CAST('1' AS NUMERIC)
)
SELECT
  'FULL' AS inv_key_type_cd,
  CONCAT(o.country_org_cd, '|', src.wh_nr, '|', src.c180_id) AS inv_natural_key,
  wawi_itm.wawi_item_sid,
  src.c442_date AS inv_dt,
  'FULL' AS inv_type_cd,
  'STORE' AS int_org_key_type_cd,
  CONCAT(o.country_org_cd, '|', src.c442_storenr) AS int_org_natural_key,
  'STORE' AS int_org_type_cd,
  o.country_org_cd AS country_org_cd,
  o.country_org_cd AS country_org_natural_key,
  'COUNTRY_1' AS country_org_key_type_cd,
  CASE
    WHEN wawi_itm.dist_wbf = CAST('1' AS NUMERIC)
    AND wawi_itm.weight_based_fg = CAST('0' AS NUMERIC)
    THEN src.c442_inv_stock
    WHEN wawi_itm.dist_wbf > CAST('1' AS NUMERIC)
    AND src.decimal_fg = CAST('0' AS NUMERIC)
    THEN src.c442_inv_stock
    ELSE NULL
  END AS inv_sales_unit_cnt,
  CASE
    WHEN wawi_itm.dist_wbf = CAST('1' AS NUMERIC)
    AND wawi_itm.weight_based_fg = CAST('0' AS NUMERIC)
    THEN src.c442_diff
    WHEN wawi_itm.dist_wbf > CAST('1' AS NUMERIC)
    AND src.decimal_fg = CAST('0' AS NUMERIC)
    THEN src.c442_diff
    ELSE NULL
  END AS inv_diff_sales_unit_cnt,
  CASE
    WHEN wawi_itm.dist_wbf = CAST('1' AS NUMERIC)
    AND wawi_itm.weight_based_fg = CAST('1' AS NUMERIC)
    THEN src.c442_inv_stock
    WHEN wawi_itm.dist_wbf > CAST('1' AS NUMERIC)
    AND src.decimal_fg = CAST('1' AS NUMERIC)
    THEN src.c442_inv_stock
    ELSE NULL
  END AS inv_qty,
  CASE
    WHEN wawi_itm.dist_wbf = CAST('1' AS NUMERIC)
    AND wawi_itm.weight_based_fg = CAST('1' AS NUMERIC)
    THEN src.c442_diff
    WHEN wawi_itm.dist_wbf > CAST('1' AS NUMERIC)
    AND src.decimal_fg = CAST('1' AS NUMERIC)
    THEN src.c442_diff
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
    AND o.country_org_cd <> 'US'
    THEN 'KG'
    WHEN (
      wawi_itm.dist_wbf = CAST('1' AS NUMERIC)
      AND wawi_itm.weight_based_fg = CAST('1' AS NUMERIC)
      OR wawi_itm.dist_wbf > CAST('1' AS NUMERIC)
      AND src.decimal_fg = CAST('1' AS NUMERIC)
    )
    AND o.country_org_cd = 'US'
    THEN 'LB'
    ELSE NULL
  END AS uom_cd,
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
    left(src_0.wawi_instanz_kzl, 2) AS wawi_instanz_kzl,
    f_inv.wh_nr,
    f_inv.c180_id,
    src_0.c442_date,
    src_0.c442_storenr,
    src_0.c442_itemnr,
    src_0.c442_inv_stock,
    src_0.c442_diff,
    src_0.extraction_tmsp,
    CASE
      WHEN src_0.c442_inv_stock <> CAST(src_0.c442_inv_stock AS BIGNUMERIC)
      OR src_0.c442_diff <> CAST(src_0.c442_diff AS BIGNUMERIC)
      THEN CAST('1' AS NUMERIC)
      ELSE CAST('0' AS NUMERIC)
    END AS decimal_fg
  FROM (
    SELECT
      t442.wawi_instanz_kzl,
      c442_storenr,
      c442_date,
      c442_itemnr,
      c442_inv_stock,
      c442_diff,
      extraction_tmsp
    FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawistd.t442_inv_stock_1 AS t442
    INNER JOIN ldl_data_production.etl_process.t_wawi_extract_control_1 AS co
      ON co.schema_name = upper('whwawistd') AND co.table_name = upper('t442_inv_stock_1')
    INNER JOIN ldl_data_production.etl_process.t_wawi_extract_control_status_1 AS st
      ON st.schema_name = upper('whwawistd')
      AND st.table_name = upper('t442_inv_stock_1')
      AND ai_graph_name = '${AI_GRAPH_NAME}'
      AND t442.wawi_instanz_kzl = st.wawi_instanz_kzl
      AND t442.wh_nr = st.wh_nr
      AND t442.scn >= IF(co.delta_fg, st.last_scn, CAST('0' AS NUMERIC))
    WHERE
      delete_fg IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY t442.wawi_instanz_kzl, t442.c442_storenr, c442_date, c442_itemnr
        ORDER BY IF(t442.extraction_tmsp IS NULL, 0, 1), t442.extraction_tmsp DESC
      ) = CAST('1' AS NUMERIC)
  ) AS src_0
  INNER JOIN (
    SELECT
      t180.*
    FROM t180
    INNER JOIN t182
      ON t180.wawi_instanz_kzl = t182.wawi_instanz_kzl
      AND t180.wh_nr = t182.wh_nr
      AND t180.c180_id = t182.c182_id
  ) AS f_inv
    ON src_0.wawi_instanz_kzl = f_inv.wawi_instanz_kzl
    AND /* AND src.wh_nr = f_inv.wh_nr excluded due to wh can be updated */ src_0.c442_storenr = f_inv.c180_storenr
    AND src_0.c442_date = f_inv.c180_inventorydate
) AS src
INNER JOIN ldl_data_production.meta.t_party_key_1 AS k
  ON src.wawi_instanz_kzl = k.party_nat_key_nr
  AND k.dwh_valid_fg
  AND k.party_key_type_cd = 'COUNTRY_1'
INNER JOIN ldl_data_production.core_rel.t_internal_organization_1 AS o
  ON k.party_sid = o.int_org_sid AND o.dwh_valid_fg
INNER JOIN (
  SELECT
    wik.wawi_item_nat_key_nr,
    wik.wawi_item_sid,
    CAST(count(DISTINCT wiv.weight_based_fg) AS BIGNUMERIC) AS dist_wbf,
    ANY_VALUE(wiv.weight_based_fg) AS weight_based_fg
  FROM ldl_data_production.meta.t_wawi_item_key_1 AS wik
  INNER JOIN ldl_data_production.core_rel.t_wawi_item_variant_1 AS wiv
    ON wiv.dwh_valid_fg
    AND wiv.wawi_item_sid = wik.wawi_item_sid
    AND wik.dwh_valid_fg
    AND wik.wawi_item_key_type_cd = 'WAWI'
  GROUP BY
    1,
    2
) AS wawi_itm
  ON wawi_itm.wawi_item_nat_key_nr = CONCAT(o.country_org_cd, '|', CAST(src.c442_itemnr AS STRING));