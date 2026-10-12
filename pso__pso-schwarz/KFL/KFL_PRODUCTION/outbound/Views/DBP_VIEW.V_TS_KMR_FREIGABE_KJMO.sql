CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ts_kmr_freigabe_kjmo AS SELECT mandant_id,
 kjmo,
 freigabe_fg
FROM kfl_production_dbp_data.ts_kmr_freigabe_kjmo;