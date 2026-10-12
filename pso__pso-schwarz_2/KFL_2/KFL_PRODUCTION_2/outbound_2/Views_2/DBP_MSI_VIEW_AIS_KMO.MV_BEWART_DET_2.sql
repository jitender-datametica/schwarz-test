CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_bewart_det_2 AS SELECT mandant_id,
 bewart_det_id,
 bewart_det_bez
FROM kfl_production_dbp_view.v_bewart_det_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;