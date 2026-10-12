CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_ek_gf_2 (gf_id, gf_name, mandant_id, ek_flg) AS SELECT gf_id,
 gf_name,
 mandant_id,
 ek_fg AS ek_flg
FROM kfl_production_dbp_view.v_gf_2
WHERE ek_fg = 1;