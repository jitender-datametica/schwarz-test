CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_hyg_l_audit AS SELECT hyg_audit_id,
 audit_instance_id,
 audit_instance_bez,
 notes,
 gj
FROM kfl_production_dbp_view.v_hyg_audit;