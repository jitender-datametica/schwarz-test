CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_region (mandant_id, vs_id, vs_bez, vsvt_bez) AS
SELECT mandant_id,
 vs_id,
 vs_bez,
 vsvt_bez
FROM kfl_production_dbp_view.v_vs AS V01;