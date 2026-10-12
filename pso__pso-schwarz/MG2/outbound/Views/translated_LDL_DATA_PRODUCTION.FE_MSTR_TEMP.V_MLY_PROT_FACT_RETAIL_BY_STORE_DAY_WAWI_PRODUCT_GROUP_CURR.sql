CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_temp.v_mly_prot_fact_retail_by_store_day_wawi_product_group_curr (cal_dt
, store_sid, country_org_sid, country_org_cd, wawi_variant_sid, wawi_product_sid, sales_cnt, sales_qty, return_cnt,
return_qty, perf_adj_sales_cnt, perf_adj_sales_qty, perf_adj_return_cnt, perf_adj_return_qty, uom_cd,
cash_register_sales_net_val, cash_register_sales_gross_val, cash_register_return_net_val, cash_register_return_gross_val
, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd, perf_adj_sales_net_val, perf_adj_return_net_val, curr_cd
, curr_group_fg, local_group_fg) AS SELECT main.bus_dt AS cal_dt,
 main.store_sid,
 main.country_org_sid,
 main.country_org_cd,
 main.wawi_variant_sid,
 main.wawi_product_sid,
 main.sales_cnt,
 main.sales_qty,
 main.return_cnt,
 main.return_qty,
 main.perf_adj_sales_cnt,
 main.perf_adj_sales_qty,
 main.perf_adj_return_cnt,
 main.perf_adj_return_qty,
 main.uom_cd,
  main.cash_register_sales_net_val / fer.exchange_rate AS cash_register_sales_net_val,
  main.cash_register_sales_gross_val / fer.exchange_rate AS cash_register_sales_gross_val,
  main.cash_register_return_net_val / fer.exchange_rate AS cash_register_return_net_val,
  main.cash_register_return_gross_val / fer.exchange_rate AS cash_register_return_gross_val,
 main.dwh_created_tmsp,
 main.dwh_updated_tmsp,
 main.dwh_load_id,
 main.dwh_node_cd,
  main.perf_adj_sales_net_val / fer.exchange_rate AS perf_adj_sales_net_val,
  main.perf_adj_return_net_val / fer.exchange_rate AS perf_adj_return_net_val,
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
  END AS curr_local_fg
FROM ldl_data_production_fe_mstr_temp.t_mly_prot_fact_retail_by_store_day_wawi_product AS main
 INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate AS fer ON main.curr_cd = fer.tgt_curr_cd
WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
 AND fer.src_curr_cd = 'EUR'
 AND fer.active_fg;