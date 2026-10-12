CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kl_wg_nielsen_gfk_hhp_wg_zu AS SELECT mandant_id,
 kl_wg_id,
 gfk_wg_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.kl_wg_nielsen_gfk_hhp_wg_zu;