CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_ssm_cluster AS SELECT mandant_id,
 wup_bereich_id,
 wup_abt_id,
 ssm_cluster_id
FROM kfl_production_dbp_view.v_l_ssm_cluster;