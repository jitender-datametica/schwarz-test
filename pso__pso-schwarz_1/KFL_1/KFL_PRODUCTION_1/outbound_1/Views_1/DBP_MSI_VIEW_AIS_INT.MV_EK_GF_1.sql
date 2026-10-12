CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_ek_gf_1 (ek_gf_id, ek_gf_name, mandant_id, ek_fg) AS SELECT
 gf_id AS ek_gf_id,
 gf_name AS ek_gf_name,
 mandant_id,
 ek_fg
FROM kfl_production_dbp_view.v_gf_1
WHERE ek_fg = 1;