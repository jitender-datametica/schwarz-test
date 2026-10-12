CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_vs_2 (vs_id, vs_bez, vk_id, mandant_id, vsvt_bez) AS SELECT
 vs_id,
 vs_bez,
 vk_id,
 mandant_id,
 vsvt_bez
FROM kfl_production_dbp_view.v_vs_2 AS V01;