CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_org_sales_manager_act_1 (client_id, wh_loc_sid, st_loc_sid,
sales_manager_id, sales_manager_name, account_manager_id) AS SELECT client_id,
 wh_loc_sid,
 st_loc_sid,
 sales_manager_id,
 sales_manager_name,
 account_manager_id
FROM ldl_p_lew_core.t_wawi_org_sales_manager_act_1;