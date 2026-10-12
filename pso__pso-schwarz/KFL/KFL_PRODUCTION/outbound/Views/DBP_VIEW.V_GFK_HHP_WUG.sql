CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gfk_hhp_wug AS SELECT mandant_id,
 gfk_wg_id,
 gfk_wug_id,
 gfk_wug_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.gfk_hhp_wug;