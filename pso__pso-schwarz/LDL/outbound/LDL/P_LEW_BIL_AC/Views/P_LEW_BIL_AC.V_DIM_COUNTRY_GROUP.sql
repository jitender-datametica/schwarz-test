CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_dim_country_group (country_grp_sid, country_grp_manager_nr,
country_grp_manager_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT country_grp_sid,
 country_grp_manager_nr,
 country_grp_manager_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_bil.t_dim_country_group;