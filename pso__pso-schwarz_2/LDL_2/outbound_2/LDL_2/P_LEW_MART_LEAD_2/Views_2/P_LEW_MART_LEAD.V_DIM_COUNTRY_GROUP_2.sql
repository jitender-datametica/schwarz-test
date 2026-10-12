CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_dim_country_group_2 (country_grp_sid, country_grp_manager_nr,
country_grp_manager_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_bil_ac.v_dim_country_group_2;