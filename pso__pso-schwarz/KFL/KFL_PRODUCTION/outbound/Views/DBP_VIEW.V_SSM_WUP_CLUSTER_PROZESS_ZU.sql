CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ssm_wup_cluster_prozess_zu AS SELECT mandant_id,
 wup_id,
 nb_id,
 ssm_cluster_id,
 ssm_prozess_id,
 dat_von,
 dat_bis,
 wup_bereich_id,
 wup_abt_id
FROM kfl_production_dbp_data.ssm_wup_cluster_prozess_zu;