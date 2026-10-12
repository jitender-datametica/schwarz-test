CREATE OR REPLACE VIEW kfl_production_dbp_view.v_prozessbereich_spr_zu_1 (system_id, mandant_id, prozessbereich_id, spr_id
, prozessbereich_bez, td_update, td_insert) AS SELECT system_id,
 mandant_id,
 prozessbereich_id,
 spr_id,
 prozessbereich_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.prozessbereich_spr_zu_1;