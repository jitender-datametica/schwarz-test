CREATE OR REPLACE VIEW kfl_production_dbp_view.v_transportart_spr_zu AS SELECT mandant_id,
 transportart_id,
 spr_id,
 transportart_bez
FROM kfl_production_dbp_data.transportart_spr_zu;