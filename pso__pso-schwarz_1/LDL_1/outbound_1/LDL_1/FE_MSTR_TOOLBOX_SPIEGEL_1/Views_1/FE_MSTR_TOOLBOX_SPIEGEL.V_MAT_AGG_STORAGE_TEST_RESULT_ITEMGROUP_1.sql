CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_agg_storage_test_result_itemgroup_1 AS

-- ----- TOP HALF: Pivoted and Aggregated Itemgroup_1 Data ----- --
SELECT   
     tr.storage_test_exec_sid 
    ,tr.storage_test_result_grp_sid
    ,grp.storage_test_result_grp_type_cd 
    ,grp.test_week
    ,grp.item_grp_int_sid
    ,ig_int.src_itemgrp_int_cd AS itemgroup_int_id
    ,ig_int.item_grp_int_name AS itemgroup_int_desc
    ,CASE 
        WHEN grp.storage_test_promo_type_cd = '-' THEN '' 
        WHEN grp.storage_test_promo_type_cd = 'normal' THEN 'Sortiment'
        WHEN grp.storage_test_promo_type_cd = 'promo' THEN 'Aktion_1' 
     END AS storage_test_promo_type_cd
    ,CASE 
        WHEN grp.storage_test_promo_type_cd IN ('-', '') THEN 1
        WHEN grp.storage_test_promo_type_cd = 'normal' THEN 2 
        WHEN grp.storage_test_promo_type_cd = 'promo' THEN 3 
     END AS storage_test_promo_type_cd_sort
    ,grp.user_defined_grp_name

    -- Actual Values (SUM)
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Average_Receipt' THEN tr.actual_val END) AS receipt_avg
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Hours' THEN tr.actual_val END) AS work_time_hr
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Sales' THEN tr.actual_val END) AS sales_net_val
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Piece_Performance' THEN tr.actual_val END) AS sales_qty_work_time
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Receipt_Count' THEN tr.actual_val END) AS receipt_cnt
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Calculation' THEN tr.actual_val END) AS sales_net_val_pv
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Quantity' THEN tr.actual_val END) AS sales_qty_work_time_hr
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Writeoff' THEN tr.actual_val END) AS writeoff_net_val
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Relative_Writeoff' THEN tr.actual_val END) AS writeoff_net_pct
    
    -- Anticipated Values (SUM)
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Average_Receipt' THEN tr.anticipated_val END) AS receipt_avg_contr
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Hours' THEN tr.anticipated_val END) AS work_time_hr_contr
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Sales' THEN tr.anticipated_val END) AS sales_net_val_contr
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Piece_Performance' THEN tr.anticipated_val END) AS sales_qty_work_time_contr
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Receipt_Count' THEN tr.anticipated_val END) AS receipt_cnt_contr
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Calculation' THEN tr.anticipated_val END) AS sales_net_val_pv_contr
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Quantity' THEN tr.anticipated_val END) AS sales_qty_work_time_hr_contr
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Writeoff' THEN tr.anticipated_val END) AS writeoff_net_val_contr
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Relative_Writeoff' THEN tr.anticipated_val END) AS writeoff_net_pct_contr
    
    -- Spread PCT (MAX)
    , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Average_Receipt' THEN tr.spread_pct END) AS receipt_avg_spread
    , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Hours' THEN tr.spread_pct END) AS work_time_hr_spread
    , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Sales' THEN tr.spread_pct END) AS sales_net_val_spread
    , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Piece_Performance' THEN tr.spread_pct END) AS sales_qty_work_time_spread
    , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Receipt_Count' THEN tr.spread_pct END) AS receipt_cnt_spread
    , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Calculation' THEN tr.spread_pct END) AS sales_net_val_pv_spread
    , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Quantity' THEN tr.spread_pct END) AS sales_qty_work_time_hr_spread
    , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Writeoff' THEN tr.spread_pct END) AS writeoff_net_val_spread
    , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Relative_Writeoff' THEN tr.spread_pct END) AS writeoff_net_pct_spread

    -- Effect Calculations (Actual SUM - Anticipated SUM)
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Average_Receipt' THEN tr.actual_val END) - 
      SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Average_Receipt' THEN tr.anticipated_val END) AS receipt_avg_effect
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Hours' THEN tr.actual_val END) - 
      SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Hours' THEN tr.anticipated_val END) AS work_time_hr_effect
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Sales' THEN tr.actual_val END) - 
      SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Sales' THEN tr.anticipated_val END) AS sales_net_val_effect
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Piece_Performance' THEN tr.actual_val END) - 
      SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Piece_Performance' THEN tr.anticipated_val END) AS sales_qty_work_time_effect
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Receipt_Count' THEN tr.actual_val END) - 
      SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Receipt_Count' THEN tr.anticipated_val END) AS receipt_cnt_effect
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Calculation' THEN tr.actual_val END) - 
      SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Calculation' THEN tr.anticipated_val END) AS sales_net_val_pv_effect
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Quantity' THEN tr.actual_val END) - 
      SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Quantity' THEN tr.anticipated_val END) AS sales_qty_work_time_hr_effect
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Writeoff' THEN tr.actual_val END) - 
      SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Writeoff' THEN tr.anticipated_val END) AS writeoff_net_val_effect
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Relative_Writeoff' THEN tr.actual_val END) - 
      SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Relative_Writeoff' THEN tr.anticipated_val END) AS writeoff_net_pct_effect

FROM ldl_p_lew_core.t_storage_test_result_1 tr
INNER JOIN ldl_p_lew_core.t_storage_test_result_group_1 grp 
    ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
INNER JOIN ldl_p_lew_core.t_itemgroup_international_1 ig_int 
    ON grp.item_grp_int_sid = ig_int.item_grp_int_sid
WHERE UPPER(grp.storage_test_result_grp_type_cd) = 'ITEMGROUP_1'
  AND grp.sub_item_grp_sid = -1 
  AND tr.storage_test_metric_type_cd IN (
    'Average_Receipt', 'Net_Hours', 'Net_Sales', 'Piece_Performance', 'Receipt_Count', 
    'Sales_Calculation', 'Sales_Quantity', 'Writeoff', 'Relative_Writeoff'
  )
  AND grp.test_week = -1
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

UNION ALL

-- ----- BOTTOM HALF: Rolled-Up General Metrics ----- --
SELECT
     storage_test_exec_sid 
    ,storage_test_result_grp_sid
    ,storage_test_result_grp_type_cd 
    ,test_week
    ,-1 AS item_grp_int_sid
    ,CAST('-1' AS STRING) AS itemgroup_int_id 
    ,CAST(NULL AS STRING) AS itemgroup_int_desc
    ,CAST(NULL AS STRING) AS storage_test_promo_type_cd
    ,-1 AS storage_test_promo_type_cd_sort
    ,CAST(NULL AS STRING) AS user_defined_grp_name

    ,SUM(receipt_avg)                   AS receipt_avg
    ,SUM(work_time_hr)                  AS work_time_hr
    ,SUM(sales_net_val)                 AS sales_net_val
    ,SUM(sales_qty_work_time)           AS sales_qty_work_time
    ,SUM(receipt_cnt)                   AS receipt_cnt
    ,SUM(sales_net_val_pv)              AS sales_net_val_pv
    ,SUM(sales_qty_work_time_hr)        AS sales_qty_work_time_hr
    ,SUM(writeoff_net_val)              AS writeoff_net_val
    ,SUM(writeoff_net_pct)              AS writeoff_net_pct
    ,SUM(receipt_avg_contr)             AS receipt_avg_contr
    ,SUM(work_time_hr_contr)            AS work_time_hr_contr
    ,SUM(sales_net_val_contr)           AS sales_net_val_contr
    ,SUM(sales_qty_work_time_contr)     AS sales_qty_work_time_contr
    ,SUM(receipt_cnt_contr)             AS receipt_cnt_contr
    ,SUM(sales_net_val_pv_contr)        AS sales_net_val_pv_contr
    ,SUM(sales_qty_work_time_hr_contr)  AS sales_qty_work_time_hr_contr
    ,SUM(writeoff_net_val_contr)        AS writeoff_net_val_contr
    ,SUM(writeoff_net_pct_contr)        AS writeoff_net_pct_contr
    ,SUM(receipt_avg_spread)            AS receipt_avg_spread
    ,SUM(work_time_hr_spread)           AS work_time_hr_spread
    ,SUM(sales_net_val_spread)          AS sales_net_val_spread
    ,SUM(sales_qty_work_time_spread)    AS sales_qty_work_time_spread
    ,SUM(receipt_cnt_spread)            AS receipt_cnt_spread
    ,SUM(sales_net_val_pv_spread)       AS sales_net_val_pv_spread
    ,SUM(sales_qty_work_time_hr_spread) AS sales_qty_work_time_hr_spread
    ,SUM(writeoff_net_val_spread)       AS writeoff_net_val_spread
    ,SUM(writeoff_net_pct_spread)       AS writeoff_net_pct_spread
    ,SUM(receipt_avg_effect)            AS receipt_avg_effect
    ,SUM(work_time_hr_effect)           AS work_time_hr_effect
    ,SUM(sales_net_val_effect)          AS sales_net_val_effect
    ,SUM(sales_qty_work_time_effect)    AS sales_qty_work_time_effect
    ,SUM(receipt_cnt_effect)            AS receipt_cnt_effect
    ,SUM(sales_net_val_pv_effect)       AS sales_net_val_pv_effect
    ,SUM(sales_qty_work_time_hr_effect) AS sales_qty_work_time_hr_effect
    ,SUM(writeoff_net_val_effect)       AS writeoff_net_val_effect
    ,SUM(writeoff_net_pct_effect)       AS writeoff_net_pct_effect

FROM ldl_fe_mstr_toolbox_spiegel.v_agg_storage_test_result_general_1
WHERE test_week = -1
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10;