CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_agg_storage_test_result_store_userdefinedgroup_1 AS
SELECT   
     tr.storage_test_exec_sid 
    ,tr.storage_test_result_grp_sid
    ,grp.storage_test_result_grp_type_cd 
    ,loc.src_orig_store_nr AS orig_store_nr
    ,grp.test_week
    ,CASE 
        WHEN grp.user_defined_grp_name LIKE 'custom,0,%' THEN SUBSTR(grp.user_defined_grp_name, 10) 
        ELSE grp.user_defined_grp_name 
     END AS user_defined_grp_name
    
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
INNER JOIN ldl_p_lew_core.t_location_1 loc 
    ON loc.loc_sid = grp.loc_sid_store
WHERE UPPER(grp.storage_test_result_grp_type_cd) = 'STORE_USERDEFINEDGROUP'
  AND tr.storage_test_metric_type_cd IN (
    'Average_Receipt', 'Net_Hours', 'Net_Sales', 'Piece_Performance', 'Receipt_Count', 
    'Sales_Calculation', 'Sales_Quantity', 'Writeoff', 'Relative_Writeoff'
  )
  AND grp.test_week = -1
GROUP BY 1, 2, 3, 4, 5, 6;

