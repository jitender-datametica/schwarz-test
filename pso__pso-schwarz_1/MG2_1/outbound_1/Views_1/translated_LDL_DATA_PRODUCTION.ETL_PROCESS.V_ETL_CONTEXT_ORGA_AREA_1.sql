CREATE OR REPLACE VIEW ldl_data_production_etl_process.v_etl_context_orga_area_1 (client_id, country_cd, area_cd,
area_grp_type, cluster_type) AS SELECT client_id,
 country_cd,
 cluster_area_cd AS area_cd,
 cluster_area_type AS area_grp_type,
 cluster_type
FROM ldl_data_production_etl_process.t_client_cluster_hierarchy_maindef_1;