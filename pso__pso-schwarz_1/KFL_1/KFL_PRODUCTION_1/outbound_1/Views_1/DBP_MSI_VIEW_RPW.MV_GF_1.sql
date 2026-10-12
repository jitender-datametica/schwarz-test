CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_gf_1 (gf_id, mandant_id, ek_fg, gf_name, system_id) AS SELECT
 gf_id,
 mandant_id,
 ek_fg,
 gf_name,
 7 AS system_id
FROM kfl_production_dbp_view.v_gf_1
WHERE mandant_id = 1
 AND ek_fg = 0;