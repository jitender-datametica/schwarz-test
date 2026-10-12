CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_etl_context_orga_area (client_id, country_cd, area_cd, area_grp_type,
cluster_type) AS SELECT *
FROM ldl_p_lew_process.v_etl_context_orga_area;