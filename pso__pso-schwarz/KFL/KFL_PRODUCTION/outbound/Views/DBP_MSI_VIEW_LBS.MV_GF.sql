CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_gf (gf_id, mandant_id, ek_fg, gf_name) AS SELECT gf_id,
 mandant_id,
 ek_fg,
 gf_name
FROM kfl_production_dbp_view.v_gf
WHERE ek_fg = 0;