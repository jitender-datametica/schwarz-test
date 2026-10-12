CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kontrakt_gueltigkeit_spr_zu_1 AS SELECT mandant_id,
 spr_id,
 kontrakt_gueltigkeit_id,
 kontrakt_gueltigkeit_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.kontrakt_gueltigkeit_spr_zu_1;