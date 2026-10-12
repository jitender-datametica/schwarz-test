CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_gs_l_profil AS SELECT mandant_id,
 profil_id
FROM kfl_production_dbp_view.v_l_profil AS V01;