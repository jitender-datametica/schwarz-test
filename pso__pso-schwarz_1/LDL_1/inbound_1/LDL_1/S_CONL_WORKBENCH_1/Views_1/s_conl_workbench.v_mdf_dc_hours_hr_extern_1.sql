CREATE OR REPLACE VIEW s_conl_workbench.v_mdf_dc_hours_hr_extern_1
AS
(SELECT
x.business_year,
x.booking_month,
x.warehouse_nr,
x.cost_center,
x.hours_external_lj,
x.hours_external_vj
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
CAST(sum(lj.hours_external) AS Number(38,5)) as hours_external_lj,
CAST(sum(vj.hours_external) AS Number(38,5)) as hours_external_vj
FROM
(SELECT
CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END as business_year,
TO_NUMBER(cy_month) as  booking_month,
cost_center,
CAST(sum(hours_external) AS Number(38,5)) as hours_external
FROM s_conl_workbench.t_i_wh_hours_external_1
where 1=1
      and right(cost_center,4) in ('9648','9668') -- was ('9628','9648','9668','9698')
      and CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END =(SELECT
Y.max_year
FROM
(SELECT
max(CASE
WHEN to_number(right(trim(to_char(cy_month)),2)) <=2 THEN cast(TRUNC(to_number(left(trim(to_char(cy_month)),4))-1) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
else cast(TRUNC(to_number(left(trim(to_char(cy_month)),4))) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END) as max_year
FROM s_conl_workbench.v_hr_po_lead_base_1
where 1=1
and right(trim(cost_center),4) in ('9648','9668')) as Y)

group by CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END
, TO_NUMBER(cy_month)
,cost_center
) as LJ
FULL OUTER JOIN
(SELECT
CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END as business_year,
TO_NUMBER(cy_month) as  booking_month,
cost_center,
CAST(sum(hours_external) AS Number(38,5)) as hours_external
FROM s_conl_workbench.t_i_wh_hours_external_1
where 1=1
and right(cost_center,4) in ('9648','9668') -- was ('9628','9648','9668','9698')
and CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END =(SELECT
Y.max_year-1
FROM
(SELECT
max(CASE
WHEN to_number(right(trim(to_char(cy_month)),2)) <=2 THEN cast(TRUNC(to_number(left(trim(to_char(cy_month)),4))-1) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
else cast(TRUNC(to_number(left(trim(to_char(cy_month)),4))) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END) as max_year
FROM s_conl_workbench.v_hr_po_lead_base_1
where 1=1
and right(trim(cost_center),4) in ('9648','9668')) as Y)

group by CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END
, TO_NUMBER(cy_month)
,cost_center
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
) as X
join
(SELECT
max(CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END)as business_year,
max(TO_NUMBER(cy_month)) as  max_month
FROM s_conl_workbench.t_i_wh_hours_external_1
where 1=1
and right(trim(cost_center),4) in ('9648','9668')
) as RPM -- Report month
on  x.business_year  = rpm.business_year
and x.booking_month <= rpm.max_month
);


