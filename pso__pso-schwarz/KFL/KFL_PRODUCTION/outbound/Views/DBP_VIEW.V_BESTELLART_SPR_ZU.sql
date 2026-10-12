CREATE OR REPLACE VIEW kfl_production_dbp_view.v_bestellart_spr_zu AS SELECT mandant_id,
 bestellart_id,
 spr_id,
 bestellart_bez
FROM kfl_production_dbp_data.bestellart_spr_zu;