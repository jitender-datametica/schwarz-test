CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_manager_info_1 (country_iso_cd, wh_id, store_id, sales_manager_id,
sales_manager_name, account_manager_id, account_manager_name, general_manager_id, general_manager_name) AS SELECT *
FROM ldl_p_lew_mart_wfm.v_manager_info_1;