CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_saison AS SELECT mandant_id,
 saison_id
FROM kfl_production_dbp_view.v_l_saison;