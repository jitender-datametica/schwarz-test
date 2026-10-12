CREATE TABLE IF NOT EXISTS ldl_s_conl_workbench.t_i_cost_perf_plan_fm101 (
orig_store_nr STRING(10) COLLATE 'und:ci',
orig_store_desc STRING(100) COLLATE 'und:ci',
booking_year STRING(5) COLLATE 'und:ci',
booking_periode STRING(4) COLLATE 'und:ci',
dummy_plan_turnover_brutto NUMERIC(15,5),
plan_turnover_netto NUMERIC(15,5),
plan_cost_total_perc NUMERIC(15,5),
plan_cost_total_abs NUMERIC(15,5),
dummy_plan_perf_netto NUMERIC(15,5),
dummy_plan_hours_netto NUMERIC(15,5),
plan_perf_netto NUMERIC(15,5),
plan_perf_hours_netto NUMERIC(15,5),
dummy_plan_hours_brutto NUMERIC(15,5)
);