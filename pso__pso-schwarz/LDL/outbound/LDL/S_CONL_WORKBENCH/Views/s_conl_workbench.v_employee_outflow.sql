CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_employee_outflow AS SELECT OUTFL.cy_month,
 CC.orig_store_nr,
 OUTFL.employee_subgroup,
 SUM(OUTFL.employee_outflow) AS employee_outflow
FROM ldl_s_conl_workbench.t_i_hr_employee_outflow AS OUTFL
 LEFT JOIN ldl_s_conl_workbench.v_m_cost_center_all AS CC ON CASE
   WHEN OUTFL.cost_center LIKE '%ECD01%' OR OUTFL.cost_center LIKE '%ECG02%' OR OUTFL.cost_center LIKE '%EC001%' OR
      OUTFL.cost_center LIKE '%EC002%' OR OUTFL.cost_center LIKE '%EC003%'
   THEN 'ECD01'
   WHEN LENGTH(TRIM(OUTFL.cost_center)) = 5
   THEN RIGHT(TRIM(OUTFL.cost_center), 3)
   WHEN LENGTH(TRIM(OUTFL.cost_center)) = 6
   THEN RIGHT(TRIM(OUTFL.cost_center), 6)
   ELSE NULL
   END = CC.cost_center
GROUP BY OUTFL.cy_month,
 CC.orig_store_nr,
 OUTFL.employee_subgroup;