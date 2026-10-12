CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artkz_display (display_id, mandant_id, spr_id, display_bez, td_insert,
td_update) AS SELECT *
FROM kfl_production_dbp_data.artkz_display;