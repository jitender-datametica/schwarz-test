CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_art_kunde_status_per (art_id, dat_bis, dat_von,
mandant_id, nb_id, kunde_id, fremd_lagerort_id, disponent_id, system_id, pps_plan_kalender_id, disposition_rhythmus_id,
planlieferzeit, dispomerkmal, we_bearbeitungszeit, min_sicherh_bestand, anliefer_kalender, mandant_id_kunde,
terminierungsgruppe_1_id, terminierungsgruppe_2_id, terminierungsgruppe_3_id) AS SELECT V01.art_id,
 V01.dat_bis,
 V01.dat_von,
 V01.mandant_id,
 V01.nb_id,
 V05.aktuell_wup_id AS kunde_id,
 V01.fremd_lagerort_id,
 V01.disponent_id,
 V01.system_id,
 V01.pps_plan_kalender_id,
 V01.disposition_rhythmus_id,
 V01.planlieferzeit,
 V01.dispomerkmal,
 V01.we_bearbeitungszeit,
 V01.min_sicherh_bestand,
 V01.anliefer_kalender,
 V01.mandant_id AS mandant_id_kunde,
 V01.terminierungsgruppe_1_id,
 V01.terminierungsgruppe_2_id,
 V01.terminierungsgruppe_3_id
FROM kfl_production_dbp_view.v_art_wup_status_per AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS V05 ON V01.mandant_id = V05.mandant_id AND V01.wup_id = V05.wup_id AND (V05
      .nb_id IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id = 0)
WHERE V01.dat_bis = DATE '9999-12-31'
 AND V01.nb_id = 0;