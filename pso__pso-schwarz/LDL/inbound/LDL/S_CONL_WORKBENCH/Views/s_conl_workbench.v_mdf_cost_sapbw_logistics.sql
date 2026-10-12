CREATE OR REPLACE VIEW s_conl_workbench.v_mdf_cost_sapbw_logistics
AS
(SELECT
CASE
WHEN coalesce(trim(LJ.inat_account_number2),trim(VJ.inat_account_number2))
in ('307K865200','307K857120','3403360000','3406110000','3406130000','3406110000','3406130000','3408130000','3408140000','3408220000') THEN 'Y'
WHEN coalesce(LJ.corporate_division_id,VJ.corporate_division_id) ='G' THEN 'Y'
else 'N' END as warehouse_reporting_data,
coalesce(LJ.business_year,VJ.business_year+1) as business_year,
coalesce(LJ.booking_month,VJ.booking_month+100) as booking_month,
coalesce(LJ.corporate_division_id,VJ.corporate_division_id) as corporate_division_id,
coalesce(LJ.corporate_division_desc,VJ.corporate_division_desc)  as corporate_division_desc,
coalesce(LJ.warehouse_nr,VJ.warehouse_nr) as warehouse_nr,
coalesce(LJ.warehouse_desc_short,VJ.warehouse_desc_short) as warehouse_desc_short,
coalesce(LJ.warehouse_desc,VJ.warehouse_desc) as warehouse_desc,
coalesce(LJ.cost_center,VJ.cost_center) as cost_center,
coalesce(LJ.referencekey,VJ.referencekey) as referencekey,
coalesce(LJ.cost_category,VJ.cost_category) as cost_category,
coalesce(LJ.nat_account_type,VJ.nat_account_type) as nat_account_type,
coalesce(LJ.nat_account_number,VJ.nat_account_number) as nat_account_number,
coalesce(LJ.nat_account_desc,VJ.nat_account_desc) as nat_account_desc,
coalesce(LJ.inat_account_number2,VJ.inat_account_number2) as inat_account_number2,
coalesce(LJ.inat_account_desc2,VJ.inat_account_desc2) as inat_account_desc2,
coalesce(LJ.inat_account_number,VJ.inat_account_number) as inat_account_number,
coalesce(LJ.inat_account_desc,VJ.inat_account_desc) as inat_account_desc,
sum(LJ.value_costs) as costs_LJ,
sum(VJ.value_costs) as costs_VJ
FROM
(SELECT
business_year,
booking_month,
corporate_division_id,
corporate_division_desc,
CASE
WHEN warehouse_desc_short ='HEE' THEN 1
WHEN warehouse_desc_short ='ETT' THEN 2
WHEN warehouse_desc_short ='OOS' THEN 3
WHEN warehouse_desc_short ='ZWA' THEN 4
WHEN warehouse_desc_short ='WEE' THEN 5
WHEN warehouse_desc_short ='WAD' THEN 6
WHEN warehouse_desc_short ='TIE' THEN 9
else 9 END as warehouse_nr,
CASE
WHEN warehouse_desc_short not in ('HEE','ETT','OOS','ZWA','WEE','WAD','TIE') THEN 'TIE'
else warehouse_desc_short END as warehouse_desc_short,
CASE
WHEN warehouse_desc_short not in ('HEE','ETT','OOS','ZWA','WEE','WAD','TIE') THEN 'Tiel'
else warehouse_desc END as warehouse_desc,
cost_center,
referencekey,
cost_category,
CASE
WHEN CONTAINS( upper(nat_account_desc), 'KALK') THEN 'Gecalculeerd'
else 'Gefactureerd' END as nat_account_type,
nat_account_number,
nat_account_desc,
inat_account_number2,
inat_account_desc2,
inat_account_number,
inat_account_desc,
sum(value_costs) as value_costs
FROM s_conl_workbench.t_i_cost_sapbw_logistics
 where business_year=2021
   --and right(trim(cost_center),4) in ('9628','9648','9668','9698')
 group by
        business_year
       ,booking_month
       ,corporate_division_id
       ,corporate_division_desc
       , CASE
WHEN warehouse_desc_short ='HEE' THEN 1
WHEN warehouse_desc_short ='ETT' THEN 2
WHEN warehouse_desc_short ='OOS' THEN 3
WHEN warehouse_desc_short ='ZWA' THEN 4
WHEN warehouse_desc_short ='WEE' THEN 5
WHEN warehouse_desc_short ='WAD' THEN 6
WHEN warehouse_desc_short ='TIE' THEN 9
else 9 END
      , CASE
WHEN warehouse_desc_short not in ('HEE','ETT','OOS','ZWA','WEE','WAD','TIE') THEN 'TIE'
else warehouse_desc_short END
, CASE
WHEN warehouse_desc_short not in ('HEE','ETT','OOS','ZWA','WEE','WAD','TIE') THEN 'Tiel'
else warehouse_desc END
,cost_center
,referencekey
,cost_category
, CASE
WHEN CONTAINS( upper(nat_account_desc), 'KALK') THEN 'Gecalculeerd'
else 'Gefactureerd' END
      ,nat_account_number
      ,nat_account_desc
      ,inat_account_number2
      ,inat_account_desc2
      ,inat_account_number
      ,inat_account_desc
      ) as LJ
full outer join
(SELECT
business_year,
booking_month,
corporate_division_id,
corporate_division_desc,
CASE
WHEN warehouse_desc_short ='HEE' THEN 1
WHEN warehouse_desc_short ='ETT' THEN 2
WHEN warehouse_desc_short ='OOS' THEN 3
WHEN warehouse_desc_short ='ZWA' THEN 4
WHEN warehouse_desc_short ='WEE' THEN 5
WHEN warehouse_desc_short ='WAD' THEN 6
WHEN warehouse_desc_short ='TIE' THEN 9
else 9 END as warehouse_nr,
CASE
WHEN warehouse_desc_short not in ('HEE','ETT','OOS','ZWA','WEE','WAD','TIE') THEN 'TIE'
else warehouse_desc_short END as warehouse_desc_short,
CASE
WHEN warehouse_desc_short not in ('HEE','ETT','OOS','ZWA','WEE','WAD','TIE') THEN 'Tiel'
else warehouse_desc END as warehouse_desc,
cost_center,
referencekey,
cost_category,
CASE
WHEN CONTAINS( upper(nat_account_desc), 'KALK') THEN 'Gecalculeerd'
else 'Gefactureerd' END as nat_account_type,
nat_account_number,
nat_account_desc,
inat_account_number2,
inat_account_desc2,
inat_account_number,
inat_account_desc,
sum(value_costs) as value_costs
FROM s_conl_workbench.t_i_cost_sapbw_logistics
 where business_year=2020
    --and right(trim(cost_center),4) in ('9628','9648','9668','9698')
 group by
        business_year
       ,booking_month
       ,corporate_division_id
       ,corporate_division_desc
       , CASE
WHEN warehouse_desc_short ='HEE' THEN 1
WHEN warehouse_desc_short ='ETT' THEN 2
WHEN warehouse_desc_short ='OOS' THEN 3
WHEN warehouse_desc_short ='ZWA' THEN 4
WHEN warehouse_desc_short ='WEE' THEN 5
WHEN warehouse_desc_short ='WAD' THEN 6
WHEN warehouse_desc_short ='TIE' THEN 9
else 9 END
      , CASE
WHEN warehouse_desc_short not in ('HEE','ETT','OOS','ZWA','WEE','WAD','TIE') THEN 'TIE'
else warehouse_desc_short END
, CASE
WHEN warehouse_desc_short not in ('HEE','ETT','OOS','ZWA','WEE','WAD','TIE') THEN 'Tiel'
else warehouse_desc END
,cost_center
,referencekey
,cost_category
, CASE
WHEN CONTAINS( upper(nat_account_desc), 'KALK') THEN 'Gecalculeerd'
else 'Gefactureerd' END
      ,nat_account_number
      ,nat_account_desc
      ,inat_account_number2
      ,inat_account_desc2
      ,inat_account_number
      ,inat_account_desc
) as VJ
on
LJ.business_year=VJ.business_year+1
and LJ.booking_month=VJ.booking_month+100
and LJ.warehouse_nr=VJ.warehouse_nr
and LJ.warehouse_desc_short=VJ.warehouse_desc_short
and LJ.corporate_division_id=VJ.corporate_division_id
and LJ.nat_account_number = VJ.nat_account_number
and LJ.inat_account_number = VJ.inat_account_number
and LJ.inat_account_number2 = VJ.inat_account_number2
and LJ.referencekey= VJ.referencekey
and LJ.cost_category = VJ.cost_category
and LJ.cost_center= VJ.cost_center
where 1 = 1
group by CASE
WHEN coalesce(trim(LJ.inat_account_number2),trim(VJ.inat_account_number2))
in ('307K865200','307K857120','3403360000','3406110000','3406130000','3406110000','3406130000','3408130000','3408140000','3408220000') THEN 'Y'
WHEN coalesce(LJ.corporate_division_id,VJ.corporate_division_id) ='G' THEN 'Y'
else 'N' END
,coalesce(LJ.business_year,VJ.business_year+1)
,coalesce(LJ.booking_month,VJ.booking_month+100)
,coalesce(LJ.corporate_division_id,VJ.corporate_division_id)
,coalesce(LJ.corporate_division_desc,VJ.corporate_division_desc)
,coalesce(LJ.warehouse_nr,VJ.warehouse_nr)
,coalesce(LJ.warehouse_desc_short,VJ.warehouse_desc_short)
,coalesce(LJ.warehouse_desc,VJ.warehouse_desc)
,coalesce(LJ.cost_center,VJ.cost_center)
,coalesce(LJ.referencekey,VJ.referencekey)
,coalesce(LJ.cost_category,VJ.cost_category)
,coalesce(LJ.nat_account_type,VJ.nat_account_type)
,coalesce(LJ.nat_account_number,VJ.nat_account_number)
,coalesce(LJ.nat_account_desc,VJ.nat_account_desc)
,coalesce(LJ.inat_account_number2,VJ.inat_account_number2)
,coalesce(LJ.inat_account_desc2,VJ.inat_account_desc2)
,coalesce(LJ.inat_account_number,VJ.inat_account_number)
,coalesce(LJ.inat_account_desc,VJ.inat_account_desc)
having warehouse_reporting_data ='Y'
);


