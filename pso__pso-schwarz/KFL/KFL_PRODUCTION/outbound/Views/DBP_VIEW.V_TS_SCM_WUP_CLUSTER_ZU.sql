CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ts_scm_wup_cluster_zu AS SELECT mandant_id,
 wup_id,
 wup_cluster_id,
 nb_id
FROM kfl_production_dbp_data.ts_scm_wup_cluster_zu;