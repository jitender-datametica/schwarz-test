CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artkz_posten AS SELECT posten_id,
 mandant_id,
 spr_id,
 posten_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.artkz_posten;