CREATE OR REPLACE VIEW s_conl_workbench.v_cost_perf_plan_fm101_1
AS
(SELECT
mapping.orig_store_nr,
mp.cy_month,
plan.plan_turnover_netto,
abs(plan.plan_cost_total_perc)*(-1) as plan_cost_total_perc,
abs(plan.plan_cost_total_abs)*(-1) as plan_cost_total_abs,
plan.plan_perf_netto,
plan.plan_perf_hours_netto
FROM s_conl_workbench.t_i_cost_perf_plan_fm101_1 as plan
LEFT JOIN s_conl_workbench.t_m_month_periode_1 as mp
ON (CASE
WHEN plan.booking_periode<=9 THEN plan.booking_year||'0'||plan.booking_periode
ELSE plan.booking_year||plan.booking_periode END) = mp.by_period
INNER JOIN s_conl_workbench.v_m_cost_center_all_1 as mapping
ON plan.orig_store_nr =  mapping.cost_center

);


