CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_in_wg_spr_zu_ro_2 AS SELECT in_wg_id,
 in_wg_bez
FROM kfl_production_dbp_view.v_in_wg_spr_zu_2
WHERE mandant_id = 7
 AND spr_id = 95;