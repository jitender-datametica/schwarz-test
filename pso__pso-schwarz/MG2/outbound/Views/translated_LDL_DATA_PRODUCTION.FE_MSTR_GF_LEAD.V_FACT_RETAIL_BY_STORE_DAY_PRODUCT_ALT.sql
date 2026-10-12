CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_fact_retail_by_store_day_product_alt (cal_dt
OPTIONS(description='The business date to which the meASures are related.'), store_sid
OPTIONS(description='The unique identifier (surrogate key) for the store, which hAS generated the revenue.'), prod_sid
OPTIONS(description='The unique identifier (surrogate key) for the product.'), sales_variant_sid
OPTIONS(description='The unique identifier (surrogate key) for the sales variant of a product.'), country_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the country organization. This is on the one hand related to the country organization which is responsible for the store which hAS sold the product, and on the other hand to the country organization which hAS defined the local properties of the product.'),
country_org_cd
OPTIONS(description='The code of the business country for which the related country organization is responsible. (The business country is not identical to a political country.) This is on the one hand related to the country organization which is responsible for the store which hAS sold the product, and on the other hand to the country organization which hAS defined the local properties of the product.'),
turnover_net_val
OPTIONS(description='The net turnover which wAS generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cASh register.)'),
turnover_gross_val
OPTIONS(description='The gross turnover which wAS generated for this sales variant of the product in the given store on the given day. (This is the amount according to the cASh register.)'),
turnover_bytd_net_val, turnover_py_net_val, turnover_py_bytd_net_val, turnover_py_swday_net_val,
turnover_py_swday_bytd_net_val, sales_net_val, sales_bytd_net_val, sales_py_net_val, sales_py_bytd_net_val,
sales_py_swday_net_val, sales_py_swday_bytd_net_val, return_net_val, return_bytd_net_val, return_py_net_val,
return_py_bytd_net_val, return_py_swday_net_val, return_py_swday_bytd_net_val, curr_cd
OPTIONS(description='The code identifying the currency according to ISO-4217.'), curr_group_fg
OPTIONS(description='Flag for Group Currency'), curr_local_fg OPTIONS(description='Flag for Local Currency'), sales_cnt
, sales_bytd_cnt, sales_py_cnt, sales_py_bytd_cnt, sales_py_swday_cnt, sales_py_swday_bytd_cnt, sales_qty,
sales_bytd_qty, sales_py_qty, sales_py_bytd_qty, sales_py_swday_qty, sales_py_swday_bytd_qty, return_cnt,
return_bytd_cnt, return_py_cnt, return_py_bytd_cnt, return_py_swday_cnt, return_py_swday_bytd_cnt, return_qty,
return_bytd_qty, return_py_qty, return_py_bytd_qty, return_py_swday_qty, return_py_swday_bytd_qty, perf_adj_total_cnt,
perf_adj_total_bytd_cnt, perf_adj_total_py_cnt, perf_adj_total_py_bytd_cnt, perf_adj_total_py_swday_cnt,
perf_adj_total_py_swday_bytd_cnt, perf_adj_total_qty, perf_adj_total_bytd_qty, perf_adj_total_py_qty,
perf_adj_total_py_bytd_qty, perf_adj_total_py_swday_qty, perf_adj_total_py_swday_bytd_qty, dwh_created_tmsp
OPTIONS(description='The point in time when this record wAS created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record wAS created or lASt updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which hAS done the lASt update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record wAS loaded.'))
OPTIONS(DESCRIPTION = `AN AGGREGATE FACT HOLDING GROSS AND NET TURNOVER PER DAY, PRODUCT AND STORE. TURNOVER AMOUNTS ARE TAKEN FROM THE CASH REGISTER.`)
AS SELECT main.bus_dt AS cal_dt,
 main.store_sid,
 main.prod_sid,
 main.sales_variant_sid,
 main.country_org_sid,
 main.country_org_cd,
  main.turnover_net_val / fer.exchange_rate AS turnover_net_val,
  main.turnover_gross_val / fer.exchange_rate AS turnover_gross_val,
  main.turnover_bytd_net_val / fer.exchange_rate AS turnover_bytd_net_val,
  main.turnover_py_net_val / fer.exchange_rate AS turnover_py_net_val,
  main.turnover_py_bytd_net_val / fer.exchange_rate AS turnover_py_bytd_net_val,
  main.turnover_py_swday_net_val / fer.exchange_rate AS turnover_py_swday_net_val,
  main.turnover_py_swday_bytd_net_val / fer.exchange_rate AS turnover_py_swday_bytd_net_val,
  main.sales_net_val / fer.exchange_rate AS sales_net_val,
  main.sales_bytd_net_val / fer.exchange_rate AS sales_bytd_net_val,
  main.sales_py_net_val / fer.exchange_rate AS sales_py_net_val,
  main.sales_py_bytd_net_val / fer.exchange_rate AS sales_py_bytd_net_val,
  main.sales_py_swday_net_val / fer.exchange_rate AS sales_py_swday_net_val,
  main.sales_py_swday_bytd_net_val / fer.exchange_rate AS sales_py_swday_bytd_net_val,
  main.return_net_val / fer.exchange_rate AS return_net_val,
  main.return_bytd_net_val / fer.exchange_rate AS return_bytd_net_val,
  main.return_py_net_val / fer.exchange_rate AS return_py_net_val,
  main.return_py_bytd_net_val / fer.exchange_rate AS return_py_bytd_net_val,
  main.return_py_swday_net_val / fer.exchange_rate AS return_py_swday_net_val,
  main.return_py_swday_bytd_net_val / fer.exchange_rate AS return_py_swday_bytd_net_val,
 fer.src_curr_cd AS curr_cd,
  CASE
  WHEN fer.src_curr_cd = 'EUR'
  THEN 1
  ELSE 0
  END AS curr_group_fg,
  CASE
  WHEN fer.src_curr_cd = fer.tgt_curr_cd
  THEN 1
  ELSE 0
  END AS curr_local_fg,
 COALESCE(main.sales_cnt, 0) AS sales_cnt,
 COALESCE(main.sales_bytd_cnt, 0) AS sales_bytd_cnt,
 COALESCE(main.sales_py_cnt, 0) AS sales_py_cnt,
 COALESCE(main.sales_py_bytd_cnt, 0) AS sales_py_bytd_cnt,
 COALESCE(main.sales_py_swday_cnt, 0) AS sales_py_swday_cnt,
 COALESCE(main.sales_py_swday_bytd_cnt, 0) AS sales_py_swday_bytd_cnt,
 COALESCE(CASE
   WHEN main.country_org_cd = 'US'
   THEN main.sales_qty * 0.453592
   ELSE main.sales_qty
   END, 0) AS sales_qty,
 COALESCE(CASE
   WHEN main.country_org_cd = 'US'
   THEN main.sales_bytd_qty * 0.453592
   ELSE main.sales_bytd_qty
   END, 0) AS sales_bytd_qty,
 COALESCE(CASE
   WHEN main.country_org_cd = 'US'
   THEN main.sales_py_qty * 0.453592
   ELSE main.sales_py_qty
   END, 0) AS sales_py_qty,
 COALESCE(CASE
   WHEN main.country_org_cd = 'US'
   THEN main.sales_py_bytd_qty * 0.453592
   ELSE main.sales_py_bytd_qty
   END, 0) AS sales_py_bytd_qty,
 COALESCE(CASE
   WHEN main.country_org_cd = 'US'
   THEN main.sales_py_swday_qty * 0.453592
   ELSE main.sales_py_swday_qty
   END, 0) AS sales_py_swday_qty,
 COALESCE(CASE
   WHEN main.country_org_cd = 'US'
   THEN main.sales_py_swday_bytd_qty * 0.453592
   ELSE main.sales_py_swday_bytd_qty
   END, 0) AS sales_py_swday_bytd_qty,
 COALESCE(main.return_cnt, 0) AS return_cnt,
 COALESCE(main.return_bytd_cnt, 0) AS return_bytd_cnt,
 COALESCE(main.return_py_cnt, 0) AS return_py_cnt,
 COALESCE(main.return_py_bytd_cnt, 0) AS return_py_bytd_cnt,
 COALESCE(main.return_py_swday_cnt, 0) AS return_py_swday_cnt,
 COALESCE(main.return_py_swday_bytd_cnt, 0) AS return_py_swday_bytd_cnt,
 COALESCE(CASE
   WHEN main.country_org_cd = 'US'
   THEN main.return_qty * 0.453592
   ELSE main.return_qty
   END, 0) AS return_qty,
 COALESCE(CASE
   WHEN main.country_org_cd = 'US'
   THEN main.return_bytd_qty * 0.453592
   ELSE main.return_bytd_qty
   END, 0) AS return_bytd_qty,
 COALESCE(CASE
   WHEN main.country_org_cd = 'US'
   THEN main.return_py_qty * 0.453592
   ELSE main.return_py_qty
   END, 0) AS return_py_qty,
 COALESCE(CASE
   WHEN main.country_org_cd = 'US'
   THEN main.return_py_bytd_qty * 0.453592
   ELSE main.return_py_bytd_qty
   END, 0) AS return_py_bytd_qty,
 COALESCE(CASE
   WHEN main.country_org_cd = 'US'
   THEN main.return_py_swday_qty * 0.453592
   ELSE main.return_py_swday_qty
   END, 0) AS return_py_swday_qty,
 COALESCE(CASE
   WHEN main.country_org_cd = 'US'
   THEN main.return_py_swday_bytd_qty * 0.453592
   ELSE main.return_py_swday_bytd_qty
   END, 0) AS return_py_swday_bytd_qty,
 main.perf_adj_total_cnt,
 main.perf_adj_total_bytd_cnt,
 main.perf_adj_total_py_cnt,
 main.perf_adj_total_py_bytd_cnt,
 main.perf_adj_total_py_swday_cnt,
 main.perf_adj_total_py_swday_bytd_cnt,
  CASE
  WHEN main.country_org_cd = 'US'
  THEN main.perf_adj_total_qty * 0.453592
  ELSE main.perf_adj_total_qty
  END AS perf_adj_total_qty,
  CASE
  WHEN main.country_org_cd = 'US'
  THEN main.perf_adj_total_bytd_qty * 0.453592
  ELSE main.perf_adj_total_bytd_qty
  END AS perf_adj_total_bytd_qty,
  CASE
  WHEN main.country_org_cd = 'US'
  THEN main.perf_adj_total_py_qty * 0.453592
  ELSE main.perf_adj_total_py_qty
  END AS perf_adj_total_py_qty,
  CASE
  WHEN main.country_org_cd = 'US'
  THEN main.perf_adj_total_py_bytd_qty * 0.453592
  ELSE main.perf_adj_total_py_bytd_qty
  END AS perf_adj_total_py_bytd_qty,
  CASE
  WHEN main.country_org_cd = 'US'
  THEN main.perf_adj_total_py_swday_qty * 0.453592
  ELSE main.perf_adj_total_py_swday_qty
  END AS perf_adj_total_py_swday_qty,
  CASE
  WHEN main.country_org_cd = 'US'
  THEN main.perf_adj_total_py_swday_bytd_qty * 0.453592
  ELSE main.perf_adj_total_py_swday_bytd_qty
  END AS perf_adj_total_py_swday_bytd_qty,
 main.dwh_created_tmsp,
 main.dwh_updated_tmsp,
 main.dwh_load_id,
 main.dwh_node_cd
FROM ldl_data_production_core_dim.v_fact_retail_by_store_day_product_alt AS main
 INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate AS fer ON main.curr_cd = fer.tgt_curr_cd
WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
 AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
 AND fer.active_fg;