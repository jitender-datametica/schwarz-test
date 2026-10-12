CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_ts_artikel_zuordnung (mandant_id, ean_id, art_id,
kl_owg_id, kl_uwg_id) AS SELECT mandant_id,
 ean_id,
 art_id,
 wg_id AS kl_owg_id,
 wug_id AS kl_uwg_id
FROM kfl_production_dbp_view.v_ts_artikel_zuordnung;