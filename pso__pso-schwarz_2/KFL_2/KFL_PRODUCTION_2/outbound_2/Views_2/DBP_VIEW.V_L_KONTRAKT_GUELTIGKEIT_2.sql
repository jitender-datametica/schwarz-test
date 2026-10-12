CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_kontrakt_gueltigkeit_2 AS SELECT mandant_id,
 kontrakt_gueltigkeit_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_kontrakt_gueltigkeit_2;