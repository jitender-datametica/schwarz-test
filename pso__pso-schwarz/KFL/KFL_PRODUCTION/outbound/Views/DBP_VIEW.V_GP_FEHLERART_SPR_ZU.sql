CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gp_fehlerart_spr_zu AS SELECT system_id,
 mandant_id,
 spr_id,
 gp_fehlerart_id,
 gp_fehlerart_bez
FROM kfl_production_dbp_data.gp_fehlerart_spr_zu;