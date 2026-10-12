CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_gf AS SELECT gf_id,
 gf_name,
 mandant_id,
 ek_fg
FROM kfl_production_dbp_view.v_gf;