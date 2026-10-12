CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_kmr_l_leitende_abteilung (leit_abteilung_id, amx_system_id,
leit_abteilung_bez) AS SELECT leit_abteilung_id,
 amx_system_id,
 leit_abteilung_bez
FROM kfl_production_dbp_view.v_kmr_l_leitende_abteilung AS V01;