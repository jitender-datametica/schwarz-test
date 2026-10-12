CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_objektart_spr_zu AS SELECT objektart_id,
 mandant_id,
 spr_id,
 objektart_bez
FROM kfl_production_dbp_data.ivs_objektart_spr_zu;