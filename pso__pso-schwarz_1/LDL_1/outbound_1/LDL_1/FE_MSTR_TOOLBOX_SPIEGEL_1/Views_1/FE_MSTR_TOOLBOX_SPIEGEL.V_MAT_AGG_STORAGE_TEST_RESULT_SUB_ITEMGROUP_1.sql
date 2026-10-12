/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_STORAGE_TEST_RESULT_SUB_ITEMGROUP_1
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version
#  1.1  [Date]        [Your Name]              Translated to BigQuery Standard SQL
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_agg_storage_test_result_sub_itemgroup_1 AS

WITH grp AS (
  SELECT 
    grp.storage_test_result_grp_sid,
    grp.storage_test_result_grp_type_cd, 
    grp.test_week,
    grp.item_grp_int_sid,
    ig_int.src_itemgrp_int_cd,
    ig_int.item_grp_int_name,
    grp.sub_item_grp_sid,
    sb_int.src_subitemgrp_cd,
    sb_int.sub_item_grp_name,
    CASE 
      WHEN grp.storage_test_promo_type_cd = '-' THEN 'all' 
      ELSE grp.storage_test_promo_type_cd 
    END AS storage_test_promo_type_cd,
    grp.user_defined_grp_name
  FROM ldl_p_lew_core.t_storage_test_result_group_1 AS grp
  INNER JOIN ldl_p_lew_core.t_itemgroup_international_1 AS ig_int 
    ON grp.item_grp_int_sid = ig_int.item_grp_int_sid
  INNER JOIN ldl_p_lew_core.t_subitemgroup_1 AS sb_int 
    ON grp.sub_item_grp_sid = sb_int.sub_item_grp_sid 
  WHERE sb_int.src_subitemgrp_cd IS NOT NULL
    AND UPPER(grp.storage_test_result_grp_type_cd) = 'ITEMGROUP_1'
),

aggregated_data AS (
  SELECT 
    tr.storage_test_exec_sid,
    tr.storage_test_result_grp_sid,
    grp.storage_test_result_grp_type_cd,
    grp.test_week,
    grp.item_grp_int_sid,
    grp.src_itemgrp_int_cd AS itemgroup_int_id,
    grp.item_grp_int_name AS itemgroup_int_desc,
    grp.sub_item_grp_sid AS sub_item_grp_sid,
    grp.src_subitemgrp_cd AS subitemgroup_id,
    grp.sub_item_grp_name AS subitemgroup_desc,

    -- Actual Values (Equivalent to first PIVOT on actual_val)
    SUM(IF(tr.storage_test_metric_type_cd = 'Net_Sales', tr.actual_val, NULL)) AS sales_net_val,
    SUM(IF(tr.storage_test_metric_type_cd = 'Sales_Calculation', tr.actual_val, NULL)) AS sales_net_val_pv,
    SUM(IF(tr.storage_test_metric_type_cd = 'Sales_Quantity', tr.actual_val, NULL)) AS sales_qty_work_time_hr,
    SUM(IF(tr.storage_test_metric_type_cd = 'Writeoff', tr.actual_val, NULL)) AS writeoff_net_val,
    SUM(IF(tr.storage_test_metric_type_cd = 'Relative_Writeoff', tr.actual_val, NULL)) AS writeoff_net_pct,

    -- Anticipated Values / Contr (Equivalent to second PIVOT on anticipated_val)
    SUM(IF(tr.storage_test_metric_type_cd = 'Net_Sales', tr.anticipated_val, NULL)) AS sales_net_val_contr,
    SUM(IF(tr.storage_test_metric_type_cd = 'Sales_Calculation', tr.anticipated_val, NULL)) AS sales_net_val_pv_contr,
    SUM(IF(tr.storage_test_metric_type_cd = 'Sales_Quantity', tr.anticipated_val, NULL)) AS sales_qty_work_time_hr_contr,
    SUM(IF(tr.storage_test_metric_type_cd = 'Writeoff', tr.anticipated_val, NULL)) AS writeoff_net_val_contr,
    SUM(IF(tr.storage_test_metric_type_cd = 'Relative_Writeoff', tr.anticipated_val, NULL)) AS writeoff_net_pct_contr,

    -- Spread Percentages (Equivalent to third PIVOT on spread_pct)
    MAX(IF(tr.storage_test_metric_type_cd = 'Net_Sales', tr.spread_pct, NULL)) AS sales_net_val_spread,
    MAX(IF(tr.storage_test_metric_type_cd = 'Sales_Calculation', tr.spread_pct, NULL)) AS sales_net_val_pv_spread,
    MAX(IF(tr.storage_test_metric_type_cd = 'Sales_Quantity', tr.spread_pct, NULL)) AS sales_qty_work_time_hr_spread,
    MAX(IF(tr.storage_test_metric_type_cd = 'Writeoff', tr.spread_pct, NULL)) AS writeoff_net_val_spread,
    MAX(IF(tr.storage_test_metric_type_cd = 'Relative_Writeoff', tr.spread_pct, NULL)) AS writeoff_net_pct_spread

  FROM ldl_p_lew_core.t_storage_test_result_1 AS tr
  INNER JOIN grp 
    ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
  WHERE tr.storage_test_metric_type_cd IN ('Net_Sales', 'Sales_Calculation', 'Sales_Quantity', 'Writeoff', 'Relative_Writeoff')
    AND grp.test_week = -1  -- Filter pushed down to improve performance before grouping
  GROUP BY 
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10
)

SELECT 
  storage_test_exec_sid,
  storage_test_result_grp_sid,
  storage_test_result_grp_type_cd,
  test_week,
  item_grp_int_sid,
  itemgroup_int_id,
  itemgroup_int_desc,
  sub_item_grp_sid,
  subitemgroup_id,
  subitemgroup_desc,

  sales_net_val,
  sales_net_val_pv,
  sales_qty_work_time_hr,
  writeoff_net_val,
  writeoff_net_pct,
  
  sales_net_val_contr,
  sales_net_val_pv_contr,
  sales_qty_work_time_hr_contr,
  writeoff_net_val_contr,
  writeoff_net_pct_contr,

  sales_net_val_spread,
  sales_net_val_pv_spread,
  sales_qty_work_time_hr_spread,
  writeoff_net_val_spread,
  writeoff_net_pct_spread,

  -- Calculated "effect" columns
  (sales_net_val - sales_net_val_contr)                   AS sales_net_val_effect,
  (sales_net_val_pv - sales_net_val_pv_contr)             AS sales_net_val_pv_effect,
  (sales_qty_work_time_hr - sales_qty_work_time_hr_contr) AS sales_qty_work_time_hr_effect,
  (writeoff_net_val - writeoff_net_val_contr)             AS writeoff_net_val_effect,
  (writeoff_net_pct - writeoff_net_pct_contr)             AS writeoff_net_pct_effect

FROM aggregated_data;