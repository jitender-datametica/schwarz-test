/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_STORAGE_TEST_RESULT_STORE_USERDEFINEDGROUP_1
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_MAT_AGG_STORAGE_TEST_RESULT_STORE_USERDEFINEDGROUP_1
(
 storage_test_exec_sid 
 ,storage_test_result_grp_sid
 ,storage_test_result_grp_type_cd 
 ,orig_store_nr
 ,test_week
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
)
AS
WITH grp 
AS(
SELECT   storage_test_result_grp_sid
		,storage_test_result_grp_type_cd 
		,loc.src_orig_store_nr AS orig_store_nr
		,test_week
		,CASE WHEN storage_test_promo_type_cd = '-' THEN 'all' ELSE storage_test_promo_type_cd END AS storage_test_promo_type_cd
		,user_defined_grp_name
	FROM p_lew_core.t_storage_test_result_group_1 grp
	INNER JOIN p_lew_core.t_location_1  loc 
	       ON loc.loc_sid = grp.loc_sid_store
	WHERE UPPER(storage_test_result_grp_type_cd) = UPPER( 'Store_UserDefinedGroup')
)
SELECT   storage_test_exec_sid 
		,storage_test_result_grp_sid
		,storage_test_result_grp_type_cd 
		,orig_store_nr
		,test_week
		,CASE WHEN user_defined_grp_name LIKE 'custom,0,%' THEN SUBSTRING(user_defined_grp_name,10) 
		      ELSE user_defined_grp_name 
			  END                                                                                     AS user_defined_grp_name
		
		, MAX ($7) AS receipt_avg
		, MAX ($8) AS work_time_hr
		, MAX ($9) AS sales_net_val
		, MAX ($10) AS sales_qty_work_time
		, MAX ($11) AS receipt_cnt
		, MAX ($12) AS sales_net_val_pv
		, MAX ($13) AS sales_qty_work_time_hr
		, MAX ($14) AS writeoff_net_val
		, MAX ($15) AS writeoff_net_pct
		, MAX ($16) AS receipt_avg_contr
		, MAX ($17) AS work_time_hr_contr
		, MAX ($18) AS sales_net_val_contr
		, MAX ($19) AS sales_qty_work_time_contr
		, MAX ($20) AS receipt_cnt_contr
		, MAX ($21) AS sales_net_val_pv_contr
		, MAX ($22) AS sales_qty_work_time_hr_contr
		, MAX ($23) AS writeoff_net_val_contr
		, MAX ($24) AS writeoff_net_pct_contr
		, MAX ($25) AS receipt_avg_spread
		, MAX ($26) AS work_time_hr_spread
		, MAX ($27) AS sales_net_val_spread
		, MAX ($28) AS sales_qty_work_time_spread
		, MAX ($29) AS receipt_cnt_spread
		, MAX ($30) AS sales_net_val_pv_spread
		, MAX ($31) AS sales_qty_work_time_hr_spread
		, MAX ($32) AS writeoff_net_val_spread
		, MAX ($33) AS writeoff_net_pct_spread

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
WHERE storage_test_metric_type_cd IN ('Average_Receipt' , 'Net_Hours' , 'Net_Sales' , 'Piece_Performance' , 'Receipt_Count', 'Sales_Calculation','Sales_Quantity' , 'Writeoff', 'Relative_Writeoff')
--and storage_test_exec_sid = '202321'

) AS src
PIVOT (
    SUM (actual_val) 
    FOR storage_test_metric_type_cd IN ('Average_Receipt' , 'Net_Hours' , 'Net_Sales' , 'Piece_Performance' , 'Receipt_Count', 'Sales_Calculation','Sales_Quantity' , 'Writeoff', 'Relative_Writeoff')
) AS pvt1
PIVOT (
    SUM (anticipated_val) 
    FOR storage_test_metric_type_cd1 IN ('Average_Receipt_contr' , 'Net_Hours_contr' , 'Net_Sales_contr' , 'Piece_Performance_contr' 
	, 'Receipt_Count_contr', 'Sales_Calculation_contr',  'Sales_Quantity_contr' , 'Writeoff_contr', 'Relative_Writeoff_contr')
) AS pvt1
PIVOT (
    MAX(spread_pct) 
    FOR storage_test_metric_type_cd2 IN ('Average_Receipt_spread' , 'Net_Hours_spread' , 'Net_Sales_spread' , 'Piece_Performance_spread','Receipt_Count_spread', 'Sales_Calculation_spread', 'Sales_Quantity_spread' , 'Writeoff_spread', 'Relative_Writeoff_spread')
) AS pvt1
WHERE test_week=-1
GROUP BY 1,2,3,4,5,6
;

