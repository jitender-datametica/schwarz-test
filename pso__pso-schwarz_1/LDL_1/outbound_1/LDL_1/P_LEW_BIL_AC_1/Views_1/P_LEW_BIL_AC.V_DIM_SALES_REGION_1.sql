CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_dim_sales_region_1 (client_id, sales_region_sid, sales_region_manager_nr,
sales_region_manager_name, lidl_country_cd, lidl_country_name, country_grp_sid, country_grp_manager_name, dwh_load_id,
dwh_created, dwh_updated) AS SELECT client_id,
 sales_region_sid,
 sales_region_manager_nr,
 sales_region_manager_name,
 lidl_country_cd,
 lidl_country_name,
 country_grp_sid,
 country_grp_manager_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_bil.t_dim_sales_region_1;