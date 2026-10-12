CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artkz_display_1 (display_id, mandant_id, spr_id, display_bez, td_insert,
td_update) AS SELECT display_id,
 mandant_id,
 spr_id,
 display_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.artkz_display_1;