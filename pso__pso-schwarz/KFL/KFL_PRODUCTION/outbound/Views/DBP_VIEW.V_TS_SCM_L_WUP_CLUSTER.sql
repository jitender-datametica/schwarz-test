CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ts_scm_l_wup_cluster AS SELECT mandant_id,
 wup_cluster_id,
 wup_cluster_bez,
 wup_cluster_descr,
 wup_cluster_del_fg,
 update_timestamp,
 update_user
FROM kfl_production_dbp_data.ts_scm_l_wup_cluster;