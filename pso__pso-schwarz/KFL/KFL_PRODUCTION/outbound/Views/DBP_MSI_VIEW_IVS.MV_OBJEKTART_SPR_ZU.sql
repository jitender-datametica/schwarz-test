CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_objektart_spr_zu AS SELECT mandant_id,
 objektart_id,
 objektart_bez,
 spr_id
FROM kfl_production_dbp_view.v_ivs_objektart_spr_zu
WHERE spr_id = 22;