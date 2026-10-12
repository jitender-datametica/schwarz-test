CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_g_employee_fluctuation AS /* instroom */ /* uitstroom */ SELECT INF.orig_store_nr
 ,
 INF.cy_month,
 SUM(CASE
   WHEN INF.employee_subgroup = '5C'
   THEN INF.employee_inflow
   ELSE 0
   END) AS employee_inflow_teammanager,
 SUM(CASE
   WHEN INF.employee_subgroup = '6B'
   THEN INF.employee_inflow
   ELSE 0
   END) AS employee_inflow_medewerker,
 SUM(CASE
   WHEN INF.employee_subgroup = '6H'
   THEN INF.employee_inflow
   ELSE 0
   END) AS employee_inflow_hulpkracht,
 SUM(CASE
   WHEN OUTF.employee_subgroup = '5C'
   THEN OUTF.employee_outflow
   ELSE 0
   END) AS employee_outflow_teammanager,
 SUM(CASE
   WHEN OUTF.employee_subgroup = '6B'
   THEN OUTF.employee_outflow
   ELSE 0
   END) AS employee_outflow_medewerker,
 SUM(CASE
   WHEN OUTF.employee_subgroup = '6H'
   THEN OUTF.employee_outflow
   ELSE 0
   END) AS employee_outflow_hulpkracht
FROM ldl_s_conl_workbench.v_employee_inflow AS INF
 LEFT JOIN ldl_s_conl_workbench.v_employee_outflow AS OUTF ON INF.orig_store_nr = OUTF.orig_store_nr AND INF.cy_month =
    OUTF.cy_month AND INF.employee_subgroup = OUTF.employee_subgroup
WHERE LENGTH(INF.orig_store_nr) > 3
 AND INF.employee_subgroup IN ('5C', '6B', '6H')
GROUP BY INF.orig_store_nr,
 INF.cy_month;