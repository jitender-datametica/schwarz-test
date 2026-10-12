CREATE OR REPLACE VIEW ldl_score_etl_process.v_etl_context_orga_area (client_id, country_cd, area_cd, area_grp_type,
cluster_type) AS SELECT client_id,
 country_cd,
 cluster_area_cd AS area_cd,
 cluster_area_type AS area_grp_type,
 cluster_type
FROM ldl_score_etl_process.t_client_cluster_hierarchy_maindef;