CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_gf (gf_id, gf_name, mandant_id, ek_fg) AS SELECT gf_id,
 gf_name,
 mandant_id,
 ek_fg
FROM kfl_production_dbp_view.v_gf
WHERE ek_fg = 0
 AND mandant_id > 1;