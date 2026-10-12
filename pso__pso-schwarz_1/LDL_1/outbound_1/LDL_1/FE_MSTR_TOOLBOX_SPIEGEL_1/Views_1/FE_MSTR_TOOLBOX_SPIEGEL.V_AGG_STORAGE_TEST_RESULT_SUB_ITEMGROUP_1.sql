/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_STORAGE_TEST_RESULT_SUB_ITEMGROUP_1
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_agg_storage_test_result_sub_itemgroup_1 (storage_test_exec_sid,
storage_test_result_grp_sid, storage_test_result_grp_type_cd, test_week, item_grp_int_sid, itemgroup_int_id,
itemgroup_int_desc, sub_item_grp_sid, subitemgroup_id, subitemgroup_desc, sales_net_val, sales_net_val_pv,
sales_qty_work_time_hr, writeoff_net_val, writeoff_net_pct, sales_net_val_contr, sales_net_val_pv_contr,
sales_qty_work_time_hr_contr, writeoff_net_val_contr, writeoff_net_pct_contr, sales_net_val_spread,
sales_net_val_pv_spread, sales_qty_work_time_hr_spread, writeoff_net_val_spread, writeoff_net_pct_spread,
sales_net_val_effect, sales_net_val_pv_effect, sales_qty_work_time_hr_effect, writeoff_net_val_effect,
writeoff_net_pct_effect) AS SELECT storage_test_exec_sid,
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
 sales_net_val_effect,
 sales_net_val_pv_effect,
 sales_qty_work_time_hr_effect,
 writeoff_net_val_effect,
 writeoff_net_pct_effect
FROM ldl_fe_mstr_toolbox_spiegel.t_agg_storage_test_result_sub_itemgroup_1;