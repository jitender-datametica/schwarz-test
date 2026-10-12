CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_org_sales_manager_2 (client_id, wh_id, store_id, sales_manager_id,
sales_manager_name, account_manager_id) AS SELECT client_id,
 wh_id,
 store_id,
 sales_manager_id,
 sales_manager_name,
 account_manager_id
FROM ldl_p_lew_mart_msi.t_org_sales_manager_2;