CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_pc_denorm (pc_lv2, pc_bez2, pc_lv4, pc_bez4, pc_hiertyp_id) AS
SELECT pc_lv2,
 pc_bez2,
 pc_lv4,
 pc_bez4,
 pc_hiertyp_id
FROM kfl_production_dbp_msi_v_view.v_pc_pc_grp_denorm AS D
WHERE pc_hiertyp_id = 1
GROUP BY pc_lv2,
 pc_bez2,
 pc_lv4,
 pc_bez4,
 pc_hiertyp_id;