CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_agg_storage_test_result_store_sub_itemgroup_2 AS
SELECT   
     tr.storage_test_exec_sid 
    ,tr.storage_test_result_grp_sid
    ,grp.storage_test_result_grp_type_cd 
    ,loc.src_orig_store_nr AS orig_store_nr
    ,grp.test_week
    ,grp.item_grp_int_sid
    ,ig_int.src_itemgrp_int_cd AS itemgroup_int_id
    ,ig_int.item_grp_int_name AS itemgroup_int_desc
    ,grp.sub_item_grp_sid
    ,sb_int.src_subitemgrp_cd AS subitemgroup_id
    ,sb_int.sub_item_grp_name AS subitemgroup_desc

    -- Actual Values (SUM)
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Sales' THEN tr.actual_val END) AS sales_net_val
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Calculation' THEN tr.actual_val END) AS sales_net_val_pv
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Quantity' THEN tr.actual_val END) AS sales_qty_work_time_hr
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Writeoff' THEN tr.actual_val END) AS writeoff_net_val
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Relative_Writeoff' THEN tr.actual_val END) AS writeoff_net_pct
    
    -- Anticipated Values (SUM)
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Sales' THEN tr.anticipated_val END) AS sales_net_val_contr
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Calculation' THEN tr.anticipated_val END) AS sales_net_val_pv_contr
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Quantity' THEN tr.anticipated_val END) AS sales_qty_work_time_hr_contr
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Writeoff' THEN tr.anticipated_val END) AS writeoff_net_val_contr
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Relative_Writeoff' THEN tr.anticipated_val END) AS writeoff_net_pct_contr

    -- Spread PCT (MAX)
    , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Sales' THEN tr.spread_pct END) AS sales_net_val_spread
    , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Calculation' THEN tr.spread_pct END) AS sales_net_val_pv_spread
    , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Quantity' THEN tr.spread_pct END) AS sales_qty_work_time_hr_spread
    , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Writeoff' THEN tr.spread_pct END) AS writeoff_net_val_spread
    , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Relative_Writeoff' THEN tr.spread_pct END) AS writeoff_net_pct_spread

    -- Effect Calculations (Actual SUM - Anticipated SUM)
    , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Sales' THEN tr.actual_val END) - 
      SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Sales' THEN tr.anticipated_val END) AS sales_net_val_effect
      
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
INNER JOIN ldl_p_lew_core.t_subitemgroup_2 sb_int 
    ON grp.sub_item_grp_sid = sb_int.sub_item_grp_sid
WHERE UPPER(grp.storage_test_result_grp_type_cd) = 'STORE_ITEMGROUP'
  AND tr.storage_test_metric_type_cd IN (
    'Net_Sales', 'Sales_Calculation', 'Sales_Quantity', 'Writeoff', 'Relative_Writeoff'
  )
  AND grp.test_week = -1
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11;