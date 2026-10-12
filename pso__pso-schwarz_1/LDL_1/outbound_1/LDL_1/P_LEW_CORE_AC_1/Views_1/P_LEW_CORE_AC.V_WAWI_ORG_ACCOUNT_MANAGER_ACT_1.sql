CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_org_account_manager_act_1 (client_id, wh_loc_sid, account_manager_id,
account_manager_name) AS SELECT client_id,
 wh_loc_sid,
 account_manager_id,
 account_manager_name
FROM ldl_p_lew_core.t_wawi_org_account_manager_act_1;