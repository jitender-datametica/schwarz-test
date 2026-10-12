CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_l_mietart_2 AS SELECT mietart_id,
 mandant_id,
 spr_id,
 mietart_bez
FROM kfl_production_dbp_view.v_ivs_l_mietart_2
WHERE spr_id = 22;