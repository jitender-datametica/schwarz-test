CREATE OR REPLACE VIEW kfl_production_dbp_view.v_verrechfallart_spr_zu AS SELECT mandant_id,
 verrechfallart_id,
 spr_id,
 verrechfallart_bez
FROM kfl_production_dbp_data.verrechfallart_spr_zu;