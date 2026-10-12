CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ts_wbs_rundungsprofile (mandant_id, rundungsprofil_id,
wbs_relevant_fg, aufrundung_ab_prozent, abrundung_bis_prozent, rundung_ziel_einh_id) AS SELECT mandant_id,
 rundungsprofil_id,
 wbs_relevant_fg,
 aufrundung_ab_prozent,
 abrundung_bis_prozent,
 rundung_ziel_einh_id
FROM kfl_production_dbp_msi_data.ts_wbs_rundungsprofile;