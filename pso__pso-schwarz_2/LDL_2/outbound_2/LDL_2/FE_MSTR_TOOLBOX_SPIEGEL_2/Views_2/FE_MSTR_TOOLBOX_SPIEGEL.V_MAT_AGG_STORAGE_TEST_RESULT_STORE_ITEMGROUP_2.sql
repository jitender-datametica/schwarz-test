CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_agg_storage_test_result_store_itemgroup_2 AS

-- ----- TOP HALF: Store ItemGroup_2 Level Aggregation ----- --
SELECT   
     tr.storage_test_exec_sid 
    ,tr.storage_test_result_grp_sid
    ,grp.storage_test_result_grp_type_cd 
    ,loc.src_orig_store_nr AS orig_store_nr
    ,grp.test_week
    ,grp.item_grp_int_sid
    ,CAST(ig_int.src_itemgrp_int_cd AS STRING) AS itemgroup_int_id
    ,CAST(ig_int.item_grp_int_name AS STRING) AS itemgroup_int_desc
    ,CAST(
        CASE 
            WHEN grp.storage_test_promo_type_cd = '-' THEN '' 
            WHEN grp.storage_test_promo_type_cd = 'normal' THEN 'Sortiment'
            WHEN grp.storage_test_promo_type_cd = 'promo' THEN 'Aktion_2' 
        END 
     AS STRING) AS storage_test_promo_type_cd
    ,CASE 
        WHEN grp.storage_test_promo_type_cd IN ('-', '') THEN 1
        WHEN grp.storage_test_promo_type_cd = 'normal' THEN 2 
        WHEN grp.storage_test_promo_type_cd = 'promo' THEN 3 
        ELSE 1
     END AS storage_test_promo_type_cd_sort
    ,CAST(grp.user_defined_grp_name AS STRING) AS user_defined_grp_name

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

FROM ldl_p_lew_core.t_storage_test_result_2 tr
INNER JOIN ldl_p_lew_core.t_storage_test_result_group_2 grp 
    ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
INNER JOIN ldl_p_lew_core.t_location_2 loc 
    ON loc.loc_sid = grp.loc_sid_store
INNER JOIN ldl_p_lew_core.t_itemgroup_international_2 ig_int 
    ON grp.item_grp_int_sid = ig_int.item_grp_int_sid
WHERE UPPER(grp.storage_test_result_grp_type_cd) = 'STORE_ITEMGROUP'
  AND grp.sub_item_grp_sid = -1 
  AND tr.storage_test_metric_type_cd IN (
    'Average_Receipt', 'Net_Hours', 'Net_Sales', 'Piece_Performance', 'Receipt_Count', 
    'Sales_Calculation', 'Sales_Quantity', 'Writeoff', 'Relative_Writeoff'
  )
  AND grp.test_week = -1
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11

UNION ALL

-- ----- BOTTOM HALF: Rolled-Up Store Level Aggregation ----- --
SELECT   
     tr.storage_test_exec_sid 
    ,tr.storage_test_result_grp_sid
    ,grp.storage_test_result_grp_type_cd 
    ,loc.src_orig_store_nr AS orig_store_nr
    ,grp.test_week
    ,-1 AS item_grp_int_sid
    ,CAST('-1' AS STRING) AS itemgroup_int_id
    ,CAST(NULL AS STRING) AS itemgroup_int_desc
    ,CAST('' AS STRING) AS storage_test_promo_type_cd
    ,-1 AS storage_test_promo_type_cd_sort
    ,CAST(NULL AS STRING) AS user_defined_grp_name

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

FROM ldl_p_lew_core.t_storage_test_result_2 tr
INNER JOIN ldl_p_lew_core.t_storage_test_result_group_2 grp 
    ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
INNER JOIN ldl_p_lew_core.t_location_2 loc 
    ON loc.loc_sid = grp.loc_sid_store
WHERE UPPER(grp.storage_test_result_grp_type_cd) = 'STORE'
  AND tr.storage_test_metric_type_cd IN (
    'Average_Receipt', 'Net_Hours', 'Net_Sales', 'Piece_Performance', 'Receipt_Count', 
    'Sales_Calculation', 'Sales_Quantity', 'Writeoff', 'Relative_Writeoff'
  )
  AND grp.test_week = -1
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11;