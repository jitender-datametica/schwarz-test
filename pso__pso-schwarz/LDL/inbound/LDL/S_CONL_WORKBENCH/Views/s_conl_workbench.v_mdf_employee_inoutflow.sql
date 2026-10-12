CREATE OR REPLACE VIEW s_conl_workbench.v_mdf_employee_inoutflow
AS
(SELECT
coalesce(INF.business_year,OUTF.business_year) as business_year,
coalesce(INF.booking_month,OUTF.booking_month) as booking_month,
CASE
WHEN SUBSTR( coalesce(INF.cost_center,OUTF.cost_center), 1, 2) = '10' THEN 1
WHEN SUBSTR( coalesce(INF.cost_center,OUTF.cost_center), 1, 2) = '20' THEN 2
WHEN SUBSTR( coalesce(INF.cost_center,OUTF.cost_center), 1, 2) = '30' THEN 3
WHEN SUBSTR( coalesce(INF.cost_center,OUTF.cost_center), 1, 2) = '31' THEN 3
WHEN SUBSTR( coalesce(INF.cost_center,OUTF.cost_center), 1, 2) = '40' THEN 4
WHEN SUBSTR( coalesce(INF.cost_center,OUTF.cost_center), 1, 2) = '41' THEN 4
WHEN SUBSTR( coalesce(INF.cost_center,OUTF.cost_center), 1, 2) = '50' THEN 5
WHEN SUBSTR( coalesce(INF.cost_center,OUTF.cost_center), 1, 2) = '60' THEN 6
WHEN SUBSTR( coalesce(INF.cost_center,OUTF.cost_center), 1, 2) = '90' THEN 9
else 99 END as warehouse_nr,
CASE
WHEN left(coalesce(INF.cost_center,OUTF.cost_center),2) ='10' THEN 'HEE'
WHEN left(coalesce(INF.cost_center,OUTF.cost_center),2) ='20' THEN 'ETT'
WHEN left(coalesce(INF.cost_center,OUTF.cost_center),2) ='30' THEN 'OOS'
WHEN left(coalesce(INF.cost_center,OUTF.cost_center),2) ='31' THEN 'OOS'
WHEN left(coalesce(INF.cost_center,OUTF.cost_center),2) ='40' THEN 'ZWA'
WHEN left(coalesce(INF.cost_center,OUTF.cost_center),2) ='41' THEN 'ZWA'
WHEN left(coalesce(INF.cost_center,OUTF.cost_center),2) ='50' THEN 'WEE'
WHEN left(coalesce(INF.cost_center,OUTF.cost_center),2) ='60' THEN 'WAD'
WHEN left(coalesce(INF.cost_center,OUTF.cost_center),2) ='90' THEN 'TIE'
else 'Unknown' END as warehouse_desc_short,
CASE
WHEN left(coalesce(INF.cost_center,OUTF.cost_center),2) ='10' THEN 'Heerenveen'
WHEN left(coalesce(INF.cost_center,OUTF.cost_center),2) ='20' THEN 'Etten-Leur'
WHEN left(coalesce(INF.cost_center,OUTF.cost_center),2) ='30' THEN 'Oosterhout'
WHEN left(coalesce(INF.cost_center,OUTF.cost_center),2) ='31' THEN 'Oosterhout'
WHEN left(coalesce(INF.cost_center,OUTF.cost_center),2) ='40' THEN 'Zwaag'
WHEN left(coalesce(INF.cost_center,OUTF.cost_center),2) ='41' THEN 'Zwaag'
WHEN left(coalesce(INF.cost_center,OUTF.cost_center),2) ='50' THEN 'Weert'
WHEN left(coalesce(INF.cost_center,OUTF.cost_center),2) ='60' THEN 'Waddinxveen'
WHEN left(coalesce(INF.cost_center,OUTF.cost_center),2) ='90' THEN 'Tiel'
else 'Unknown' END as warehouse_desc,
coalesce(INF.cost_center,OUTF.cost_center) as cost_center,
coalesce(INF.employee_subgroup,OUTF.employee_subgroup) as employee_subgroup,
INF.inflow_lj,
INF.inflow_vj,
OUTF.outflow_lj,
OUTF.outflow_vj
FROM
(SELECT
coalesce(LJ.business_year,VJ.business_year+1) as business_year,
coalesce(LJ.booking_month,VJ.booking_month+100) as booking_month,
coalesce(LJ.cost_center,VJ.cost_center) as cost_center,
coalesce(LJ.employee_subgroup,VJ.employee_subgroup) as employee_subgroup,
sum(LJ.employee_inflow) as inflow_lj,
sum(LJ.employee_inflow) as inflow_vj
FROM
(SELECT
to_number(left(trim(to_char(cy_month,'999999')),4)) as business_year,
cy_month as booking_month,
cost_center,
employee_subgroup,
employee_inflow
FROM s_conl_workbench.t_i_hr_employee_inflow
where 1=1
and right(trim(cost_center),4) in ('9628','9648','9668','9698')
and left(trim(to_char(cy_month,'999999')),4)='2020'
) as LJ
full outer join
(SELECT
to_number(left(trim(to_char(cy_month,'999999')),4)) as business_year,
cy_month as booking_month,
cost_center,
employee_subgroup,
employee_inflow
FROM s_conl_workbench.t_i_hr_employee_inflow
where 1=1
and right(trim(cost_center),4) in ('9628','9648','9668','9698')
and left(trim(to_char(cy_month,'999999')),4)='2019'
) as VJ
ON  LJ.business_year=VJ.business_year+1
and	LJ.booking_month=VJ.booking_month+100
and LJ.cost_center=VJ.cost_center
and LJ.employee_subgroup=VJ.employee_subgroup
WHERE 1=1
group by
        coalesce(LJ.business_year,VJ.business_year+1)
	   ,coalesce(LJ.booking_month,VJ.booking_month+100)
	   ,coalesce(LJ.cost_center,VJ.cost_center)
	   ,coalesce(LJ.employee_subgroup,VJ.employee_subgroup)
) as INF
FULL OUTER JOIN
(SELECT
coalesce(LJ.business_year,VJ.business_year+1) as business_year,
coalesce(LJ.booking_month,VJ.booking_month+100) as booking_month,
coalesce(LJ.cost_center,VJ.cost_center) as cost_center,
coalesce(LJ.employee_subgroup,VJ.employee_subgroup) as employee_subgroup,
sum(LJ.employee_outflow) as outflow_lj,
sum(LJ.employee_outflow) as outflow_vj
FROM
(SELECT
to_number(left(trim(to_char(cy_month,'999999')),4)) as business_year,
cy_month as booking_month,
cost_center,
employee_subgroup,
employee_outflow
FROM s_conl_workbench.t_i_hr_employee_outflow
where 1=1
and right(trim(cost_center),4) in ('9628','9648','9668','9698')
and left(trim(to_char(cy_month,'999999')),4)='2020'
) as LJ
full outer join
(SELECT
to_number(left(trim(to_char(cy_month,'999999')),4)) as business_year,
cy_month as booking_month,
cost_center,
employee_subgroup,
employee_outflow
FROM s_conl_workbench.t_i_hr_employee_outflow
where 1=1
and right(trim(cost_center),4) in ('9628','9648','9668','9698')
and left(trim(to_char(cy_month,'999999')),4)='2019'
) as VJ
ON  LJ.business_year=VJ.business_year+1
and	LJ.booking_month=VJ.booking_month+100
and LJ.cost_center=VJ.cost_center
and LJ.employee_subgroup=VJ.employee_subgroup
WHERE 1=1
group by
        coalesce(LJ.business_year,VJ.business_year+1)
	   ,coalesce(LJ.booking_month,VJ.booking_month+100)
	   ,coalesce(LJ.cost_center,VJ.cost_center)
	   ,coalesce(LJ.employee_subgroup,VJ.employee_subgroup)
) as OUTF
ON  INF.business_year=OUTF.business_year
and	INF.booking_month=OUTF.booking_month
and INF.cost_center=OUTF.cost_center
and INF.employee_subgroup=OUTF.employee_subgroup
);


