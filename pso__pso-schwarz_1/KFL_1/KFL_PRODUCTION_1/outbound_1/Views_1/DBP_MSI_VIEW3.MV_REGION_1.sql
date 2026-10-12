CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_region_1 AS SELECT mandant_id,
 vs_id,
 vs_bez,
 vsvt_bez
FROM kfl_production_dbp_view.v_vs_1 AS V01;