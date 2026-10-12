/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_STORAGE_TEST_RESULT_ITEMGROUP_2
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version 
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_MAT_AGG_STORAGE_TEST_RESULT_ITEMGROUP_2(
	 storage_test_exec_sid
	,storage_test_result_grp_sid
	,storage_test_result_grp_type_cd
	,test_week
	,item_grp_int_sid
	,itemgroup_int_id
	,itemgroup_int_desc
	,storage_test_promo_type_cd
	,storage_test_promo_type_cd_sort
	,user_defined_grp_name
	,receipt_avg
	,work_time_hr
	,sales_net_val
	,sales_qty_work_time
	,receipt_cnt
	,sales_net_val_pv
	,sales_qty_work_time_hr
	,writeoff_net_val
	,writeoff_net_pct
	,receipt_avg_contr
	,work_time_hr_contr
	,sales_net_val_contr
	,sales_qty_work_time_contr
	,receipt_cnt_contr
	,sales_net_val_pv_contr
	,sales_qty_work_time_hr_contr
	,writeoff_net_val_contr
	,writeoff_net_pct_contr
	,receipt_avg_spread
	,work_time_hr_spread
	,sales_net_val_spread
	,sales_qty_work_time_spread
	,receipt_cnt_spread
	,sales_net_val_pv_spread
	,sales_qty_work_time_hr_spread
	,writeoff_net_val_spread
	,writeoff_net_pct_spread
	,receipt_avg_effect
	,work_time_hr_effect
	,sales_net_val_effect
	,sales_qty_work_time_effect
	,receipt_cnt_effect
	,sales_net_val_pv_effect
	,sales_qty_work_time_hr_effect
	,writeoff_net_val_effect
	,writeoff_net_pct_effect
) AS
WITH grp 
AS(
SELECT storage_test_result_grp_sid
		,storage_test_result_grp_type_cd 
		,test_week
		,grp.item_grp_int_sid
		,src_itemgrp_int_cd
		,item_grp_int_name
		,CASE WHEN storage_test_promo_type_cd = '-' THEN '' 
		      WHEN storage_test_promo_type_cd = 'normal' THEN 'Sortiment'
              WHEN storage_test_promo_type_cd = 'promo'  THEN 'Aktion_2' END AS storage_test_promo_type_cd
		,user_defined_grp_name
	     FROM p_lew_core.t_storage_test_result_group_2 grp
	INNER JOIN p_lew_core.t_itemgroup_international_2 ig_int 
	       ON grp.item_grp_int_sid = ig_int.item_grp_int_sid
    WHERE UPPER(storage_test_result_grp_type_cd) = UPPER( 'ItemGroup_2')
    AND grp.sub_item_grp_sid = -1 		   
 )
SELECT   storage_test_exec_sid 
		,storage_test_result_grp_sid
		,storage_test_result_grp_type_cd 
		,test_week
		,item_grp_int_sid
		,itemgroup_int_id
		,itemgroup_int_desc
		,storage_test_promo_type_cd
		,CASE WHEN storage_test_promo_type_cd='' THEN 1
		      WHEN storage_test_promo_type_cd = 'Sortiment' THEN 2 
			  WHEN storage_test_promo_type_cd = 'Aktion_2' THEN 3 
			  END                                                 AS storage_test_promo_type_cd_sort
		,user_defined_grp_name
	
        , MAX ($10) AS receipt_avg
		, MAX ($11) AS work_time_hr
		, MAX ($12) AS sales_net_val
		, MAX ($13) AS sales_qty_work_time
		, MAX ($14) AS receipt_cnt
		, MAX ($15) AS sales_net_val_pv
		, MAX ($16) AS sales_qty_work_time_hr
		, MAX ($17) AS writeoff_net_val
		, MAX ($18) AS writeoff_net_pct
		, MAX ($19) AS receipt_avg_contr
		, MAX ($20) AS work_time_hr_contr
		, MAX ($21) AS sales_net_val_contr
		, MAX ($22) AS sales_qty_work_time_contr
		, MAX ($23) AS receipt_cnt_contr
		, MAX ($24) AS sales_net_val_pv_contr
		, MAX ($25) AS sales_qty_work_time_hr_contr
		, MAX ($26) AS writeoff_net_val_contr
		, MAX ($27) AS writeoff_net_pct_contr
		, MAX ($28) AS receipt_avg_spread
		, MAX ($29) AS work_time_hr_spread
		, MAX ($30) AS sales_net_val_spread
		, MAX ($31) AS sales_qty_work_time_spread
		, MAX ($32) AS receipt_cnt_spread
		, MAX ($33) AS sales_net_val_pv_spread
		, MAX ($34) AS sales_qty_work_time_hr_spread
		, MAX ($35) AS writeoff_net_val_spread
		, MAX ($36) AS writeoff_net_pct_spread

        , receipt_avg - receipt_avg_contr                            AS receipt_avg_effect
        , work_time_hr - work_time_hr_contr                          AS work_time_hr_effect
		, sales_net_val - sales_net_val_contr                        AS sales_net_val_effect
		, sales_qty_work_time - sales_qty_work_time_contr            AS sales_qty_work_time_effect
		, receipt_cnt - receipt_cnt_contr                            AS receipt_cnt_effect
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
,src_itemgrp_int_cd                   AS itemgroup_int_id
,item_grp_int_name                    AS itemgroup_int_desc
,storage_test_promo_type_cd
,user_defined_grp_name
,actual_val 
,anticipated_val
,spread_pct
,storage_test_metric_type_cd 
,storage_test_metric_type_cd||'_contr'  AS storage_test_metric_type_cd1
,storage_test_metric_type_cd||'_spread' AS storage_test_metric_type_cd2
FROM p_lew_core.t_storage_test_result_2 tr
INNER JOIN grp 
ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
WHERE storage_test_metric_type_cd IN ('Average_Receipt' , 'Net_Hours' , 'Net_Sales' , 'Piece_Performance' , 'Receipt_Count', 'Sales_Calculation'
       ,'Sales_Quantity' , 'Writeoff', 'Relative_Writeoff')
--and storage_test_exec_sid = '202321'

) AS src
PIVOT (
    SUM (actual_val) 
    FOR storage_test_metric_type_cd  IN ('Average_Receipt' , 'Net_Hours' , 'Net_Sales' , 'Piece_Performance' , 'Receipt_Count', 'Sales_Calculation'
		,'Sales_Quantity' , 'Writeoff', 'Relative_Writeoff')
) AS pvt1
PIVOT (
    SUM (anticipated_val) 
    FOR storage_test_metric_type_cd1 IN ('Average_Receipt_contr' , 'Net_Hours_contr' , 'Net_Sales_contr' , 'Piece_Performance_contr' 
	, 'Receipt_Count_contr', 'Sales_Calculation_contr',  'Sales_Quantity_contr' , 'Writeoff_contr', 'Relative_Writeoff_contr')
) AS pvt1
PIVOT (
    MAX(spread_pct) 
    FOR storage_test_metric_type_cd2 IN ('Average_Receipt_spread' , 'Net_Hours_spread' , 'Net_Sales_spread' , 'Piece_Performance_spread'  
	,'Receipt_Count_spread', 'Sales_Calculation_spread', 'Sales_Quantity_spread' , 'Writeoff_spread', 'Relative_Writeoff_spread')
) AS pvt1
WHERE TEST_WEEK=-1
GROUP BY 1,2,3,4,5,6,7,8,9,10

UNION

SELECT

  storage_test_exec_sid 
 ,storage_test_result_grp_sid
 ,storage_test_result_grp_type_cd 
 ,test_week
 ,-1 item_grp_int_sid
 ,-1 itemgroup_int_id
 ,NULL AS itemgroup_int_desc
 ,NULL AS storage_test_promo_type_cd
 ,-1 AS storage_test_promo_type_cd_sort
 ,NULL AS user_defined_grp_name

 ,SUM(receipt_avg                   ) AS receipt_avg
 ,SUM(work_time_hr                  ) AS work_time_hr
 ,SUM(sales_net_val                 ) AS sales_net_val
 ,SUM(sales_qty_work_time           ) AS sales_qty_work_time
 ,SUM(receipt_cnt                   ) AS receipt_cnt
 ,SUM(sales_net_val_pv              ) AS sales_net_val_pv
 ,SUM(sales_qty_work_time_hr        ) AS sales_qty_work_time_hr
 ,SUM(writeoff_net_val              ) AS writeoff_net_val
 ,SUM(writeoff_net_pct              ) AS writeoff_net_pct
 ,SUM(receipt_avg_contr             ) AS receipt_avg_contr
 ,SUM(work_time_hr_contr            ) AS work_time_hr_contr
 ,SUM(sales_net_val_contr           ) AS sales_net_val_contr
 ,SUM(sales_qty_work_time_contr     ) AS sales_qty_work_time_contr
 ,SUM(receipt_cnt_contr             ) AS receipt_cnt_contr
 ,SUM(sales_net_val_pv_contr        ) AS sales_net_val_pv_contr
 ,SUM(sales_qty_work_time_hr_contr  ) AS sales_qty_work_time_hr_contr
 ,SUM(writeoff_net_val_contr        ) AS writeoff_net_val_contr
 ,SUM(writeoff_net_pct_contr        ) AS writeoff_net_pct_contr
 ,SUM(receipt_avg_spread            ) AS receipt_avg_spread
 ,SUM(work_time_hr_spread           ) AS work_time_hr_spread
 ,SUM(sales_net_val_spread          ) AS sales_net_val_spread
 ,SUM(sales_qty_work_time_spread    ) AS sales_qty_work_time_spread
 ,SUM(receipt_cnt_spread            ) AS receipt_cnt_spread
 ,SUM(sales_net_val_pv_spread       ) AS sales_net_val_pv_spread
 ,SUM(sales_qty_work_time_hr_spread ) AS sales_qty_work_time_hr_spread
 ,SUM(writeoff_net_val_spread       ) AS writeoff_net_val_spread
 ,SUM(writeoff_net_pct_spread       ) AS writeoff_net_pct_spread
 ,SUM(receipt_avg_effect            ) AS receipt_avg_effect
 ,SUM(work_time_hr_effect           ) AS work_time_hr_effect
 ,SUM(sales_net_val_effect          ) AS sales_net_val_effect
 ,SUM(sales_qty_work_time_effect    ) AS sales_qty_work_time_effect
 ,SUM(receipt_cnt_effect            ) AS receipt_cnt_effect
 ,SUM(sales_net_val_pv_effect       ) AS sales_net_val_pv_effect
 ,SUM(sales_qty_work_time_hr_effect ) AS sales_qty_work_time_hr_effect
 ,SUM(writeoff_net_val_effect       ) AS writeoff_net_val_effect
 ,SUM(writeoff_net_pct_effect       ) AS writeoff_net_pct_effect


FROM FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_STORAGE_TEST_RESULT_GENERAL_2
WHERE TEST_WEEK=-1
GROUP BY 1,2,3,4,5,6,7,8,9,10
;