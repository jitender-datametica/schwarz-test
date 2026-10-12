CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_l_bereich_2 (geku_bereich_uid, geku_bereich_id, kdc_fg,
mzk_fg, wmd_fg) AS SELECT geku_bereich_uid,
 geku_bereich_id,
 kdc_fg,
 mzk_fg,
 wmd_fg
FROM kfl_production_dbp_view.v_l_geku_bereich_2;