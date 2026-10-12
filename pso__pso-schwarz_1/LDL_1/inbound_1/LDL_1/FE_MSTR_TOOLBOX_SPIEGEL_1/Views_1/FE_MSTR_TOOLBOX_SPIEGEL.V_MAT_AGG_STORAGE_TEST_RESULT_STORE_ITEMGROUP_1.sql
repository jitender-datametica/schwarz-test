/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_STORAGE_TEST_RESULT_STORE_ITEMGROUP_1
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_MAT_AGG_STORAGE_TEST_RESULT_STORE_ITEMGROUP_1
(
 storage_test_exec_sid 
,storage_test_result_grp_sid
,storage_test_result_grp_type_cd 
,orig_store_nr
,test_week
,item_grp_int_sid
,itemgroup_int_id
,itemgroup_int_desc
,storage_test_promo_type_cd
,user_defined_grp_name

----
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


)
AS
WITH grp 
AS(
SELECT storage_test_result_grp_sid
		,storage_test_result_grp_type_cd 
		,loc.src_orig_store_nr AS orig_store_nr
		,test_week
		,grp.item_grp_int_sid
		,src_itemgrp_int_cd
		,item_grp_int_name
	--	,grp.sub_item_grp_sid
	--	,sb_int.src_subitemgrp_cd
	--	,sb_int.sub_item_grp_name
		,CASE WHEN storage_test_promo_type_cd = '-' THEN '' 
		      WHEN storage_test_promo_type_cd = 'normal' THEN 'Sortiment'
              WHEN storage_test_promo_type_cd = 'promo'  THEN 'Aktion_1' END AS storage_test_promo_type_cd
		,user_defined_grp_name
	 FROM p_lew_core.t_storage_test_result_group_1 grp
INNER JOIN p_lew_core.t_location_1  loc 
       ON loc.loc_sid = grp.loc_sid_store
INNER JOIN p_lew_core.t_itemgroup_international_1 ig_int 
	   ON grp.item_grp_int_sid = ig_int.item_grp_int_sid
	WHERE UPPER(storage_test_result_grp_type_cd) = UPPER( 'Store_ItemGroup')
	    AND grp.sub_item_grp_sid = -1
)
SELECT   storage_test_exec_sid 
		,storage_test_result_grp_sid
		,storage_test_result_grp_type_cd 
		,orig_store_nr
		,test_week
		,item_grp_int_sid
		,itemgroup_int_id
		,itemgroup_int_desc
		,storage_test_promo_type_cd
		,NULL AS user_defined_grp_name
		
		, MAX ($11) AS receipt_avg
		, MAX ($12) AS work_time_hr
		, MAX ($13) AS sales_net_val
		, MAX ($14) AS sales_qty_work_time
		, MAX ($15) AS receipt_cnt
		, MAX ($16) AS sales_net_val_pv
		, MAX ($17) AS sales_qty_work_time_hr
		, MAX ($18) AS writeoff_net_val
		, MAX ($19) AS writeoff_net_pct
		, MAX ($20) AS receipt_avg_contr
		, MAX ($21) AS work_time_hr_contr
		, MAX ($22) AS sales_net_val_contr
		, MAX ($23) AS sales_qty_work_time_contr
		, MAX ($24) AS receipt_cnt_contr
		, MAX ($25) AS sales_net_val_pv_contr
		, MAX ($26) AS sales_qty_work_time_hr_contr
		, MAX ($27) AS writeoff_net_val_contr
		, MAX ($28) AS writeoff_net_pct_contr
		, MAX ($29) AS receipt_avg_spread
		, MAX ($30) AS work_time_hr_spread
		, MAX ($31) AS sales_net_val_spread
		, MAX ($32) AS sales_qty_work_time_spread
		, MAX ($33) AS receipt_cnt_spread
		, MAX ($34) AS sales_net_val_pv_spread
		, MAX ($35) AS sales_qty_work_time_hr_spread
		, MAX ($36) AS writeoff_net_val_spread
		, MAX ($37) AS writeoff_net_pct_spread

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
,orig_store_nr
,test_week
,item_grp_int_sid
,src_itemgrp_int_cd               AS itemgroup_int_id
,item_grp_int_name                AS itemgroup_int_desc
,storage_test_promo_type_cd
,user_defined_grp_name
,actual_val 
,anticipated_val
,spread_pct
,storage_test_metric_type_cd 
,storage_test_metric_type_cd||'_contr'  AS storage_test_metric_type_cd1
,storage_test_metric_type_cd||'_spread' AS storage_test_metric_type_cd2
FROM p_lew_core.t_storage_test_result_1 tr
INNER JOIN grp 
ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
WHERE storage_test_metric_type_cd IN ('Average_Receipt' , 'Net_Hours' , 'Net_Sales' , 'Piece_Performance' , 'Receipt_Count', 'Sales_Calculation'
		,'Sales_Quantity' , 'Writeoff', 'Relative_Writeoff')
--and storage_test_exec_sid = '202321'
) AS src
PIVOT (
    SUM (actual_val) 
    FOR storage_test_metric_type_cd IN ('Average_Receipt' , 'Net_Hours' , 'Net_Sales' , 'Piece_Performance' , 'Receipt_Count', 'Sales_Calculation'
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
WHERE test_week=-1
GROUP BY 1, 2,3,4,5,6,7,8,9,10

UNION

SELECT   storage_test_exec_sid 
		,storage_test_result_grp_sid
		,storage_test_result_grp_type_cd 
		,orig_store_nr
		,test_week
		,-1        AS item_grp_int_sid
		,-1        AS  itemgroup_int_id
		,NULL      AS itemgroup_int_desc
		,''  AS storage_test_promo_type_cd
		,NULL      AS user_defined_grp_name
		
        , MAX ($11) AS receipt_avg
		, MAX ($12) AS work_time_hr
		, MAX ($13) AS sales_net_val
		, MAX ($14) AS sales_qty_work_time
		, MAX ($15) AS receipt_cnt
		, MAX ($16) AS sales_net_val_pv
		, MAX ($17) AS sales_qty_work_time_hr
		, MAX ($18) AS writeoff_net_val
		, MAX ($19) AS writeoff_net_pct
		, MAX ($20) AS receipt_avg_contr
		, MAX ($21) AS work_time_hr_contr
		, MAX ($22) AS sales_net_val_contr
		, MAX ($23) AS sales_qty_work_time_contr
		, MAX ($24) AS receipt_cnt_contr
		, MAX ($25) AS sales_net_val_pv_contr
		, MAX ($26) AS sales_qty_work_time_hr_contr
		, MAX ($27) AS writeoff_net_val_contr
		, MAX ($28) AS writeoff_net_pct_contr
		, MAX ($29) AS receipt_avg_spread
		, MAX ($30) AS work_time_hr_spread
		, MAX ($31) AS sales_net_val_spread
		, MAX ($32) AS sales_qty_work_time_spread
		, MAX ($33) AS receipt_cnt_spread
		, MAX ($34) AS sales_net_val_pv_spread
		, MAX ($35) AS sales_qty_work_time_hr_spread
		, MAX ($36) AS writeoff_net_val_spread
		, MAX ($37) AS writeoff_net_pct_spread
		

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
,orig_store_nr
,test_week
,-1        AS item_grp_int_sid
,-1        AS  itemgroup_int_id
,NULL      AS itemgroup_int_desc
,''        AS storage_test_promo_type_cd
,NULL      AS user_defined_grp_name
,actual_val 
,anticipated_val
,spread_pct
,storage_test_metric_type_cd 
,storage_test_metric_type_cd||'_contr'  AS storage_test_metric_type_cd1
,storage_test_metric_type_cd||'_spread' AS storage_test_metric_type_cd2
FROM p_lew_core.t_storage_test_result_1 tr
INNER JOIN (
SELECT storage_test_result_grp_sid
		,storage_test_result_grp_type_cd 
		,loc.src_orig_store_nr AS orig_store_nr
		,test_week
	 FROM p_lew_core.t_storage_test_result_group_1 grp
INNER JOIN p_lew_core.t_location_1  loc 
       ON loc.loc_sid = grp.loc_sid_store
	WHERE UPPER(storage_test_result_grp_type_cd) = UPPER( 'Store')
)grp 
ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
WHERE storage_test_metric_type_cd IN ('Average_Receipt' , 'Net_Hours' , 'Net_Sales' , 'Piece_Performance' , 'Receipt_Count', 'Sales_Calculation'
		,'Sales_Quantity' , 'Writeoff', 'Relative_Writeoff')
--and storage_test_exec_sid = '202321'
) AS src
PIVOT (
    SUM (actual_val) 
    FOR storage_test_metric_type_cd IN ('Average_Receipt' , 'Net_Hours' , 'Net_Sales' , 'Piece_Performance' , 'Receipt_Count', 'Sales_Calculation'
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
WHERE test_week=-1
GROUP BY 1, 2,3,4,5,6,7,8,9,10


;