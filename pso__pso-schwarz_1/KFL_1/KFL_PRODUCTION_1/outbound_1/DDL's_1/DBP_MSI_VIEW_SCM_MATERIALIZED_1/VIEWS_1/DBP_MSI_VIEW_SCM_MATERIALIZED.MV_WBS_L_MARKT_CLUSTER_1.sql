-- 2024-02-15, AP0187197, SPEC0234136, initial, dknop

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_wbs_l_markt_cluster_1 (mandant_id,
init_lief_markt_cluster_id) AS SELECT mandant_id,
 init_lief_markt_cluster_id
FROM kfl_production_dbp_data.wbs_l_markt_cluster_initiale_belieferung_1;