
--Workaround has been applied for unit_cnt and qty fields. if we have multiple weight_based_fg for the item we try to find out using the stock information to distinguish whether the stock weight based or not. 


--Based on decimal stock we find out weight_based_fg as a workaround


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, country_org_cd, inv_type_cd, int_org_type_cd,
 inv_dt, wawi_item_sid, uom_cd, country_org_key_type_cd, int_org_key_type_cd, int_org_natural_key,
 country_org_natural_key, inv_qty, inv_result_status_type_id, inv_diff_qty, inv_prod_reason_id, inv_diff_sales_unit_cnt
 , inv_key_type_cd, inv_natural_key, inv_sales_unit_cnt)
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
  'PART' AS inv_type_cd,
  'STORE' AS int_org_type_cd,
  CAST(src.c438_inventorydate AS DATE) AS inv_dt,
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
  'COUNTRY' AS country_org_key_type_cd,
  'STORE' AS int_org_key_type_cd,
    src.ctrcode || '|' || CAST(src.c438_storenr AS STRING) AS int_org_natural_key,
  LEFT(src.ctrcode, 2) AS country_org_natural_key,
   CASE
   WHEN t1.dist_wbf = 1 AND t1.weight_based_fg OR t1.dist_wbf > 1 AND src.decimal_fg = 1
   THEN src.c439_count_stock
   ELSE NULL
   END AS inv_qty,
  src.c439_countflag AS inv_result_status_type_cd,
   CASE
   WHEN t1.dist_wbf = 1 AND t1.weight_based_fg OR t1.dist_wbf > 1 AND src.decimal_fg = 1
   THEN src.c439_count_stock - src.c439_calc_stock
   ELSE NULL
   END AS inv_diff_qty,
   CASE
   WHEN src.c439_add_reason BETWEEN 10 AND 60 OR src.c439_add_reason >= 63
   THEN - 2
   ELSE src.c439_add_reason
   END AS inv_prod_reason_id,
   CASE
   WHEN t1.dist_wbf = 1 AND NOT t1.weight_based_fg OR t1.dist_wbf > 1 AND src.decimal_fg = 0
   THEN src.c439_count_stock - src.c439_calc_stock
   ELSE NULL
   END AS inv_diff_sales_unit_cnt,
  'PART' AS inv_key_type_cd,
      src.ctrcode || '|' || CAST(src.wh_nr AS STRING) || '|' || CAST(src.c438_inv_id AS STRING) AS inv_natural_key,
   CASE
   WHEN t1.dist_wbf = 1 AND NOT t1.weight_based_fg OR t1.dist_wbf > 1 AND src.decimal_fg = 0
   THEN src.c439_count_stock
   ELSE NULL
   END AS inv_sales_unit_cnt
 FROM (SELECT src.ctrcode,
    src.wh_nr,
    src_438.c438_inv_id,
    src_438.c438_inventorydate,
    src_438.c438_storenr,
    src.c439_itemnr,
    src.c439_count_stock,
    src.c439_calc_stock,
    src.c439_add_reason,
    src.c439_countflag,
    src.extraction_tmsp,
     CASE
     WHEN src.c439_count_stock <> CAST(src.c439_count_stock AS BIGNUMERIC) OR src.c439_calc_stock <> CAST(src.c439_calc_stock AS BIGNUMERIC)
       
     THEN 1
     ELSE 0
     END AS decimal_fg
   FROM ${temp_db}.${t_src_input_table} AS src
    INNER JOIN ldl_data_production_etl_process.t_wawi_precore_t438_part_inv_head_wh_snap AS src_438 ON src.ctrcode =
       src_438.ctrcode AND src.wh_nr = src_438.wh_nr AND src.c439_inv_id = src_438.c438_inv_id) AS src
  INNER JOIN (SELECT wik.wawi_item_nat_key_nr,
    wik.wawi_item_sid,
    COUNT(DISTINCT wiv.weight_based_fg) AS dist_wbf,
    ANY_VALUE(wiv.weight_based_fg) AS weight_based_fg
   FROM ldl_data_production_meta.t_wawi_item_key AS wik
    INNER JOIN ldl_data_production_core_rel.t_wawi_item_variant AS wiv ON wiv.dwh_valid_fg AND wik.wawi_item_sid = wiv.wawi_item_sid
         AND wik.dwh_valid_fg AND wik.wawi_item_key_type_cd = 'WAWI'
   GROUP BY wik.wawi_item_sid,
    wik.wawi_item_nat_key_nr) AS t1 ON t1.wawi_item_nat_key_nr = src.ctrcode || '|' || CAST(ROUND(CAST(src.c439_itemnr AS BIGNUMERIC)
      , 0) AS STRING));