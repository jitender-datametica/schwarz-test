CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_dim_account_manager_area (client_id, account_manager_area_sid,
account_manager_nr, account_manager_name, sales_wh_sid, sales_wh_nr, sales_region_sid, sales_region_manager_name,
lidl_country_cd, lidl_country_name, country_grp_sid, country_grp_manager_name, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 account_manager_area_sid,
 account_manager_nr,
 account_manager_name,
 sales_wh_sid,
 sales_wh_nr,
 sales_region_sid,
 sales_region_manager_name,
 lidl_country_cd,
 lidl_country_name,
 country_grp_sid,
 country_grp_manager_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_bil.t_dim_account_manager_area;