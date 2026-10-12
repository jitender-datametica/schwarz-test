CREATE OR REPLACE VIEW s_conl_workbench.v_g_employee_fluctuation_1
AS
(SELECT
orig_store_nr,
cy_month,
SUM(employee_inflow_teammanager) as employee_inflow_teammanager,
SUM(employee_inflow_medewerker) as employee_inflow_medewerker,
SUM(employee_inflow_hulpkracht) as employee_inflow_hulpkracht,
SUM(employee_outflow_teammanager) as employee_outflow_teammanager,
SUM(employee_outflow_medewerker) as employee_outflow_medewerker,
SUM(employee_outflow_hulpkracht) as employee_outflow_hulpkracht
FROM
(SELECT

inf.orig_store_nr,
inf.employee_subgroup,
inf.cy_month,
/* instroom*/
CASE
WHEN inf.employee_subgroup = '5C' THEN inf.employee_inflow
ELSE 0 END as employee_inflow_teammanager,
CASE
WHEN inf.employee_subgroup = '6B' THEN inf.employee_inflow
ELSE 0 END as employee_inflow_medewerker,
CASE
WHEN inf.employee_subgroup = '6H' THEN inf.employee_inflow
ELSE 0 END as employee_inflow_hulpkracht,
/* uitstroom*/
CASE
WHEN outf.employee_subgroup = '5C' THEN outf.employee_outflow
ELSE 0 END as employee_outflow_teammanager,
CASE
WHEN outf.employee_subgroup = '6B' THEN outf.employee_outflow
ELSE 0 END as employee_outflow_medewerker,
CASE
WHEN outf.employee_subgroup = '6H' THEN outf.employee_outflow
ELSE 0 END as employee_outflow_hulpkracht
FROM s_conl_workbench.v_employee_inflow_1 inf

LEFT JOIN s_conl_workbench.v_employee_outflow_1 outf
ON inf.orig_store_nr = outf.orig_store_nr
AND inf.cy_month = outf.cy_month
AND inf.employee_subgroup = outf.employee_subgroup

WHERE 1=1
AND LENGTH(inf.orig_store_nr) > 3
AND inf.employee_subgroup in ('5C','6B','6H')
) as fluctuation
GROUP BY orig_store_nr, cy_month
);


