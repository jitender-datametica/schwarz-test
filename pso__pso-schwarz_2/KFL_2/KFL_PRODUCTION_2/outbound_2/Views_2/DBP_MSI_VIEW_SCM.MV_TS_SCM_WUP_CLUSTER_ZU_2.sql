-- 2025-07-16 | nwag | switch to dt
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ts_scm_wup_cluster_zu_2 (mandant_id
, wup_id, nb_id, wup_cluster_id, wup_cluster_zu_fg) AS SELECT mandant_id,
 wup_id,
 nb_id,
 wup_cluster_id,
 wup_cluster_zu_fg
FROM kfl_production_dbp_msi_view_scm.mv_dt_ts_scm_wup_cluster_zu_2;