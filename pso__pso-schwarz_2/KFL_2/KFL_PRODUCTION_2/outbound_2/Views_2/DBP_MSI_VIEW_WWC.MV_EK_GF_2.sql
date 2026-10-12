CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_ek_gf_2 (mandant_id, gf_id, ek_gf_id, gf_name, ek_gf_name,
ek_flg) AS SELECT mandant_id,
 gf_id,
 gf_id AS ek_gf_id,
 gf_name,
 gf_name AS ek_gf_name,
 ek_fg AS ek_flg
FROM kfl_production_dbp_view.v_gf_2
WHERE mandant_id = 1
 AND ek_fg = 1;