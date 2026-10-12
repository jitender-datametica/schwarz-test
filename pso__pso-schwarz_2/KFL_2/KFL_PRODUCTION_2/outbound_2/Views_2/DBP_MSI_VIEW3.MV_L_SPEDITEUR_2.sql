CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_spediteur_2 (mandant_id, spediteur_id, spediteur_name) AS SELECT
 mandant_id,
 spediteur_id,
 spediteur_name
FROM kfl_production_dbp_view.v_l_spediteur_2;