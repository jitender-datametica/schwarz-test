--SALES_2 CNT & QTY


-- RETURN CNT & CNT


-- TOTAL CNT & QTY


-- PERF ADJ CNT & QTY


--PERF ADJ CNT & QTY TOTALS 


-- TURNOVER NET 


--Planned TURNOVER NET VAL 


-- SALES_2 NET VAL


-- RETURN NET VAL


-- TURNOVER GROSS 


-- RECEIPT CNT


CREATE OR REPLACE VIEW ldl_data_production_core_dim.v_fact_retail_by_store_day_2 (bus_dt, int_org_sid, int_org_type_cd,
country_org_cd, sales_cnt, sales_bytd_cnt, sales_py_cnt, sales_py_bytd_cnt, sales_py_swday_cnt, sales_py_swday_bytd_cnt
, sales_qty, sales_bytd_qty, sales_py_qty, sales_py_bytd_qty, sales_py_swday_qty, sales_py_swday_bytd_qty, return_cnt,
return_bytd_cnt, return_py_cnt, return_py_bytd_cnt, return_py_swday_cnt, return_py_swday_bytd_cnt, return_qty,
return_bytd_qty, return_py_qty, return_py_bytd_qty, return_py_swday_qty, return_py_swday_bytd_qty, total_cnt,
total_bytd_cnt, total_py_cnt, total_py_bytd_cnt, total_py_swday_cnt, total_py_swday_bytd_cnt, total_qty, total_bytd_qty
, total_py_qty, total_py_bytd_qty, total_py_swday_qty, total_py_swday_bytd_qty, perf_adj_sales_cnt,
perf_adj_sales_bytd_cnt, perf_adj_sales_py_cnt, perf_adj_sales_py_bytd_cnt, perf_adj_sales_py_swday_cnt,
perf_adj_sales_py_swday_bytd_cnt, perf_adj_sales_qty, perf_adj_sales_bytd_qty, perf_adj_sales_py_qty,
perf_adj_sales_py_bytd_qty, perf_adj_sales_py_swday_qty, perf_adj_sales_py_swday_bytd_qty, perf_adj_return_cnt,
perf_adj_return_bytd_cnt, perf_adj_return_py_cnt, perf_adj_return_py_bytd_cnt, perf_adj_return_py_swday_cnt,
perf_adj_return_py_swday_bytd_cnt, perf_adj_return_qty, perf_adj_return_bytd_qty, perf_adj_return_py_qty,
perf_adj_return_py_bytd_qty, perf_adj_return_py_swday_qty, perf_adj_return_py_swday_bytd_qty, perf_adj_total_cnt,
perf_adj_total_bytd_cnt, perf_adj_total_py_cnt, perf_adj_total_py_bytd_cnt, perf_adj_total_py_swday_cnt,
perf_adj_total_py_swday_bytd_cnt, perf_adj_total_qty, perf_adj_total_bytd_qty, perf_adj_total_py_qty,
perf_adj_total_py_bytd_qty, perf_adj_total_py_swday_qty, perf_adj_total_py_swday_bytd_qty, uom_cd, turnover_net_val,
turnover_bytd_net_val, turnover_py_net_val, turnover_py_bytd_net_val, turnover_py_swday_net_val,
turnover_py_swday_bytd_net_val, plan_turnover_net_val, plan_turnover_bytd_net_val, plan_turnover_py_net_val,
plan_turnover_py_bytd_net_val, plan_turnover_py_swday_net_val, plan_turnover_py_swday_bytd_net_val, sales_net_val,
sales_bytd_net_val, sales_py_net_val, sales_py_bytd_net_val, sales_py_swday_net_val, sales_py_swday_bytd_net_val,
return_net_val, return_bytd_net_val, return_py_net_val, return_py_bytd_net_val, return_py_swday_net_val,
return_py_swday_bytd_net_val, eod_turnover_net_val, booked_turnover_net_val, turnover_gross_val, turnover_bytd_gross_val
, turnover_py_gross_val, turnover_py_bytd_gross_val, turnover_py_swday_gross_val, turnover_py_swday_bytd_gross_val,
cash_register_sales_gross_val, cash_register_return_gross_val, eod_turnover_gross_val, curr_cd, receipt_cnt,
receipt_bytd_cnt, receipt_py_cnt, receipt_py_bytd_cnt, receipt_py_swday_cnt, receipt_py_swday_bytd_cnt,
cash_register_receipt_cnt, eod_receipt_cnt, booked_receipt_cnt, plan_receipt_cnt, plan_receipt_bytd_cnt,
plan_receipt_py_cnt, plan_receipt_py_bytd_cnt, plan_receipt_py_swday_cnt, plan_receipt_py_swday_bytd_cnt,
dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd) AS SELECT f.bus_dt,
 COALESCE(io.int_org_sid, pk.party_sid) AS int_org_sid,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.int_org_type_cd
  ELSE 'COMPANY'
  END AS int_org_type_cd,
 f.country_org_cd,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.sales_cnt
  ELSE NULL
  END AS sales_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.sales_bytd_cnt
  ELSE NULL
  END AS sales_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.sales_py_cnt
  ELSE NULL
  END AS sales_py_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.sales_py_bytd_cnt
  ELSE NULL
  END AS sales_py_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.sales_py_swday_cnt
  ELSE NULL
  END AS sales_py_swday_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.sales_py_swday_bytd_cnt
  ELSE NULL
  END AS sales_py_swday_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.sales_qty
  ELSE NULL
  END AS sales_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.sales_bytd_qty
  ELSE NULL
  END AS sales_bytd_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.sales_py_qty
  ELSE NULL
  END AS sales_py_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.sales_py_bytd_qty
  ELSE NULL
  END AS sales_py_bytd_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.sales_py_swday_qty
  ELSE NULL
  END AS sales_py_swday_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.sales_py_swday_bytd_qty
  ELSE NULL
  END AS sales_py_swday_bytd_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.return_cnt
  ELSE NULL
  END AS return_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.return_bytd_cnt
  ELSE NULL
  END AS return_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.return_py_cnt
  ELSE NULL
  END AS return_py_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.return_py_bytd_cnt
  ELSE NULL
  END AS return_py_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.return_py_swday_cnt
  ELSE NULL
  END AS return_py_swday_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.return_py_swday_bytd_cnt
  ELSE NULL
  END AS return_py_swday_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.return_qty
  ELSE NULL
  END AS return_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.return_bytd_qty
  ELSE NULL
  END AS return_bytd_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.return_py_qty
  ELSE NULL
  END AS return_py_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.return_py_bytd_qty
  ELSE NULL
  END AS return_py_bytd_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.return_py_swday_qty
  ELSE NULL
  END AS return_py_swday_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.return_py_swday_bytd_qty
  ELSE NULL
  END AS return_py_swday_bytd_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.return_cnt, 0) + COALESCE(f.sales_cnt, 0)
  ELSE NULL
  END AS total_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.return_bytd_cnt, 0) + COALESCE(f.sales_bytd_cnt, 0)
  ELSE NULL
  END AS total_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.return_py_cnt, 0) + COALESCE(f.sales_py_cnt, 0)
  ELSE NULL
  END AS total_py_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.return_py_bytd_cnt, 0) + COALESCE(f.sales_py_bytd_cnt, 0)
  ELSE NULL
  END AS total_py_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.return_py_swday_cnt, 0) + COALESCE(f.sales_py_swday_cnt, 0)
  ELSE NULL
  END AS total_py_swday_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.return_py_swday_bytd_cnt, 0) + COALESCE(f.sales_py_swday_bytd_cnt, 0)
  ELSE NULL
  END AS total_py_swday_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.return_qty, 0) + COALESCE(f.sales_qty, 0)
  ELSE NULL
  END AS total_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.return_bytd_qty, 0) + COALESCE(f.sales_bytd_qty, 0)
  ELSE NULL
  END AS total_bytd_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.return_py_qty, 0) + COALESCE(f.sales_py_qty, 0)
  ELSE NULL
  END AS total_py_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.return_py_bytd_qty, 0) + COALESCE(f.sales_py_bytd_qty, 0)
  ELSE NULL
  END AS total_py_bytd_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.return_py_swday_qty, 0) + COALESCE(f.sales_py_swday_qty, 0)
  ELSE NULL
  END AS total_py_swday_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.return_py_swday_bytd_qty, 0) + COALESCE(f.sales_py_swday_bytd_qty, 0)
  ELSE NULL
  END AS total_py_swday_bytd_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_sales_cnt
  ELSE NULL
  END AS perf_adj_sales_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_sales_bytd_cnt
  ELSE NULL
  END AS perf_adj_sales_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_sales_py_cnt
  ELSE NULL
  END AS perf_adj_sales_py_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_sales_py_bytd_cnt
  ELSE NULL
  END AS perf_adj_sales_py_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_sales_py_swday_cnt
  ELSE NULL
  END AS perf_adj_sales_py_swday_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_sales_py_swday_bytd_cnt
  ELSE NULL
  END AS perf_adj_sales_py_swday_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_sales_qty
  ELSE NULL
  END AS perf_adj_sales_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_sales_bytd_qty
  ELSE NULL
  END AS erf_adj_sales_bytd_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_sales_py_qty
  ELSE NULL
  END AS perf_adj_sales_py_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_sales_py_bytd_qty
  ELSE NULL
  END AS perf_adj_sales_py_bytd_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_sales_py_swday_qty
  ELSE NULL
  END AS perf_adj_sales_py_swday_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_sales_py_swday_bytd_qty
  ELSE NULL
  END AS perf_adj_sales_py_swday_bytd_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_return_cnt
  ELSE NULL
  END AS perf_adj_return_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_return_bytd_cnt
  ELSE NULL
  END AS perf_adj_return_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_return_py_cnt
  ELSE NULL
  END AS perf_adj_return_py_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_return_py_bytd_cnt
  ELSE NULL
  END AS perf_adj_return_py_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_return_py_swday_cnt
  ELSE NULL
  END AS erf_adj_return_py_swday_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_return_py_swday_bytd_cnt
  ELSE NULL
  END AS perf_adj_return_py_swday_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_return_qty
  ELSE NULL
  END AS perf_adj_return_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_return_bytd_qty
  ELSE NULL
  END AS perf_adj_return_bytd_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_return_py_qty
  ELSE NULL
  END AS perf_adj_return_py_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_return_py_bytd_qty
  ELSE NULL
  END AS perf_adj_return_py_bytd_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_return_py_swday_qty
  ELSE NULL
  END AS perf_adj_return_py_swday_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.perf_adj_return_py_swday_bytd_qty
  ELSE NULL
  END AS perf_adj_return_py_swday_bytd_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.perf_adj_sales_cnt, 0) + COALESCE(f.perf_adj_return_cnt, 0)
  ELSE NULL
  END AS perf_adj_total_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.perf_adj_sales_bytd_cnt, 0) + COALESCE(f.perf_adj_return_bytd_cnt, 0)
  ELSE NULL
  END AS perf_adj_total_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.perf_adj_sales_py_cnt, 0) + COALESCE(f.perf_adj_return_py_cnt, 0)
  ELSE NULL
  END AS perf_adj_total_py_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.perf_adj_sales_py_bytd_cnt, 0) + COALESCE(f.perf_adj_return_py_bytd_cnt, 0)
  ELSE NULL
  END AS perf_adj_total_py_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.perf_adj_sales_py_swday_cnt, 0) + COALESCE(f.perf_adj_return_py_swday_cnt, 0)
  ELSE NULL
  END AS perf_adj_total_py_swday_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.perf_adj_sales_py_swday_bytd_cnt, 0) + COALESCE(f.perf_adj_return_py_swday_bytd_cnt, 0)
  ELSE NULL
  END AS perf_adj_total_py_swday_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.perf_adj_sales_qty, 0) + COALESCE(f.perf_adj_return_qty, 0)
  ELSE NULL
  END AS perf_adj_total_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.perf_adj_sales_bytd_qty, 0) + COALESCE(f.perf_adj_return_bytd_qty, 0)
  ELSE NULL
  END AS perf_adj_total_bytd_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.perf_adj_sales_py_qty, 0) + COALESCE(f.perf_adj_return_py_qty, 0)
  ELSE NULL
  END AS perf_adj_total_py_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.perf_adj_sales_py_bytd_qty, 0) + COALESCE(f.perf_adj_return_py_bytd_qty, 0)
  ELSE NULL
  END AS perf_adj_total_py_bytd_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.perf_adj_sales_py_swday_qty, 0) + COALESCE(f.perf_adj_return_py_swday_qty, 0)
  ELSE NULL
  END AS perf_adj_total_py_swday_qty,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN COALESCE(f.perf_adj_sales_py_swday_bytd_qty, 0) + COALESCE(f.perf_adj_return_py_swday_bytd_qty, 0)
  ELSE NULL
  END AS perf_adj_total_py_swday_bytd_qty,
 f.uom_cd,
 f.turnover_net_val,
 f.turnover_bytd_net_val,
 f.turnover_py_net_val,
 f.turnover_py_bytd_net_val,
 f.turnover_py_swday_net_val,
 f.turnover_py_swday_bytd_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.plan_turnover_net_val
  ELSE NULL
  END AS plan_turnover_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.plan_turnover_bytd_net_val
  ELSE NULL
  END AS plan_turnover_bytd_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.plan_turnover_py_net_val
  ELSE NULL
  END AS plan_turnover_py_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.plan_turnover_py_bytd_net_val
  ELSE NULL
  END AS plan_turnover_py_bytd_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.plan_turnover_py_swday_net_val
  ELSE NULL
  END AS plan_turnover_py_swday_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.plan_turnover_py_swday_bytd_net_val
  ELSE NULL
  END AS plan_turnover_py_swday_bytd_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.cash_register_sales_net_val
  ELSE NULL
  END AS sales_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.cash_register_sales_bytd_net_val
  ELSE NULL
  END AS sales_bytd_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.cash_register_sales_py_net_val
  ELSE NULL
  END AS sales_py_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.cash_register_sales_py_bytd_net_val
  ELSE NULL
  END AS sales_py_bytd_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.cash_register_sales_py_swday_net_val
  ELSE NULL
  END AS sales_py_swday_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.cash_register_sales_py_swday_bytd_net_val
  ELSE NULL
  END AS sales_py_swday_bytd_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.cash_register_return_net_val
  ELSE NULL
  END AS return_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.cash_register_return_bytd_net_val
  ELSE NULL
  END AS return_bytd_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.cash_register_return_py_net_val
  ELSE NULL
  END AS return_py_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.cash_register_return_py_bytd_net_val
  ELSE NULL
  END AS return_py_bytd_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.cash_register_return_py_swday_net_val
  ELSE NULL
  END AS return_py_swday_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.cash_register_return_py_swday_bytd_net_val
  ELSE NULL
  END AS return_py_swday_bytd_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.eod_turnover_net_val
  ELSE NULL
  END AS eod_turnover_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.booked_turnover_net_val
  ELSE NULL
  END AS booked_turnover_net_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.turnover_gross_val
  ELSE NULL
  END AS turnover_gross_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.turnover_bytd_gross_val
  ELSE NULL
  END AS turnover_bytd_gross_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.turnover_py_gross_val
  ELSE NULL
  END AS turnover_py_gross_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.turnover_py_bytd_gross_val
  ELSE NULL
  END AS turnover_py_bytd_gross_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.turnover_py_swday_gross_val
  ELSE NULL
  END AS turnover_py_swday_gross_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.turnover_py_swday_bytd_gross_val
  ELSE NULL
  END AS turnover_py_swday_bytd_gross_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.cash_register_sales_gross_val
  ELSE NULL
  END AS cash_register_sales_gross_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.cash_register_return_gross_val
  ELSE NULL
  END AS cash_register_return_gross_val,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.eod_turnover_gross_val
  ELSE NULL
  END AS eod_turnover_gross_val,
 f.curr_cd,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.receipt_cnt
  ELSE NULL
  END AS receipt_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.receipt_bytd_cnt
  ELSE NULL
  END AS receipt_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.receipt_py_cnt
  ELSE NULL
  END AS receipt_py_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.receipt_py_bytd_cnt
  ELSE NULL
  END AS receipt_py_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.receipt_py_swday_cnt
  ELSE NULL
  END AS receipt_py_swday_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.receipt_py_swday_bytd_cnt
  ELSE NULL
  END AS receipt_py_swday_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.cash_register_receipt_cnt
  ELSE NULL
  END AS cash_register_receipt_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.eod_receipt_cnt
  ELSE NULL
  END AS eod_receipt_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.booked_receipt_cnt
  ELSE NULL
  END AS booked_receipt_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.plan_receipt_cnt
  ELSE NULL
  END AS plan_receipt_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.plan_receipt_bytd_cnt
  ELSE NULL
  END AS plan_receipt_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.plan_receipt_py_cnt
  ELSE NULL
  END AS plan_receipt_py_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.plan_receipt_py_bytd_cnt
  ELSE NULL
  END AS plan_receipt_py_bytd_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.plan_receipt_py_swday_cnt
  ELSE NULL
  END AS plan_receipt_py_swday_cnt,
  CASE
  WHEN io.int_org_sid IS NOT NULL
  THEN f.plan_receipt_py_swday_bytd_cnt
  ELSE NULL
  END AS plan_receipt_py_swday_bytd_cnt,
 f.dwh_created_tmsp,
 f.dwh_updated_tmsp,
 f.dwh_load_id,
 f.dwh_node_cd
FROM ldl_data_production_core_dim.t_fact_retail_by_store_day_2 AS f
 LEFT JOIN ldl_data_production_core_dim.t_dim_internal_organization_2 AS io ON f.int_org_sid = io.int_org_sid AND io.dwh_valid_fg
  
 INNER JOIN ldl_data_production_meta.t_party_key_2 AS pk ON f.country_org_cd = pk.party_nat_key_nr AND pk.party_key_type_cd
     = 'COUNTRY_2' AND pk.dwh_valid_fg;