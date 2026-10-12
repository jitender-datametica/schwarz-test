CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ts_artikel_zuordnung_1 AS SELECT mandant_id,
 ean_id,
 art_id,
 wg_id,
 wug_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.ts_artikel_zuordnung_1;