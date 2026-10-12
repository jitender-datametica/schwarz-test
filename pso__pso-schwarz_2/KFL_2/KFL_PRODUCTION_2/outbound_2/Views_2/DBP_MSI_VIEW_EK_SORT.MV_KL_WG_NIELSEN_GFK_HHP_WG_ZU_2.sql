CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_kl_wg_nielsen_gfk_hhp_wg_zu_2 (mandant_id, kl_wg_id,
gfk_wg_id) AS SELECT mandant_id,
 kl_wg_id,
 gfk_wg_id
FROM kfl_production_dbp_view.v_kl_wg_nielsen_gfk_hhp_wg_zu_2;