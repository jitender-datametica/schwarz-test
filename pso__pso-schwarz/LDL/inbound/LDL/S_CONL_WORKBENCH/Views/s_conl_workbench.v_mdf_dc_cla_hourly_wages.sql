CREATE OR REPLACE VIEW s_conl_workbench.v_mdf_dc_cla_hourly_wages
AS
(SELECT
coalesce(lj.business_year,vj.business_year+1) as business_year,
coalesce(lj.booking_month,vj.booking_month+100) as booking_month,
CASE
WHEN SUBSTR( coalesce(LJ.cost_center,VJ.cost_center), 1, 2) = '10' THEN 1
WHEN SUBSTR( coalesce(LJ.cost_center,VJ.cost_center), 1, 2) = '20' THEN 2
WHEN SUBSTR( coalesce(LJ.cost_center,VJ.cost_center), 1, 2) = '30' THEN 3
WHEN SUBSTR( coalesce(LJ.cost_center,VJ.cost_center), 1, 2) = '31' THEN 3
WHEN SUBSTR( coalesce(LJ.cost_center,VJ.cost_center), 1, 2) = '40' THEN 4
WHEN SUBSTR( coalesce(LJ.cost_center,VJ.cost_center), 1, 2) = '41' THEN 4
WHEN SUBSTR( coalesce(LJ.cost_center,VJ.cost_center), 1, 2) = '50' THEN 5
WHEN SUBSTR( coalesce(LJ.cost_center,VJ.cost_center), 1, 2) = '60' THEN 6
WHEN SUBSTR( coalesce(LJ.cost_center,VJ.cost_center), 1, 2) = '90' THEN 9
else 99 END as warehouse_nr,
coalesce(lj.cost_center,vj.cost_center) as cost_center,
CASE
WHEN lj.CLA_hourly_wage >0 THEN CAST(lj.CLA_hourly_wage AS Number(38,5))
else null END as  CLA_hourly_wage_lj,
CASE
WHEN vj.CLA_hourly_wage >0 THEN CAST(vj.CLA_hourly_wage AS Number(38,5))
else null END as  CLA_hourly_wage_vj
FROM
(SELECT
CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END as business_year,
TO_NUMBER(cy_month) as  booking_month,
orig_store_nr as cost_center,
CASE
WHEN CLA_hourly_wage >0 THEN CAST(CLA_hourly_wage AS Number(38,5))
else null END as  CLA_hourly_wage
FROM s_conl_workbench.v_CLA_hourly_wage
where 1=1
  and right(orig_store_nr,4) in ('9628','9648','9668','9698')
  and left(cy_month,4)='2020'
) as LJ

FULL OUTER JOIN

(SELECT
CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END as business_year,
TO_NUMBER(cy_month) as  booking_month,
orig_store_nr as cost_center,
CASE
WHEN CLA_hourly_wage >0 THEN CAST(CLA_hourly_wage AS Number(38,5))
else null END as  CLA_hourly_wage
FROM s_conl_workbench.v_CLA_hourly_wage
where 1=1
  and right(orig_store_nr,4) in ('9628','9648','9668','9698')
  and left(cy_month,4)='2019'
) as VJ

ON lj.business_year = vj.business_year+1
 and lj.booking_month = vj.booking_month+100
 and lj.cost_center= vj.cost_center
where 1=1
--and coalesce(lj.business_year,vj.business_year+1)=2020
)
;


