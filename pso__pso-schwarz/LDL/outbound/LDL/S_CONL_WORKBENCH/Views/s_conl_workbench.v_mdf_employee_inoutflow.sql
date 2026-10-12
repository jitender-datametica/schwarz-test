CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_mdf_employee_inoutflow AS SELECT COALESCE(INF.business_year, OUTF.business_year
  ) AS business_year,
 COALESCE(INF.booking_month, OUTF.booking_month) AS booking_month,
  CASE
  WHEN SUBSTR(COALESCE(INF.cost_center, OUTF.cost_center), 1, 2) = '10'
  THEN 1
  WHEN SUBSTR(COALESCE(INF.cost_center, OUTF.cost_center), 1, 2) = '20'
  THEN 2
  WHEN SUBSTR(COALESCE(INF.cost_center, OUTF.cost_center), 1, 2) = '30'
  THEN 3
  WHEN SUBSTR(COALESCE(INF.cost_center, OUTF.cost_center), 1, 2) = '31'
  THEN 3
  WHEN SUBSTR(COALESCE(INF.cost_center, OUTF.cost_center), 1, 2) = '40'
  THEN 4
  WHEN SUBSTR(COALESCE(INF.cost_center, OUTF.cost_center), 1, 2) = '41'
  THEN 4
  WHEN SUBSTR(COALESCE(INF.cost_center, OUTF.cost_center), 1, 2) = '50'
  THEN 5
  WHEN SUBSTR(COALESCE(INF.cost_center, OUTF.cost_center), 1, 2) = '60'
  THEN 6
  WHEN SUBSTR(COALESCE(INF.cost_center, OUTF.cost_center), 1, 2) = '90'
  THEN 9
  ELSE 99
  END AS warehouse_nr,
  CASE
  WHEN LEFT(COALESCE(INF.cost_center, OUTF.cost_center), 2) = '10'
  THEN 'HEE'
  WHEN LEFT(COALESCE(INF.cost_center, OUTF.cost_center), 2) = '20'
  THEN 'ETT'
  WHEN LEFT(COALESCE(INF.cost_center, OUTF.cost_center), 2) = '30'
  THEN 'OOS'
  WHEN LEFT(COALESCE(INF.cost_center, OUTF.cost_center), 2) = '31'
  THEN 'OOS'
  WHEN LEFT(COALESCE(INF.cost_center, OUTF.cost_center), 2) = '40'
  THEN 'ZWA'
  WHEN LEFT(COALESCE(INF.cost_center, OUTF.cost_center), 2) = '41'
  THEN 'ZWA'
  WHEN LEFT(COALESCE(INF.cost_center, OUTF.cost_center), 2) = '50'
  THEN 'WEE'
  WHEN LEFT(COALESCE(INF.cost_center, OUTF.cost_center), 2) = '60'
  THEN 'WAD'
  WHEN LEFT(COALESCE(INF.cost_center, OUTF.cost_center), 2) = '90'
  THEN 'TIE'
  ELSE 'Unknown'
  END AS warehouse_desc_short,
  CASE
  WHEN LEFT(COALESCE(INF.cost_center, OUTF.cost_center), 2) = '10'
  THEN 'Heerenveen'
  WHEN LEFT(COALESCE(INF.cost_center, OUTF.cost_center), 2) = '20'
  THEN 'Etten-Leur'
  WHEN LEFT(COALESCE(INF.cost_center, OUTF.cost_center), 2) = '30'
  THEN 'Oosterhout'
  WHEN LEFT(COALESCE(INF.cost_center, OUTF.cost_center), 2) = '31'
  THEN 'Oosterhout'
  WHEN LEFT(COALESCE(INF.cost_center, OUTF.cost_center), 2) = '40'
  THEN 'Zwaag'
  WHEN LEFT(COALESCE(INF.cost_center, OUTF.cost_center), 2) = '41'
  THEN 'Zwaag'
  WHEN LEFT(COALESCE(INF.cost_center, OUTF.cost_center), 2) = '50'
  THEN 'Weert'
  WHEN LEFT(COALESCE(INF.cost_center, OUTF.cost_center), 2) = '60'
  THEN 'Waddinxveen'
  WHEN LEFT(COALESCE(INF.cost_center, OUTF.cost_center), 2) = '90'
  THEN 'Tiel'
  ELSE 'Unknown'
  END AS warehouse_desc,
 COALESCE(INF.cost_center, OUTF.cost_center) AS cost_center,
 COALESCE(INF.employee_subgroup, OUTF.employee_subgroup) AS employee_subgroup,
 INF.inflow_lj,
 INF.inflow_vj,
 OUTF.outflow_lj,
 OUTF.outflow_vj
FROM (SELECT COALESCE(LJ.business_year, VJ.business_year + 1) AS business_year,
   COALESCE(LJ.booking_month, VJ.booking_month + 100) AS booking_month,
   COALESCE(LJ.cost_center, VJ.cost_center) AS cost_center,
   COALESCE(LJ.employee_subgroup, VJ.employee_subgroup) AS employee_subgroup,
   SUM(LJ.employee_inflow) AS inflow_lj,
   SUM(LJ.employee_inflow) AS inflow_vj
  FROM (SELECT ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING FORMAT '999999')), 4) AS BIGNUMERIC), 0) AS business_year,
     cy_month AS booking_month,
     cost_center,
     employee_subgroup,
     employee_inflow
    FROM ldl_s_conl_workbench.t_i_hr_employee_inflow
    WHERE RIGHT(TRIM(cost_center), 4) IN ('9628', '9648', '9668', '9698')
     AND LEFT(TRIM(CAST(cy_month AS STRING FORMAT '999999')), 4) = '2020') AS LJ
   FULL JOIN (SELECT ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING FORMAT '999999')), 4) AS BIGNUMERIC), 0) AS
     business_year,
     cy_month AS booking_month,
     cost_center,
     employee_subgroup,
     employee_inflow
    FROM ldl_s_conl_workbench.t_i_hr_employee_inflow
    WHERE RIGHT(TRIM(cost_center), 4) IN ('9628', '9648', '9668', '9698')
     AND LEFT(TRIM(CAST(cy_month AS STRING FORMAT '999999')), 4) = '2019') AS VJ ON LJ.business_year = VJ.business_year
        + 1 AND LJ.booking_month = VJ.booking_month + 100 AND LJ.cost_center = VJ.cost_center AND LJ.employee_subgroup =
     VJ.employee_subgroup
  GROUP BY business_year,
   booking_month,
   cost_center,
   employee_subgroup) AS INF
 FULL JOIN (SELECT COALESCE(LJ.business_year, VJ.business_year + 1) AS business_year,
   COALESCE(LJ.booking_month, VJ.booking_month + 100) AS booking_month,
   COALESCE(LJ.cost_center, VJ.cost_center) AS cost_center,
   COALESCE(LJ.employee_subgroup, VJ.employee_subgroup) AS employee_subgroup,
   SUM(LJ.employee_outflow) AS outflow_lj,
   SUM(LJ.employee_outflow) AS outflow_vj
  FROM (SELECT ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING FORMAT '999999')), 4) AS BIGNUMERIC), 0) AS business_year,
     cy_month AS booking_month,
     cost_center,
     employee_subgroup,
     employee_outflow
    FROM ldl_s_conl_workbench.t_i_hr_employee_outflow
    WHERE RIGHT(TRIM(cost_center), 4) IN ('9628', '9648', '9668', '9698')
     AND LEFT(TRIM(CAST(cy_month AS STRING FORMAT '999999')), 4) = '2020') AS LJ
   FULL JOIN (SELECT ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING FORMAT '999999')), 4) AS BIGNUMERIC), 0) AS
     business_year,
     cy_month AS booking_month,
     cost_center,
     employee_subgroup,
     employee_outflow
    FROM ldl_s_conl_workbench.t_i_hr_employee_outflow
    WHERE RIGHT(TRIM(cost_center), 4) IN ('9628', '9648', '9668', '9698')
     AND LEFT(TRIM(CAST(cy_month AS STRING FORMAT '999999')), 4) = '2019') AS VJ ON LJ.business_year = VJ.business_year
        + 1 AND LJ.booking_month = VJ.booking_month + 100 AND LJ.cost_center = VJ.cost_center AND LJ.employee_subgroup =
     VJ.employee_subgroup
  GROUP BY business_year,
   booking_month,
   cost_center,
   employee_subgroup) AS OUTF ON INF.business_year = OUTF.business_year AND INF.booking_month = OUTF.booking_month AND
    INF.cost_center = OUTF.cost_center AND INF.employee_subgroup = OUTF.employee_subgroup;