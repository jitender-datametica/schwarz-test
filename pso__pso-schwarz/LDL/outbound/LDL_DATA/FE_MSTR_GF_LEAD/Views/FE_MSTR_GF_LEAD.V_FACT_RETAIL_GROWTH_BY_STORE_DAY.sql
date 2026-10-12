CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_fact_retail_growth_by_store_day (cal_dt, store_sid, int_org_type_cd,
country_org_cd, curr_cd, curr_group_fg, curr_local_fg, turnover_net_val, turnover_bytd_net_val, turnover_py_net_val,
turnover_py_bytd_net_val, turnover_py_swday_net_val, turnover_py_swday_bytd_net_val, receipt_cnt, receipt_bytd_cnt,
receipt_py_cnt, receipt_py_bytd_cnt, receipt_py_swday_cnt, receipt_py_swday_bytd_cnt, perf_adj_total_cnt,
perf_adj_total_bytd_cnt, perf_adj_total_py_cnt, perf_adj_total_py_bytd_cnt, perf_adj_total_py_swday_cnt,
perf_adj_total_py_swday_bytd_cnt, perf_adj_total_qty, perf_adj_total_bytd_qty, perf_adj_total_py_qty,
perf_adj_total_py_bytd_qty, perf_adj_total_py_swday_qty, perf_adj_total_py_swday_bytd_qty) AS SELECT B.bus_dt AS cal_dt
 ,
 B.int_org_sid AS store_sid,
 B.int_org_type_cd,
 B.country_org_cd,
 FER.src_curr_cd AS curr_cd,
  CASE
  WHEN FER.src_curr_cd = 'EUR'
  THEN 1
  ELSE 0
  END AS curr_group_fg,
  CASE
  WHEN FER.src_curr_cd = FER.tgt_curr_cd
  THEN 1
  ELSE 0
  END AS curr_local_fg,
  B.turnover_net_val / FER.exchange_rate AS turnover_net_val,
  B.turnover_bytd_net_val / FER.exchange_rate AS turnover_bytd_net_val,
  B.turnover_py_net_val / FER.exchange_rate AS turnover_py_net_val,
  B.turnover_py_bytd_net_val / FER.exchange_rate AS turnover_py_bytd_net_val,
  B.turnover_py_swday_net_val / FER.exchange_rate AS turnover_py_swday_net_val,
  B.turnover_py_swday_bytd_net_val / FER.exchange_rate AS turnover_py_swday_bytd_net_val,
 B.receipt_cnt,
 B.receipt_bytd_cnt,
 B.receipt_py_cnt,
 B.receipt_py_bytd_cnt,
 B.receipt_py_swday_cnt,
 B.receipt_py_swday_bytd_cnt,
 B.perf_adj_total_cnt,
 B.perf_adj_total_bytd_cnt,
 B.perf_adj_total_py_cnt,
 B.perf_adj_total_py_bytd_cnt,
 B.perf_adj_total_py_swday_cnt,
 B.perf_adj_total_py_swday_bytd_cnt,
  CASE
  WHEN B.country_org_cd = 'US'
  THEN B.perf_adj_total_qty * 0.453592
  ELSE B.perf_adj_total_qty
  END AS perf_adj_total_qty,
  CASE
  WHEN B.country_org_cd = 'US'
  THEN B.perf_adj_total_bytd_qty * 0.453592
  ELSE B.perf_adj_total_bytd_qty
  END AS perf_adj_total_bytd_qty,
  CASE
  WHEN B.country_org_cd = 'US'
  THEN B.perf_adj_total_py_qty * 0.453592
  ELSE B.perf_adj_total_py_qty
  END AS perf_adj_total_py_qty,
  CASE
  WHEN B.country_org_cd = 'US'
  THEN B.perf_adj_total_py_bytd_qty * 0.453592
  ELSE B.perf_adj_total_py_bytd_qty
  END AS perf_adj_total_py_bytd_qty,
  CASE
  WHEN B.country_org_cd = 'US'
  THEN B.perf_adj_total_py_swday_qty * 0.453592
  ELSE B.perf_adj_total_py_swday_qty
  END AS perf_adj_total_py_swday_qty,
  CASE
  WHEN B.country_org_cd = 'US'
  THEN B.perf_adj_total_py_swday_bytd_qty * 0.453592
  ELSE B.perf_adj_total_py_swday_bytd_qty
  END AS perf_adj_total_py_swday_bytd_qty
FROM ldl_data_core_dim.v_fact_retail_growth_by_store_day AS B
 INNER JOIN ldl_data_core_dim.t_fact_exchange_rate AS FER ON B.curr_cd = FER.tgt_curr_cd AND FER.exchange_rate_type_cd =
     'BEW_ISK' AND (FER.src_curr_cd = 'EUR' OR FER.src_curr_cd = FER.tgt_curr_cd) AND FER.active_fg;