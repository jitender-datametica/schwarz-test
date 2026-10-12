CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_employee_inflow AS SELECT INFL.cy_month,
 CC.orig_store_nr,
 INFL.employee_subgroup,
 SUM(INFL.employee_inflow) AS employee_inflow
FROM ldl_s_conl_workbench.t_i_hr_employee_inflow AS INFL
 LEFT JOIN ldl_s_conl_workbench.v_m_cost_center_all AS CC ON CASE
   WHEN INFL.cost_center LIKE '%ECD01%' OR INFL.cost_center LIKE '%ECG02%' OR INFL.cost_center LIKE '%EC001%' OR INFL.cost_center
      LIKE '%EC002%' OR INFL.cost_center LIKE '%EC003%'
   THEN 'ECD01'
   WHEN LENGTH(TRIM(INFL.cost_center)) = 5
   THEN RIGHT(TRIM(INFL.cost_center), 3)
   WHEN LENGTH(TRIM(INFL.cost_center)) = 6
   THEN RIGHT(TRIM(INFL.cost_center), 6)
   ELSE NULL
   END = CC.cost_center
GROUP BY INFL.cy_month,
 CC.orig_store_nr,
 INFL.employee_subgroup;