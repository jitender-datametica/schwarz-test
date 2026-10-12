/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_STORAGE_TEST_RESULT_GENERAL_2
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_MAT_AGG_STORAGE_TEST_RESULT_GENERAL_2(
    storage_test_exec_sid
    ,storage_test_result_grp_sid
    ,storage_test_result_grp_type_cd
    ,test_week
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
    ,sales_net_val_contr_spread
    ,sales_net_val_pv_contr_spread
    ,sales_qty_work_time_hr_contr_spread
    ,receipt_cnt_contr_spread
    ,receipt_avg_contr_spread
    ,work_time_hr_contr_spread
    ,sales_qty_work_time_contr_spread
    ,writeoff_net_pct_contr_spread
    ,writeoff_net_val_contr_spread
    ,max_sales_net_val_contr_spread
    ,min_sales_net_val_contr_spread
    ,max_sales_net_val_pv_contr_spread
    ,min_sales_net_val_pv_contr_spread
    ,max_sales_qty_work_time_hr_contr_spread
    ,min_sales_qty_work_time_hr_contr_spread
    ,max_receipt_cnt_contr_spread
    ,min_receipt_cnt_contr_spread
    ,max_receipt_avg_contr_spread
    ,min_receipt_avg_contr_spread
    ,max_work_time_hr_contr_spread
    ,min_work_time_hr_contr_spread
    ,max_sales_qty_work_time_contr_spread
    ,min_sales_qty_work_time_contr_spread
    ,max_writeoff_net_pct_contr_spread
    ,min_writeoff_net_pct_contr_spread
    ,max_writeoff_net_val_contr_spread
    ,min_writeoff_net_val_contr_spread
) AS
WITH grp 
AS(
SELECT   storage_test_result_grp_sid
        ,storage_test_result_grp_type_cd 
        ,test_week
    FROM p_lew_core.t_storage_test_result_group_2 grp
    WHERE UPPER(storage_test_result_grp_type_cd) = UPPER( 'General')
    GROUP BY 1,2,3
 )
SELECT   storage_test_exec_sid 
        ,storage_test_result_grp_sid
        ,storage_test_result_grp_type_cd 
        ,test_week
        /*,item_grp_int_sid
        ,itemgroup_int_id
        ,itemgroup_int_desc
        ,sub_item_grp_sid
        ,subitemgroup_id
        ,subitemgroup_desc
        ,storage_test_promo_type_cd
        ,user_defined_grp_name
    */

        , MAX ($5)  AS receipt_avg
        , MAX ($6 ) AS work_time_hr
        , MAX ($7 ) AS sales_net_val
        , MAX ($8 ) AS sales_qty_work_time
        , MAX ($9 ) AS receipt_cnt
        , MAX ($10) AS sales_net_val_pv
        , MAX ($11) AS sales_qty_work_time_hr
        , MAX ($12) AS writeoff_net_val
        , MAX ($13) AS writeoff_net_pct
        , MAX ($14) AS receipt_avg_contr
        , MAX ($15) AS work_time_hr_contr
        , MAX ($16) AS sales_net_val_contr
        , MAX ($17) AS sales_qty_work_time_contr
        , MAX ($18) AS receipt_cnt_contr
        , MAX ($19) AS sales_net_val_pv_contr
        , MAX ($20) AS sales_qty_work_time_hr_contr
        , MAX ($21) AS writeoff_net_val_contr
        , MAX ($22) AS writeoff_net_pct_contr
        , MAX ($23) AS receipt_avg_spread
        , MAX ($24) AS work_time_hr_spread
        , MAX ($25) AS sales_net_val_spread
        , MAX ($26) AS sales_qty_work_time_spread
        , MAX ($27) AS receipt_cnt_spread
        , MAX ($28) AS sales_net_val_pv_spread
        , MAX ($29) AS sales_qty_work_time_hr_spread
        , MAX ($30) AS writeoff_net_val_spread
        , MAX ($31) AS writeoff_net_pct_spread

        , receipt_avg - receipt_avg_contr                            AS receipt_avg_effect
        , work_time_hr - work_time_hr_contr                          AS work_time_hr_effect
        , sales_net_val - sales_net_val_contr                        AS sales_net_val_effect
        , sales_qty_work_time - sales_qty_work_time_contr            AS sales_qty_work_time_effect
        , receipt_cnt - receipt_cnt_contr                            AS receipt_cnt_effect
        , sales_net_val_pv - sales_net_val_pv_contr                  AS sales_net_val_pv_effect
        , sales_qty_work_time_hr - sales_qty_work_time_hr_contr      AS sales_qty_work_time_hr_effect
        , writeoff_net_val - writeoff_net_val_contr                  AS writeoff_net_val_effect
        , writeoff_net_pct - writeoff_net_pct_contr                  AS writeoff_net_pct_effect
        , sales_net_val_contr * sales_net_val_spread                 AS sales_net_val_contr_spread
        , sales_net_val_pv_contr * sales_net_val_pv_spread           AS sales_net_val_pv_contr_spread
        , sales_qty_work_time_hr_contr * sales_qty_work_time_hr_spread AS sales_qty_work_time_hr_contr_spread
        , receipt_cnt_contr * receipt_cnt_spread                     AS receipt_cnt_contr_spread
        , receipt_avg_contr * receipt_avg_spread                     AS receipt_avg_contr_spread
        , work_time_hr_contr * work_time_hr_spread                   AS work_time_hr_contr_spread
        , sales_qty_work_time_contr * sales_qty_work_time_spread     AS sales_qty_work_time_contr_spread
        , writeoff_net_pct_contr * writeoff_net_pct_spread           AS writeoff_net_pct_contr_spread
        , writeoff_net_val_contr * writeoff_net_val_spread           AS writeoff_net_val_contr_spread
        , CASE WHEN sales_net_val_spread IS NULL THEN NULL ELSE sales_net_val_contr + sales_net_val_contr_spread END AS max_sales_net_val_contr_spread
        , CASE WHEN sales_net_val_spread IS NULL THEN NULL ELSE sales_net_val_contr - sales_net_val_contr_spread END AS min_sales_net_val_contr_spread
        , CASE WHEN sales_net_val_pv_spread IS NULL THEN NULL ELSE sales_net_val_pv_contr + sales_net_val_pv_contr_spread END AS max_sales_net_val_pv_contr_spread
        , CASE WHEN sales_net_val_pv_spread IS NULL THEN NULL ELSE sales_net_val_pv_contr - sales_net_val_pv_contr_spread END AS min_sales_net_val_pv_contr_spread
        , CASE WHEN sales_qty_work_time_hr_spread IS NULL THEN NULL ELSE sales_qty_work_time_hr_contr + sales_qty_work_time_hr_contr_spread END AS max_sales_qty_work_time_hr_contr_spread
        , CASE WHEN sales_qty_work_time_hr_spread IS NULL THEN NULL ELSE sales_qty_work_time_hr_contr - sales_qty_work_time_hr_contr_spread END AS min_sales_qty_work_time_hr_contr_spread
        , CASE WHEN receipt_cnt_spread IS NULL THEN NULL ELSE receipt_cnt_contr + receipt_cnt_contr_spread END AS max_receipt_cnt_contr_spread
        , CASE WHEN receipt_cnt_spread IS NULL THEN NULL ELSE receipt_cnt_contr - receipt_cnt_contr_spread END AS min_receipt_cnt_contr_spread
        , CASE WHEN receipt_avg_spread IS NULL THEN NULL ELSE receipt_avg_contr + receipt_avg_contr_spread END AS max_receipt_avg_contr_spread
        , CASE WHEN receipt_avg_spread IS NULL THEN NULL ELSE receipt_avg_contr - receipt_avg_contr_spread END AS min_receipt_avg_contr_spread
        , CASE WHEN work_time_hr_spread IS NULL THEN NULL ELSE work_time_hr_contr + work_time_hr_contr_spread END AS max_work_time_hr_contr_spread
        , CASE WHEN work_time_hr_spread IS NULL THEN NULL ELSE work_time_hr_contr - work_time_hr_contr_spread END AS min_work_time_hr_contr_spread
        , CASE WHEN sales_qty_work_time_spread IS NULL THEN NULL ELSE sales_qty_work_time_contr + sales_qty_work_time_contr_spread END AS max_sales_qty_work_time_contr_spread
        , CASE WHEN sales_qty_work_time_spread IS NULL THEN NULL ELSE sales_qty_work_time_contr - sales_qty_work_time_contr_spread END AS min_sales_qty_work_time_contr_spread
        , CASE WHEN writeoff_net_pct_spread IS NULL THEN NULL ELSE writeoff_net_pct_contr + writeoff_net_pct_contr_spread END AS max_writeoff_net_pct_contr_spread
        , CASE WHEN writeoff_net_pct_spread IS NULL THEN NULL ELSE writeoff_net_pct_contr - writeoff_net_pct_contr_spread END AS min_writeoff_net_pct_contr_spread
        , CASE WHEN writeoff_net_val_spread IS NULL THEN NULL ELSE writeoff_net_val_contr + writeoff_net_val_contr_spread END AS max_writeoff_net_val_contr_spread
        , CASE WHEN writeoff_net_val_spread IS NULL THEN NULL ELSE writeoff_net_val_contr - writeoff_net_val_contr_spread END AS min_writeoff_net_val_contr_spread

FROM 
( SELECT storage_test_exec_sid 
,tr.storage_test_result_grp_sid 
,storage_test_result_grp_type_cd 
,test_week
/*,item_grp_int_sid  
,src_itemgrp_int_cd              AS itemgroup_int_id
,item_grp_int_name               AS itemgroup_int_desc
,sub_item_grp_sid                AS sub_item_grp_sid
,src_subitemgrp_cd               AS subitemgroup_id
,sub_item_grp_name               AS subitemgroup_desc
,storage_test_promo_type_cd
,user_defined_grp_name
*/
,actual_val 
,anticipated_val
,spread_pct
,storage_test_metric_type_cd 
,storage_test_metric_type_cd||'_contr'  AS storage_test_metric_type_cd1
,storage_test_metric_type_cd||'_spread' AS storage_test_metric_type_cd2
FROM p_lew_core.t_storage_test_result_2 tr
INNER JOIN grp 
ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
WHERE storage_test_metric_type_cd IN ('Average_Receipt'  , 'Net_Hours', 'Net_Sales', 'Piece_Performance' , 'Receipt_Count' , 'Sales_Calculation' 
                                      , 'Sales_Quantity' , 'Writeoff', 'Relative_Writeoff')

AND UPPER(storage_test_result_grp_type_cd) = UPPER( 'General')

) AS src
PIVOT (
    SUM (actual_val) 
    FOR storage_test_metric_type_cd IN ('Average_Receipt' , 'Net_Hours' , 'Net_Sales', 'Piece_Performance', 'Receipt_Count', 'Sales_Calculation'    , 'Sales_Quantity' , 'Writeoff', 'Relative_Writeoff')
) AS pvt1
PIVOT (
    SUM (anticipated_val) 
    FOR storage_test_metric_type_cd1 IN ('Average_Receipt_contr' , 'Net_Hours_contr' , 'Net_Sales_contr' , 'Piece_Performance_contr'                , 'Receipt_Count_contr', 'Sales_Calculation_contr',  'Sales_Quantity_contr', 'Writeoff_contr', 'Relative_Writeoff_contr')
) AS pvt1
PIVOT (
    MAX(spread_pct) 
    FOR storage_test_metric_type_cd2 IN ('Average_Receipt_spread' , 'Net_Hours_spread' , 'Net_Sales_spread' , 'Piece_Performance_spread'            , 'Receipt_Count_spread', 'Sales_Calculation_spread', 'Sales_Quantity_spread', 'Writeoff_spread', 'Relative_Writeoff_spread')
) AS pvt1
GROUP BY 1, 2,3,4
;