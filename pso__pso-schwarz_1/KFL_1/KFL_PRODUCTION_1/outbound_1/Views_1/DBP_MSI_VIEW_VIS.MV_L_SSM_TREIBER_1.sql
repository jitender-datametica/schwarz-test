CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_ssm_treiber_1 AS SELECT mandant_id,
 treiber_id,
 dat_von,
 treiber_bez,
 dat_bis,
 aufgabe_tages_versatz
FROM kfl_production_dbp_view.v_l_ssm_treiber_1;