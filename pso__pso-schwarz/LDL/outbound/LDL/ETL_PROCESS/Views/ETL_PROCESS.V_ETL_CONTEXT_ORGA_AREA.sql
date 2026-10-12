CREATE OR REPLACE VIEW ldl_etl_process.v_etl_context_orga_area AS SELECT client_id,
 country_cd,
 cluster_area_cd AS area_cd,
 cluster_area_type AS area_grp_type,
 cluster_type
FROM ldl_etl_process.t_client_cluster_hierarchy_maindef;