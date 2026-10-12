CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_sort_gfk_hhp_wug (mandant_id, gfk_wg_id, gfk_wug_id,
gfk_wg_bez, gfk_wug_bez) AS SELECT V01.mandant_id,
 V01.gfk_wg_id,
 V01.gfk_wug_id,
 V02.gfk_wg_bez,
 V01.gfk_wug_bez
FROM kfl_production_dbp_data.gfk_hhp_wug AS V01
 INNER JOIN kfl_production_dbp_data.gfk_hhp_wg AS V02 ON V01.gfk_wg_id = V02.gfk_wg_id AND V01.mandant_id = V02.mandant_id;