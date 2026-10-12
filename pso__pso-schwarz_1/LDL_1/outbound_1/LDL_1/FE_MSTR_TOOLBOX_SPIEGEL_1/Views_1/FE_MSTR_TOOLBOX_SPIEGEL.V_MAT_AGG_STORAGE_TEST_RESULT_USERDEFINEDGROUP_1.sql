/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_STORAGE_TEST_RESULT_USERDEFINEDGROUP_1
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_agg_storage_test_result_userdefinedgroup_1
(
 storage_test_exec_sid 
 ,storage_test_result_grp_sid
 ,storage_test_result_grp_type_cd 
 --,orig_store_nr
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
WITH grp AS (
    SELECT   
         storage_test_result_grp_sid
        ,storage_test_result_grp_type_cd 
        --,loc.src_orig_store_nr AS orig_store_nr
        ,test_week
        ,user_defined_grp_name
    FROM ldl_p_lew_core.t_storage_test_result_group_1 grp
    WHERE UPPER(storage_test_result_grp_type_cd) = UPPER('UserDefinedGroup')
    GROUP BY 1,2,3,4
)
SELECT   
         storage_test_exec_sid 
        ,storage_test_result_grp_sid
        ,storage_test_result_grp_type_cd 
        ,test_week
        ,CASE WHEN user_defined_grp_name LIKE 'custom,0,%' THEN SUBSTR(user_defined_grp_name, 10) 
              ELSE user_defined_grp_name 
         END AS user_defined_grp_name
        
        -- ACTUAL VAL ($6 -> $14)
        , MAX(Average_Receipt)              AS receipt_avg
        , MAX(Net_Hours)                    AS work_time_hr
        , MAX(Net_Sales)                    AS sales_net_val
        , MAX(Piece_Performance)            AS sales_qty_work_time
        , MAX(Receipt_Count)                AS receipt_cnt
        , MAX(Sales_Calculation)            AS sales_net_val_pv
        , MAX(Sales_Quantity)               AS sales_qty_work_time_hr
        , MAX(Writeoff)                     AS writeoff_net_val
        , MAX(Relative_Writeoff)            AS writeoff_net_pct
        
        -- ANTICIPATED VAL ($15 -> $23)
        , MAX(Average_Receipt_contr)        AS receipt_avg_contr
        , MAX(Net_Hours_contr)              AS work_time_hr_contr
        , MAX(Net_Sales_contr)              AS sales_net_val_contr
        , MAX(Piece_Performance_contr)      AS sales_qty_work_time_contr
        , MAX(Receipt_Count_contr)          AS receipt_cnt_contr
        , MAX(Sales_Calculation_contr)      AS sales_net_val_pv_contr
        , MAX(Sales_Quantity_contr)         AS sales_qty_work_time_hr_contr
        , MAX(Writeoff_contr)               AS writeoff_net_val_contr
        , MAX(Relative_Writeoff_contr)      AS writeoff_net_pct_contr
        
        -- SPREAD PCT ($24 -> $32)
        , MAX(Average_Receipt_spread)       AS receipt_avg_spread
        , MAX(Net_Hours_spread)             AS work_time_hr_spread
        , MAX(Net_Sales_spread)             AS sales_net_val_spread
        , MAX(Piece_Performance_spread)     AS sales_qty_work_time_spread
        , MAX(Receipt_Count_spread)         AS receipt_cnt_spread
        , MAX(Sales_Calculation_spread)     AS sales_net_val_pv_spread
        , MAX(Sales_Quantity_spread)        AS sales_qty_work_time_hr_spread
        , MAX(Writeoff_spread)              AS writeoff_net_val_spread
        , MAX(Relative_Writeoff_spread)     AS writeoff_net_pct_spread

        -- EFFECTS (Calculated explicitly)
        , MAX(Average_Receipt) - MAX(Average_Receipt_contr)         AS receipt_avg_effect
        , MAX(Net_Hours) - MAX(Net_Hours_contr)                     AS work_time_hr_effect
        , MAX(Net_Sales) - MAX(Net_Sales_contr)                     AS sales_net_val_effect
        , MAX(Piece_Performance) - MAX(Piece_Performance_contr)     AS sales_qty_work_time_effect
        , MAX(Receipt_Count) - MAX(Receipt_Count_contr)             AS receipt_cnt_effect
        , MAX(Sales_Calculation) - MAX(Sales_Calculation_contr)     AS sales_net_val_pv_effect
        , MAX(Sales_Quantity) - MAX(Sales_Quantity_contr)           AS sales_qty_work_time_hr_effect
        , MAX(Writeoff) - MAX(Writeoff_contr)                       AS writeoff_net_val_effect
        , MAX(Relative_Writeoff) - MAX(Relative_Writeoff_contr)     AS writeoff_net_pct_effect

FROM ( 
  SELECT * FROM (
    SELECT * FROM (
        SELECT storage_test_exec_sid 
              ,tr.storage_test_result_grp_sid 
              ,storage_test_result_grp_type_cd 
              ,test_week
              ,user_defined_grp_name
              ,actual_val 
              ,anticipated_val
              ,spread_pct
              ,storage_test_metric_type_cd 
              ,CONCAT(storage_test_metric_type_cd, '_contr')  AS storage_test_metric_type_cd1
              ,CONCAT(storage_test_metric_type_cd, '_spread') AS storage_test_metric_type_cd2
        FROM ldl_p_lew_core.t_storage_test_result_1 tr
        INNER JOIN grp 
        ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
        WHERE storage_test_metric_type_cd IN ('Average_Receipt' , 'Net_Hours' , 'Net_Sales' , 'Piece_Performance' , 'Receipt_Count', 'Sales_Calculation' ,'Sales_Quantity' , 'Writeoff', 'Relative_Writeoff')
    ) AS src
    PIVOT (
        SUM(actual_val) 
        FOR storage_test_metric_type_cd IN ('Average_Receipt' , 'Net_Hours' , 'Net_Sales' , 'Piece_Performance' , 'Receipt_Count', 'Sales_Calculation','Sales_Quantity' , 'Writeoff', 'Relative_Writeoff')
    ) 
  )
  PIVOT (
      SUM(anticipated_val) 
      FOR storage_test_metric_type_cd1 IN ('Average_Receipt_contr' , 'Net_Hours_contr' , 'Net_Sales_contr' , 'Piece_Performance_contr', 'Receipt_Count_contr', 'Sales_Calculation_contr',  'Sales_Quantity_contr' , 'Writeoff_contr', 'Relative_Writeoff_contr')
  ) 
)
PIVOT (
    MAX(spread_pct) 
    FOR storage_test_metric_type_cd2 IN ('Average_Receipt_spread' , 'Net_Hours_spread' , 'Net_Sales_spread' , 'Piece_Performance_spread','Receipt_Count_spread', 'Sales_Calculation_spread', 'Sales_Quantity_spread' , 'Writeoff_spread', 'Relative_Writeoff_spread')
) 
WHERE test_week = -1
GROUP BY 1, 2, 3, 4, 5;