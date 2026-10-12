CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_vs_1 (mandant_id, vs_id, vs_bez, vsvt_bez) AS SELECT
 mandant_id,
 vs_id,
 vs_bez,
 vsvt_bez
FROM kfl_production_dbp_view.v_vs_1 AS v01;