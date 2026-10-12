CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_org_sales_manager_merge_act_1 (aspect_id, client_id, wh_loc_sid,
wh_loc_sid_exp, sales_manager_id, account_manager_id, sales_manager_name) AS SELECT aspect_id,
 client_id,
 wh_loc_sid,
 wh_loc_sid_exp,
 sales_manager_id,
 account_manager_id,
 sales_manager_name
FROM ldl_p_lew_core.t_wawi_org_sales_manager_merge_act_1;