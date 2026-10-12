CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_fact_retail_growth_by_store_day_2 (cal_dt, store_sid,
int_org_type_cd, country_org_cd, curr_cd, curr_group_fg, curr_local_fg, turnover_net_val, turnover_bytd_net_val,
turnover_py_net_val, turnover_py_bytd_net_val, turnover_py_swday_net_val, turnover_py_swday_bytd_net_val, receipt_cnt,
receipt_bytd_cnt, receipt_py_cnt, receipt_py_bytd_cnt, receipt_py_swday_cnt, receipt_py_swday_bytd_cnt,
perf_adj_total_cnt, perf_adj_total_bytd_cnt, perf_adj_total_py_cnt, perf_adj_total_py_bytd_cnt,
perf_adj_total_py_swday_cnt, perf_adj_total_py_swday_bytd_cnt, perf_adj_total_qty, perf_adj_total_bytd_qty,
perf_adj_total_py_qty, perf_adj_total_py_bytd_qty, perf_adj_total_py_swday_qty, perf_adj_total_py_swday_bytd_qty) AS
SELECT b.bus_dt AS cal_dt,
 b.int_org_sid AS store_sid,
 b.int_org_type_cd,
 b.country_org_cd,
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
  b.turnover_net_val / fer.exchange_rate AS turnover_net_val,
  b.turnover_bytd_net_val / fer.exchange_rate AS turnover_bytd_net_val,
  b.turnover_py_net_val / fer.exchange_rate AS turnover_py_net_val,
  b.turnover_py_bytd_net_val / fer.exchange_rate AS turnover_py_bytd_net_val,
  b.turnover_py_swday_net_val / fer.exchange_rate AS turnover_py_swday_net_val,
  b.turnover_py_swday_bytd_net_val / fer.exchange_rate AS turnover_py_swday_bytd_net_val,
 b.receipt_cnt,
 b.receipt_bytd_cnt,
 b.receipt_py_cnt,
 b.receipt_py_bytd_cnt,
 b.receipt_py_swday_cnt,
 b.receipt_py_swday_bytd_cnt,
 b.perf_adj_total_cnt,
 b.perf_adj_total_bytd_cnt,
 b.perf_adj_total_py_cnt,
 b.perf_adj_total_py_bytd_cnt,
 b.perf_adj_total_py_swday_cnt,
 b.perf_adj_total_py_swday_bytd_cnt,
  CASE
  WHEN b.country_org_cd = 'US'
  THEN b.perf_adj_total_qty * 0.453592
  ELSE b.perf_adj_total_qty
  END AS perf_adj_total_qty,
  CASE
  WHEN b.country_org_cd = 'US'
  THEN b.perf_adj_total_bytd_qty * 0.453592
  ELSE b.perf_adj_total_bytd_qty
  END AS perf_adj_total_bytd_qty,
  CASE
  WHEN b.country_org_cd = 'US'
  THEN b.perf_adj_total_py_qty * 0.453592
  ELSE b.perf_adj_total_py_qty
  END AS perf_adj_total_py_qty,
  CASE
  WHEN b.country_org_cd = 'US'
  THEN b.perf_adj_total_py_bytd_qty * 0.453592
  ELSE b.perf_adj_total_py_bytd_qty
  END AS perf_adj_total_py_bytd_qty,
  CASE
  WHEN b.country_org_cd = 'US'
  THEN b.perf_adj_total_py_swday_qty * 0.453592
  ELSE b.perf_adj_total_py_swday_qty
  END AS perf_adj_total_py_swday_qty,
  CASE
  WHEN b.country_org_cd = 'US'
  THEN b.perf_adj_total_py_swday_bytd_qty * 0.453592
  ELSE b.perf_adj_total_py_swday_bytd_qty
  END AS perf_adj_total_py_swday_bytd_qty
FROM ldl_data_production_core_dim.v_fact_retail_growth_by_store_day_2 AS b
 INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate_2 AS fer ON b.curr_cd = fer.tgt_curr_cd AND fer.exchange_rate_type_cd
      = 'BEW_ISK' AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd) AND fer.active_fg;