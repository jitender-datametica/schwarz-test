/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_STORAGE_TEST_RESULT_SUB_ITEMGROUP_2
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_MAT_AGG_STORAGE_TEST_RESULT_SUB_ITEMGROUP_2
(
  storage_test_exec_sid 
 ,storage_test_result_grp_sid
 ,storage_test_result_grp_type_cd
 ,test_week
 ,item_grp_int_sid
 ,itemgroup_int_id
 ,itemgroup_int_desc
 ,sub_item_grp_sid
 ,subitemgroup_id
 ,subitemgroup_desc
 

 ,sales_net_val
 ,sales_net_val_pv
 ,sales_qty_work_time_hr
 ,writeoff_net_val
 ,writeoff_net_pct
 
 ,sales_net_val_contr
 ,sales_net_val_pv_contr
 ,sales_qty_work_time_hr_contr
 ,writeoff_net_val_contr
 ,writeoff_net_pct_contr

 ,sales_net_val_spread
 ,sales_net_val_pv_spread
 ,sales_qty_work_time_hr_spread
 ,writeoff_net_val_spread
 ,writeoff_net_pct_spread
 
 ,sales_net_val_effect
 ,sales_net_val_pv_effect
 ,sales_qty_work_time_hr_effect
 ,writeoff_net_val_effect
 ,writeoff_net_pct_effect
)
AS
WITH grp 
AS(
SELECT storage_test_result_grp_sid
		,storage_test_result_grp_type_cd 
		,test_week
		,grp.item_grp_int_sid
		,src_itemgrp_int_cd
		,item_grp_int_name
		,grp.sub_item_grp_sid
		,sb_int.src_subitemgrp_cd
		,sb_int.sub_item_grp_name
		,CASE WHEN storage_test_promo_type_cd = '-' THEN 'all' ELSE storage_test_promo_type_cd END AS storage_test_promo_type_cd
		,user_defined_grp_name
	     FROM p_lew_core.t_storage_test_result_group_2 grp
	INNER JOIN p_lew_core.t_itemgroup_international_2 ig_int 
	       ON grp.item_grp_int_sid = ig_int.item_grp_int_sid
	INNER JOIN p_lew_core.t_subitemgroup_2 sb_int 
	       ON grp.sub_item_grp_sid = sb_int.sub_item_grp_sid 
	WHERE  sb_int.SRC_SUBITEMGRP_CD IS NOT NULL
      AND UPPER(storage_test_result_grp_type_cd) = UPPER( 'ItemGroup_2')
	  )
SELECT   storage_test_exec_sid 
		,storage_test_result_grp_sid
		,storage_test_result_grp_type_cd 
		,test_week
		,item_grp_int_sid
		,itemgroup_int_id
		,itemgroup_int_desc
		,sub_item_grp_sid
		,subitemgroup_id
		,subitemgroup_desc
	--	,storage_test_promo_type_cd

		, MAX ($11) AS sales_net_val
		, MAX ($12) AS sales_net_val_pv
		, MAX ($13) AS sales_qty_work_time_hr
		, MAX ($14) AS writeoff_net_val
		, MAX ($15) AS writeoff_net_pct
		, MAX ($16) AS sales_net_val_contr
		, MAX ($17) AS sales_net_val_pv_contr
		, MAX ($18) AS sales_qty_work_time_hr_contr
		, MAX ($19) AS writeoff_net_val_contr
		, MAX ($20) AS writeoff_net_pct_contr
		, MAX ($21) AS sales_net_val_spread
		, MAX ($22) AS sales_net_val_pv_spread
		, MAX ($23) AS sales_qty_work_time_hr_spread
		, MAX ($24) AS writeoff_net_val_spread
		, MAX ($25) AS writeoff_net_pct_spread


		, sales_net_val - sales_net_val_contr                        AS sales_net_val_effect
		, sales_net_val_pv - sales_net_val_pv_contr                  AS sales_net_val_pv_effect
		, sales_qty_work_time_hr - sales_qty_work_time_hr_contr      AS sales_qty_work_time_hr_effect
		, writeoff_net_val - writeoff_net_val_contr                  AS writeoff_net_val_effect
		, writeoff_net_pct - writeoff_net_pct_contr                  AS writeoff_net_pct_effect


FROM 
( SELECT storage_test_exec_sid 
,tr.storage_test_result_grp_sid 
,storage_test_result_grp_type_cd 
,test_week
,item_grp_int_sid
,src_itemgrp_int_cd                 AS itemgroup_int_id
,item_grp_int_name                  AS itemgroup_int_desc
,sub_item_grp_sid                   AS sub_item_grp_sid
,src_subitemgrp_cd                  AS subitemgroup_id
,sub_item_grp_name                  AS subitemgroup_desc
--,storage_test_promo_type_cd
--,user_defined_grp_name
,actual_val 
,anticipated_val
,spread_pct
,storage_test_metric_type_cd 
,storage_test_metric_type_cd||'_contr'  AS storage_test_metric_type_cd1
,storage_test_metric_type_cd||'_spread' AS storage_test_metric_type_cd2
FROM p_lew_core.t_storage_test_result_2 tr
INNER JOIN grp 
ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
WHERE storage_test_metric_type_cd IN ('Net_Sales' , 'Sales_Calculation', 'Sales_Quantity' , 'Writeoff', 'Relative_Writeoff')
) AS src
PIVOT (
    SUM (actual_val) 
    FOR storage_test_metric_type_cd IN ('Net_Sales' , 'Sales_Calculation', 'Sales_Quantity' , 'Writeoff', 'Relative_Writeoff')
) AS pvt1
PIVOT (
    SUM (anticipated_val) 
    FOR storage_test_metric_type_cd1 IN ('Net_Sales_contr' , 'Sales_Calculation_contr', 'Sales_Quantity_contr' , 'Writeoff_contr', 'Relative_Writeoff_contr')
) AS pvt1
PIVOT (
    MAX(spread_pct) 
    FOR storage_test_metric_type_cd2 IN ('Net_Sales_spread' , 'Sales_Calculation_spread', 'Sales_Quantity_spread' , 'Writeoff_spread', 'Relative_Writeoff_spread')
) AS pvt1
WHERE TEST_WEEK=-1
GROUP BY  1, 2,3,4,5,6,7,8,9,10
;
