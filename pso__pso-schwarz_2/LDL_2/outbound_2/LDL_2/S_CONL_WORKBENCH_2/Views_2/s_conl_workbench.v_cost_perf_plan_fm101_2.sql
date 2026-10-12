CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_cost_perf_plan_fm101_2 AS SELECT MAPPING.orig_store_nr,
 MP.cy_month,
 PLAN.plan_turnover_netto,
  ABS(PLAN.plan_cost_total_perc) * - 1 AS plan_cost_total_perc,
  ABS(PLAN.plan_cost_total_abs) * - 1 AS plan_cost_total_abs,
 PLAN.plan_perf_netto,
 PLAN.plan_perf_hours_netto
FROM ldl_s_conl_workbench.t_i_cost_perf_plan_fm101_2 AS PLAN
 LEFT JOIN ldl_s_conl_workbench.t_m_month_periode_2 AS MP ON CASE
   WHEN CAST(PLAN.booking_periode AS FLOAT64) <= 9
   THEN PLAN.booking_year || '0' || PLAN.booking_periode
   ELSE PLAN.booking_year || PLAN.booking_periode
   END = MP.by_period
 INNER JOIN ldl_s_conl_workbench.v_m_cost_center_all_2 AS MAPPING ON PLAN.orig_store_nr = MAPPING.cost_center;