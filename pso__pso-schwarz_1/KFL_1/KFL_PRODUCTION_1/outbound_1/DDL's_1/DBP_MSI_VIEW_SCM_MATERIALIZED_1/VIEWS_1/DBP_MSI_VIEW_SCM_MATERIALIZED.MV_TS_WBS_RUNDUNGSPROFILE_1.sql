-- 2024-02-22, AP0195159, SPEC0233442, dknop, initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_ts_wbs_rundungsprofile_1 (mandant_id,
rundungsprofil_id, wbs_relevant_fg, aufrundung_ab_prozent, abrundung_bis_prozent, rundung_ziel_einh_id) AS SELECT
 mandant_id,
 rundungsprofil_id,
 wbs_relevant_fg,
 aufrundung_ab_prozent,
 abrundung_bis_prozent,
 rundung_ziel_einh_id
FROM kfl_production_dbp_msi_data.ts_wbs_rundungsprofile_1;