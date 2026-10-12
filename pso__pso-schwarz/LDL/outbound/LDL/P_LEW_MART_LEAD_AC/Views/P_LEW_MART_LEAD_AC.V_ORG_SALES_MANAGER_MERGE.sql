CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_org_sales_manager_merge (aspect_id, client_id, wh_id, wh_id_exp,
loc_sid_wh, sales_manager_id, account_manager_id, sales_manager_name) AS SELECT *
FROM ldl_p_lew_mart_lead.v_org_sales_manager_merge;