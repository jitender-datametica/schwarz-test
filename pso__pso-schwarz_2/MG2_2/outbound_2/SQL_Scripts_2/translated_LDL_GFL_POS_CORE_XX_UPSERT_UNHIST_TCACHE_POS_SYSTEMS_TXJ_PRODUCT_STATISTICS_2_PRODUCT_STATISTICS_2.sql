-- Enrich with currency code and country_org_cd from int org and aggregate


-- key2
 -- key4
 -- key3
 -- key1
 INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (dwh_node_cd,
 tf_error_fg, dwh_load_id, deleted_fg, record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp,
 country_org_sid, country_org_cd, curr_cd, real_estate_sid, bus_dt, store_sid, uom_cd, turnover_gross_val, sold_qty,
 cancel_cnt, returned_cnt, curr_stat_fg, cancel_qty, sales_variant_sid, returned_qty, stat_dt, returned_gross_val,
 cancel_gross_val, last_sale_tmsp, sold_cnt)
(SELECT MIN('TXJ') AS dwh_node_cd,
  MIN(0) AS tf_error_fg,
  MIN('${LOAD_ID}') AS dwh_load_id,
   MIN(0) <> 0 AS deleted_fg,
  CAST(MIN(0) AS STRING) AS record_id,
  MIN('t_${SRC_INPUT_TABLE}') AS filename,
  MIN('TXJ') AS source_system,
  MIN(CURRENT_DATE) AS extraction_dt,
  MIN(CURRENT_TIMESTAMP()) AS dwh_mapping_tmsp,
  MIN(src.country_org_sid) AS country_org_sid,
  MIN(org.country_org_cd) AS country_org_cd,
  MIN(org.curr_cd) AS curr_cd,
  src.real_estate_sid,
  src.bus_dt,
  src.store_sid,
  MIN(src.uom_cd) AS uom_cd,
  SUM(src.turnover_gross_val) AS turnover_gross_val,
  MIN(src.sold_qty) AS sold_qty,
  MIN(src.cancel_cnt) AS cancel_cnt,
  MIN(src.returned_cnt) AS returned_cnt,
  MIN(src.curr_stat_fg) AS curr_stat_fg,
  MIN(src.cancel_qty) AS cancel_qty,
  src.sales_variant_sid,
  MIN(src.returned_qty) AS returned_qty,
  MIN(src.stat_dt) AS stat_dt,
  SUM(src.returned_gross_val) AS returned_gross_val,
  SUM(src.returned_gross_val) AS returned_gross_val26,
  MAX(src.last_sale_tmsp) AS last_sale_tmsp,
  MIN(src.sold_cnt) AS sold_cnt
 FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}
   AS src
  LEFT JOIN ldl_data_production_core_rel.t_internal_organization_2 AS org ON src.country_org_sid = org.int_org_sid AND src
    .bus_dt BETWEEN CAST(org.dwh_valid_from_tmsp AS DATE) AND (CAST(org.dwh_valid_to_tmsp AS DATE))
 GROUP BY src.store_sid,
  src.real_estate_sid,
  src.bus_dt,
  src.sales_variant_sid);