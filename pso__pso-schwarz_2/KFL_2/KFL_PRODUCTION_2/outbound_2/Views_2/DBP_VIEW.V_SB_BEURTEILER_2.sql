CREATE OR REPLACE VIEW kfl_production_dbp_view.v_sb_beurteiler_2 AS SELECT beurteiler_id,
 mandant_id,
 ma_id,
 anz_sb_soll,
 anz_sb_rot_bis,
 anz_sb_gelb_bis,
 operativ_fg
FROM kfl_production_dbp_data.sb_beurteiler_2;