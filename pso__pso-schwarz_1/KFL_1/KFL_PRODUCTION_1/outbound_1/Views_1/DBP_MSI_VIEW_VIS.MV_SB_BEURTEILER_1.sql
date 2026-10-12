CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sb_beurteiler_1 AS SELECT mandant_id,
 beurteiler_id,
 COALESCE(ma_id, - 1) AS ma_id,
 anz_sb_soll,
 anz_sb_rot_bis,
 anz_sb_gelb_bis,
 operativ_fg
FROM kfl_production_dbp_view.v_sb_beurteiler_1 AS V01;