CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_dim_sales_region_1 (client_id, sales_region_sid, sales_region_manager_nr,
sales_region_manager_name, lidl_country_cd, lidl_country_name, country_grp_sid, country_grp_manager_name, dwh_load_id,
dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_lead.v_dim_sales_region_1;