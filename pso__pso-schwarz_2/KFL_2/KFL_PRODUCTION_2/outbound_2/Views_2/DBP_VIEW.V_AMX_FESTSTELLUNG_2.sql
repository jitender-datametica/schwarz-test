CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_feststellung_2 AS SELECT feststellung_id,
 amx_system_id,
 pruefung_id,
 pruef_kapitel_id,
 amx_frage_id,
 feststellung_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.amx_feststellung_2;