CREATE OR REPLACE VIEW s_conl_workbench.v_employee_outflow
AS
(SELECT
outfl.cy_month as cy_month,
cc.orig_store_nr as orig_store_nr,
outfl.employee_subgroup as employee_subgroup,
sum(outfl.employee_outflow) as employee_outflow
FROM s_conl_workbench.t_i_hr_employee_outflow as outfl

LEFT JOIN s_conl_workbench.v_m_cost_center_all as cc
ON CASE
WHEN outfl.cost_center like any ('%ECD01%','%ECG02%','%EC001%','%EC002%','%EC003%') THEN 'ECD01'
WHEN length(trim(outfl.cost_center)) = 5 THEN right(trim(outfl.cost_center), 3)
WHEN length(trim(outfl.cost_center)) = 6 THEN right(trim(outfl.cost_center), 6) END =  cc.cost_center
GROUP BY outfl.cy_month, cc.orig_store_nr, outfl.employee_subgroup
);


