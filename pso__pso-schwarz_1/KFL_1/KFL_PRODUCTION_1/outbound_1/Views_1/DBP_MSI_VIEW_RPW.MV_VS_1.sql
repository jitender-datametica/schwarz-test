CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_vs_1 (vs_id, vs_bez, vk_id, mandant_id, vsvt_bez, system_id) AS
SELECT vs_id,
 vs_bez,
 vk_id,
 mandant_id,
 vsvt_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_vs_1
WHERE mandant_id = 1;