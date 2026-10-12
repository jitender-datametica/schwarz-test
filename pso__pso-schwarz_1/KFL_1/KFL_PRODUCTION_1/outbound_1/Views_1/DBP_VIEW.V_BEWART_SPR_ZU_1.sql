CREATE OR REPLACE VIEW kfl_production_dbp_view.v_bewart_spr_zu_1 AS SELECT spr_id,
 bewart_id,
 bewart_bez,
 mandant_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.bewart_spr_zu_1;