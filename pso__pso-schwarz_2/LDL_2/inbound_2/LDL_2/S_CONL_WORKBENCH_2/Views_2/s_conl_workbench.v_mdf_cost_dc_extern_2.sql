CREATE OR REPLACE VIEW s_conl_workbench.v_mdf_cost_dc_extern_2
AS
(SELECT
x.business_year,
 x.booking_month,
 x.warehouse_nr,
 x.cost_center,
 x.cost_component_desc,
 x.saldo_amount_lj,
 x.saldo_amount_vj
 FROM
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
coalesce(lj.cost_component_desc,vj.cost_component_desc) as cost_component_desc,
sum(lj.saldo_amount) as saldo_amount_lj,
sum(vj.saldo_amount) as saldo_amount_vj
FROM
(SELECT
CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END as business_year,
TO_NUMBER(cy_month) as  booking_month,
cost_center,
cost_component_desc,
saldo_amount*(1) as saldo_amount
FROM s_conl_workbench.v_cost_extern_2
where left(cy_month,4)='2021'
and right(cost_center,4) in ('9648','9668') -- het was  ('9628','9648','9668','9698')
) as LJ
full outer join
(SELECT
CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END as business_year,
TO_NUMBER(cy_month) as  booking_month,
cost_center,
cost_component_desc,
saldo_amount*(1) as saldo_amount
FROM s_conl_workbench.v_cost_extern_2
where left(cy_month,4)='2020'
and right(cost_center,4) in ('9648','9668') -- het was  ('9628','9648','9668','9698')
) as VJ
  on lj.business_year = vj.business_year+1
 and lj.booking_month = vj.booking_month+100
 and lj.cost_center= vj.cost_center
where 1=1
group by
 coalesce(lj.business_year,vj.business_year+1)
,coalesce(lj.booking_month,vj.booking_month+100)
, CASE
WHEN SUBSTR( coalesce(LJ.cost_center,VJ.cost_center), 1, 2) = '10' THEN 1
WHEN SUBSTR( coalesce(LJ.cost_center,VJ.cost_center), 1, 2) = '20' THEN 2
WHEN SUBSTR( coalesce(LJ.cost_center,VJ.cost_center), 1, 2) = '30' THEN 3
WHEN SUBSTR( coalesce(LJ.cost_center,VJ.cost_center), 1, 2) = '31' THEN 3
WHEN SUBSTR( coalesce(LJ.cost_center,VJ.cost_center), 1, 2) = '40' THEN 4
WHEN SUBSTR( coalesce(LJ.cost_center,VJ.cost_center), 1, 2) = '41' THEN 4
WHEN SUBSTR( coalesce(LJ.cost_center,VJ.cost_center), 1, 2) = '50' THEN 5
WHEN SUBSTR( coalesce(LJ.cost_center,VJ.cost_center), 1, 2) = '60' THEN 6
WHEN SUBSTR( coalesce(LJ.cost_center,VJ.cost_center), 1, 2) = '90' THEN 9
else 99 END
,coalesce(lj.cost_center,vj.cost_center)
,coalesce(lj.cost_component_desc,vj.cost_component_desc)
) as X
join
(SELECT
CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END as business_year,
max(TO_NUMBER(cy_month)) as  max_month
FROM s_conl_workbench.v_cost_extern_2
where 1=1
and CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END ='2021'
and right(cost_center,4) in ('9648','9668') -- het was  ('9628','9648','9668','9698')

group by CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END
) as RPM -- Report month
on  x.business_year  = rpm.business_year
and x.booking_month <= rpm.max_month
);


