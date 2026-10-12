CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_sort_kl_wg_nielsen_gfk_hhp_wg_zu_1 (mandant_id, kl_wg_id,
gfk_wg_id) AS SELECT mandant_id,
 kl_wg_id,
 gfk_wg_id
FROM kfl_production_dbp_data.kl_wg_nielsen_gfk_hhp_wg_zu_1;