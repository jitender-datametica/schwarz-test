CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ssm_wup_prozess_werbeverteilung AS SELECT mandant_id,
 wup_id,
 nb_id,
 ssm_prozess_id,
 dat,
 wert
FROM kfl_production_dbp_view.v_ssm_wup_prozess_werbeverteilung;