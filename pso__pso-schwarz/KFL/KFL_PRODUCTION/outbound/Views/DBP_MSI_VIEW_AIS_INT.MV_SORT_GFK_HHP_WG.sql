CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_sort_gfk_hhp_wg (mandant_id, gfk_wg_id, gfk_wg_bez) AS
SELECT mandant_id,
 gfk_wg_id,
 gfk_wg_bez
FROM kfl_production_dbp_data.gfk_hhp_wg;