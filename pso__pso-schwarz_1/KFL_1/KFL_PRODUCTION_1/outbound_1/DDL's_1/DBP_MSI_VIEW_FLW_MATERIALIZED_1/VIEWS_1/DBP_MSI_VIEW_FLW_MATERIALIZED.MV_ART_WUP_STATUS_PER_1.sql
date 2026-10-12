CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_art_wup_status_per_1 (art_id, mandant_id, wup_id,
nb_id, dat, loesch_id, wg_verkett_id, fremd_lagerort_id, disponent_id, pps_plan_kalender_id, disposition_rhythmus_id,
planlieferzeit, dispomerkmal, we_bearbeitungszeit, min_sicherh_bestand, anliefer_kalender, kdis, bezugsweg_id) AS SELECT
 V01.art_id,
 V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 T.dat,
 V01.loesch_id,
 V01.wg_verkett_id,
 V01.fremd_lagerort_id,
 V01.disponent_id,
 V01.pps_plan_kalender_id,
 V01.disposition_rhythmus_id,
 V01.planlieferzeit,
 V01.dispomerkmal,
 V01.we_bearbeitungszeit,
 V01.min_sicherh_bestand,
 V01.anliefer_kalender,
 V01.kdis,
 V01.bezugsweg_id
FROM kfl_production_dbp_view.v_art_wup_status_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS T ON T.dat BETWEEN V01.dat_von AND V01.dat_bis
WHERE V01.mandant_id IN (1, 2);