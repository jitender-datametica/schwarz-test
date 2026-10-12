CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ek_gf_1 (gf_id, gf_name, mandant_id, ek_fg) AS SELECT gf_id,
 gf_name,
 mandant_id,
 ek_fg
FROM kfl_production_dbp_view.v_gf_1 AS V01
WHERE ek_fg = 1;