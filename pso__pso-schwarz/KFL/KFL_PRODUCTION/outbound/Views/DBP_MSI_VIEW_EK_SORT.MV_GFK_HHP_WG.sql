CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_gfk_hhp_wg (mandant_id, gfk_wg_id, gfk_wg_bez) AS SELECT
 mandant_id,
 gfk_wg_id,
 gfk_wg_bez
FROM kfl_production_dbp_view.v_gfk_hhp_wg;