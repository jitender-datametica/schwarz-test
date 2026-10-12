CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lohnart_spr_zu_2 (mandant_id, lohnart_id, spr_id, lohnart_bez) AS SELECT
 mandant_id,
 lohnart_id,
 spr_id,
 lohnart_bez
FROM kfl_production_dbp_data.lohnart_spr_zu_2;