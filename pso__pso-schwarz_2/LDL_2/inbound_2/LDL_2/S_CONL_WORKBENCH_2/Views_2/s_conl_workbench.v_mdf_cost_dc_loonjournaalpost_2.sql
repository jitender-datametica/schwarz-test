CREATE OR REPLACE VIEW s_conl_workbench.v_mdf_cost_dc_loonjournaalpost_2
AS
(SELECT
x.business_year,
x.booking_month,
x.warehouse_nr,
x.warehouse_desc_short,
x.warehouse_desc,
x.account_number,
x.cost_center_desc,
x.cost_center,
x.pay_component,
x.cost_component_desc,
x.saldo_amount_LJ,
x.saldo_amount_VJ
FROM
(SELECT
coalesce(LJ.business_year,VJ.business_year+1) as business_year,
coalesce(LJ.booking_month,VJ.booking_month+100) as booking_month,
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
CASE
WHEN left(coalesce(LJ.cost_center,VJ.cost_center),2) ='10' THEN 'HEE'
WHEN left(coalesce(LJ.cost_center,VJ.cost_center),2) ='20' THEN 'ETT'
WHEN left(coalesce(LJ.cost_center,VJ.cost_center),2) ='30' THEN 'OOS'
WHEN left(coalesce(LJ.cost_center,VJ.cost_center),2) ='31' THEN 'OOS'
WHEN left(coalesce(LJ.cost_center,VJ.cost_center),2) ='40' THEN 'ZWA'
WHEN left(coalesce(LJ.cost_center,VJ.cost_center),2) ='41' THEN 'ZWA'
WHEN left(coalesce(LJ.cost_center,VJ.cost_center),2) ='50' THEN 'WEE'
WHEN left(coalesce(LJ.cost_center,VJ.cost_center),2) ='60' THEN 'WAD'
WHEN left(coalesce(LJ.cost_center,VJ.cost_center),2) ='90' THEN 'TIE'
else 'Unknown' END as warehouse_desc_short,
CASE
WHEN left(coalesce(LJ.cost_center,VJ.cost_center),2) ='10' THEN 'Heerenveen'
WHEN left(coalesce(LJ.cost_center,VJ.cost_center),2) ='20' THEN 'Etten-Leur'
WHEN left(coalesce(LJ.cost_center,VJ.cost_center),2) ='30' THEN 'Oosterhout'
WHEN left(coalesce(LJ.cost_center,VJ.cost_center),2) ='31' THEN 'Oosterhout'
WHEN left(coalesce(LJ.cost_center,VJ.cost_center),2) ='40' THEN 'Zwaag'
WHEN left(coalesce(LJ.cost_center,VJ.cost_center),2) ='41' THEN 'Zwaag'
WHEN left(coalesce(LJ.cost_center,VJ.cost_center),2) ='50' THEN 'Weert'
WHEN left(coalesce(LJ.cost_center,VJ.cost_center),2) ='60' THEN 'Waddinxveen'
WHEN left(coalesce(LJ.cost_center,VJ.cost_center),2) ='90' THEN 'Tiel'
else 'Unknown' END as warehouse_desc,
coalesce(LJ.account_number,VJ.account_number) as account_number,
coalesce(LJ.cost_center_desc,VJ.cost_center_desc)  as cost_center_desc,
coalesce(LJ.cost_center,VJ.cost_center) as cost_center,
coalesce(LJ.pay_component,VJ.pay_component) as pay_component,
coalesce(LJ.cost_component_desc,VJ.cost_component_desc) as cost_component_desc,
sum(LJ.saldo_amount) as saldo_amount_LJ,
sum(VJ.saldo_amount) as saldo_amount_VJ
FROM
(SELECT
CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END as business_year,
to_number(cy_month) as booking_month,
account_number,
cost_center_desc,
cost_center,
pay_component,
cost_component_desc,
saldo_amount
FROM s_conl_workbench.v_cost_loonjournal_post_2
where 1=1
  --and cy_month like '%2020%'
  and
CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END  =2021
and right(cost_center,4) in ('9648','9668') -- het was  ('9628','9648','9668','9698')
) as LJ
full outer join
(SELECT
CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END as business_year,
to_number(cy_month) as booking_month,
account_number,
cost_center_desc,
cost_center,
pay_component,
cost_component_desc,
saldo_amount
FROM s_conl_workbench.v_cost_loonjournal_post_2
WHERE 1=1
  and CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END = 2020
and right(cost_center,4) in ('9648','9668') -- het was  ('9628','9648','9668','9698')
) as VJ
on LJ.business_year=VJ.business_year+1
and LJ.booking_month=VJ.booking_month+100
and LJ.account_number=VJ.account_number
and LJ.cost_center_desc=VJ.cost_center_desc
and LJ.cost_center=VJ.cost_center
and LJ.pay_component=VJ.pay_component
and LJ.cost_component_desc=VJ.cost_component_desc
WHERE 1=1
GROUP BY
coalesce(LJ.business_year,VJ.business_year+1)
,coalesce(LJ.booking_month,VJ.booking_month+100)
,coalesce(LJ.account_number,VJ.account_number)
,coalesce(LJ.cost_center_desc,VJ.cost_center_desc)
,coalesce(LJ.cost_center,VJ.cost_center)
,coalesce(LJ.pay_component,VJ.pay_component)
,coalesce(LJ.cost_component_desc,VJ.cost_component_desc)
) as X
join
(SELECT
CASE
WHEN to_number(right(cy_month,2)) <=2 THEN cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/-1
else cast(TRUNC(left(cy_month,4)) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END as business_year,
max(TO_NUMBER(cy_month)) as  max_month
FROM s_conl_workbench.v_cost_loonjournal_post_2
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


