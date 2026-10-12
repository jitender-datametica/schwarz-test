CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_in_wg_spr_zu_1 AS SELECT in_wg_id,
 in_wg_bez
FROM kfl_production_dbp_view.v_in_wg_spr_zu_1
WHERE mandant_id = 1
 AND spr_id = 22;