CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vkl_vaus AS SELECT mandant_id,
 ma_id AS vkl_id,
 ma_anrede,
 ma_name,
 ma_vorname
FROM kfl_production_dbp_view.v_ma_spr_zu
WHERE spr_id = 22
 AND (mandant_id, ma_id) IN (SELECT (mandant_id, vkl_id)
   FROM kfl_production_dbp_msi_v_view.v_wup_denorm);