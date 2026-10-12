CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_l_mietart AS SELECT mandant_id,
 mietart_id,
 spr_id,
 mietart_bez
FROM kfl_production_dbp_data.ivs_l_mietart;