CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_ek_gf_2 (gf_id, gf_name, mandant_id, ek_flg, system_id) AS
SELECT gf_id,
 gf_name,
 mandant_id,
 ek_fg AS ek_flg,
 7 AS system_id
FROM kfl_production_dbp_view.v_gf_2
WHERE mandant_id = 1
 AND ek_fg = 1;