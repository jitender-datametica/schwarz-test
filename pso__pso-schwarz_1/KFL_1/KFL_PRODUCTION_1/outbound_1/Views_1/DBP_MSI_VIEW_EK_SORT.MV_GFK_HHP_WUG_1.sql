CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_gfk_hhp_wug_1 AS SELECT V01.mandant_id,
 V01.gfk_wg_id,
 V01.gfk_wug_id,
 V02.gfk_wg_bez,
 V01.gfk_wug_bez
FROM kfl_production_dbp_view.v_gfk_hhp_wug_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_gfk_hhp_wg_1 AS V02 ON V01.gfk_wg_id = V02.gfk_wg_id AND V01.mandant_id = V02.mandant_id;