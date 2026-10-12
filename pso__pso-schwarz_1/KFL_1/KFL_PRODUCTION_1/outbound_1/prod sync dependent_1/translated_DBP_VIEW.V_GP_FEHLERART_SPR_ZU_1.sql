CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gp_fehlerart_spr_zu_1 (system_id, mandant_id, spr_id, gp_fehlerart_id,
gp_fehlerart_bez) AS SELECT system_id,
 mandant_id,
 spr_id,
 gp_fehlerart_id,
 gp_fehlerart_bez
FROM kfl_production_dbp_data.gp_fehlerart_spr_zu_1;