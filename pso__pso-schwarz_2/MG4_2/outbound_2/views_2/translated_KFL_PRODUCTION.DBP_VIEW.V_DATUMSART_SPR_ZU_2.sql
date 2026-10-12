CREATE OR REPLACE VIEW kfl_production_dbp_view.v_datumsart_spr_zu_2 (mandant_id, datumsart_id, spr_id, datumsart_bez) AS
SELECT mandant_id,
 datumsart_id,
 spr_id,
 datumsart_bez
FROM kfl_production_dbp_data.datumsart_spr_zu_2;