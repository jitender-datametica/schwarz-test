CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_org_account_manager_2 (client_id, wh_id, account_manager_id,
account_manager_name) AS SELECT client_id,
 wh_id,
 account_manager_id,
 account_manager_name
FROM ldl_p_lew_mart_msi.t_org_account_manager_2;