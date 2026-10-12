CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_gf AS SELECT mandant_id,
 gf_id,
 ek_fg,
 gf_name
FROM kfl_production_dbp_view.v_gf
WHERE ek_fg = 1;