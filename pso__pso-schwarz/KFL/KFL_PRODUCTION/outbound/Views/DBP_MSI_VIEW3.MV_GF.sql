CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_gf (ek_fg, gf_id, gf_name, mandant_id) AS SELECT ek_fg,
 gf_id,
 gf_name,
 mandant_id
FROM kfl_production_dbp_view.v_gf
WHERE ek_fg = 0;