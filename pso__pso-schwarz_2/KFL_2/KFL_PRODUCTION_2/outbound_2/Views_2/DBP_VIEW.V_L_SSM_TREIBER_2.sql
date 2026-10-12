CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_ssm_treiber_2 AS SELECT mandant_id,
 treiber_id,
 dat_von,
 dat_bis,
 treiber_bez,
 aufgabe_tages_versatz
FROM kfl_production_dbp_data.l_ssm_treiber_2;