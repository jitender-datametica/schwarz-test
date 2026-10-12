CREATE OR REPLACE VIEW s_conl_workbench.v_employee_inflow_1
AS
(SELECT
infl.cy_month as cy_month,
cc.orig_store_nr as orig_store_nr,
infl.employee_subgroup as employee_subgroup,
sum(infl.employee_inflow) as employee_inflow
FROM s_conl_workbench.t_i_hr_employee_inflow_1 as infl

LEFT JOIN s_conl_workbench.v_m_cost_center_all_1 as cc
ON CASE
WHEN infl.cost_center like any ('%ECD01%','%ECG02%','%EC001%','%EC002%','%EC003%') THEN 'ECD01'
WHEN length(trim(infl.cost_center)) = 5 THEN right(trim(infl.cost_center), 3)
WHEN length(trim(infl.cost_center)) = 6 THEN right(trim(infl.cost_center), 6) END =  cc.cost_center
GROUP BY infl.cy_month, cc.orig_store_nr, infl.employee_subgroup
);


