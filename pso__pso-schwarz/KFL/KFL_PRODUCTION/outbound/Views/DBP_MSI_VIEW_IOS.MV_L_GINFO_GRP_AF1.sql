CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_l_ginfo_grp_af1 AS SELECT grp_id AS grp_1_id,
 grp_bez
FROM kfl_production_dbp_msi_v_view.v_l_ginfo_grp
WHERE ebene_id = 1;