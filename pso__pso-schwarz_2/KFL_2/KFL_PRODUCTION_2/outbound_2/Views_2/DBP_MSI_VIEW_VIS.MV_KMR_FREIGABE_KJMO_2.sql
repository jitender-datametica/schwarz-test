CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_freigabe_kjmo_2 (kjmo, mandant_id, freigabe_fg) AS SELECT
 kjmo,
 mandant_id,
 freigabe_fg
FROM kfl_production_dbp_view.v_ts_kmr_freigabe_kjmo_2;