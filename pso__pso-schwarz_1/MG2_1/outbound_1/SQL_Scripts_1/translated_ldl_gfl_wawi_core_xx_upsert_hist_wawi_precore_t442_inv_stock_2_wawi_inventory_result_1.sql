
--AND src.wh_nr = f_inv.wh_nr excluded due to wh can be updated


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, country_org_cd, inv_type_cd, int_org_type_cd,
 inv_dt, wawi_item_sid, uom_cd, country_org_key_type_cd, int_org_key_type_cd, int_org_natural_key,
 country_org_natural_key, inv_key_type_cd, inv_natural_key, inv_qty, inv_diff_qty, inv_diff_sales_unit_cnt,
 inv_sales_unit_cnt)
(SELECT 'WAWI_WH' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'WAWI_WH' AS source_system,
  CAST(src.extraction_tmsp AS DATE) AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  LEFT(src.ctrcode, 2) AS country_org_cd,
  'FULL' AS inv_type_cd,
  'STORE' AS int_org_type_cd,
  CAST(src.c442_date AS DATE) AS inv_dt,
  t1.wawi_item_sid,
   CASE
   WHEN t1.dist_wbf = 1 AND NOT t1.weight_based_fg OR t1.dist_wbf > 1 AND src.decimal_fg = 0
   THEN NULL
   WHEN (t1.dist_wbf = 1 AND t1.weight_based_fg OR t1.dist_wbf > 1 AND src.decimal_fg = 1) AND src.ctrcode <> 'US'
   THEN 'KG'
   WHEN (t1.dist_wbf = 1 AND t1.weight_based_fg OR t1.dist_wbf > 1 AND src.decimal_fg = 1) AND src.ctrcode = 'US'
   THEN 'LB'
   ELSE NULL
   END AS uom_cd,
  'COUNTRY_1' AS country_org_key_type_cd,
  'STORE' AS int_org_key_type_cd,
    src.ctrcode || '|' || CAST(src.c442_storenr AS STRING) AS int_org_natural_key,
  LEFT(src.ctrcode, 2) AS country_org_natural_key,
  'FULL' AS inv_key_type_cd,
      src.ctrcode || '|' || CAST(src.wh_nr AS STRING) || '|' || CAST(src.c180_id AS STRING) AS inv_natural_key,
   CASE
   WHEN t1.dist_wbf = 1 AND t1.weight_based_fg OR t1.dist_wbf > 1 AND src.decimal_fg = 1
   THEN src.c442_inv_stock
   ELSE NULL
   END AS inv_qty,
   CASE
   WHEN t1.dist_wbf = 1 AND t1.weight_based_fg OR t1.dist_wbf > 1 AND src.decimal_fg = 1
   THEN src.c442_diff
   ELSE NULL
   END AS inv_diff_qty,
   CASE
   WHEN t1.dist_wbf = 1 AND NOT t1.weight_based_fg OR t1.dist_wbf > 1 AND src.decimal_fg = 0
   THEN src.c442_diff
   ELSE NULL
   END AS inv_diff_sales_unit_cnt,
   CASE
   WHEN t1.dist_wbf = 1 AND NOT t1.weight_based_fg OR t1.dist_wbf > 1 AND src.decimal_fg = 0
   THEN src.c442_inv_stock
   ELSE NULL
   END AS inv_sales_unit_cnt
 FROM (SELECT src.ctrcode,
    f_inv.wh_nr,
    f_inv.c180_id,
    src.c442_date,
    src.c442_storenr,
    src.c442_itemnr,
    src.c442_inv_stock,
    src.c442_diff,
    src.extraction_tmsp,
     CASE
     WHEN src.c442_inv_stock <> CAST(src.c442_inv_stock AS BIGNUMERIC) OR src.c442_diff <> CAST(src.c442_diff AS BIGNUMERIC)
       
     THEN 1
     ELSE 0
     END AS decimal_fg
   FROM ${temp_db}.${t_src_input_table} AS src
    INNER JOIN ${temp_db}.t_wawi_full_inventory_1 AS f_inv ON src.ctrcode = f_inv.ctrcode AND src.c442_storenr = f_inv.c180_storenr
        AND src.c442_date = f_inv.c180_inventorydate) AS src
  INNER JOIN (SELECT wik.wawi_item_nat_key_nr,
    wik.wawi_item_sid,
    COUNT(DISTINCT wiv.weight_based_fg) AS dist_wbf,
    ANY_VALUE(wiv.weight_based_fg) AS weight_based_fg
   FROM ldl_data_production_meta.t_wawi_item_key_1 AS wik
    INNER JOIN ldl_data_production_core_rel.t_wawi_item_variant_1 AS wiv ON wiv.dwh_valid_fg AND wik.wawi_item_sid = wiv.wawi_item_sid
         AND wik.dwh_valid_fg AND wik.wawi_item_key_type_cd = 'WAWI'
   GROUP BY wik.wawi_item_sid,
    wik.wawi_item_nat_key_nr) AS t1_1 ON t1.wawi_item_nat_key_nr = src.ctrcode || '|' || CAST(ROUND(SAFE_CAST(src.c442_itemnr AS BIGNUMERIC), 0) AS STRING)
    );