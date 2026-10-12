CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_back_wug_cluster AS SELECT mandant_id,
 wug_cluster_id,
 wug_cluster_bez
FROM kfl_production_dbp_data.l_back_wug_cluster;