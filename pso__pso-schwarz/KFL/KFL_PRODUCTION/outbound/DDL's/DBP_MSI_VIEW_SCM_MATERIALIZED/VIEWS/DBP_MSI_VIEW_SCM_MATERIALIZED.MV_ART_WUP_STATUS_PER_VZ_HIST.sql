CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_art_wup_status_per_vz_hist (art_id, loesch_id,
mandant_id, nb_id, wup_id, wg_verkett_id, fremd_lagerort_id, disponent_id, system_id, pps_plan_kalender_id,
disposition_rhythmus_id, planlieferzeit, dispomerkmal, we_bearbeitungszeit, min_sicherh_bestand, anliefer_kalender, kdis
, bezugsweg_id, terminierungsgruppe_1_id, terminierungsgruppe_2_id, terminierungsgruppe_3_id, dat_loesch_id, dat,
aktuelle_listung_fg) AS -- listung läuft besser als subselect
 SELECT V01.art_id,
 V01.loesch_id,
 V01.mandant_id,
 V01.nb_id,
 V01.wup_id,
 V01.wg_verkett_id,
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
 V01.kdis,
 V01.bezugsweg_id,
 V01.terminierungsgruppe_1_id,
 V01.terminierungsgruppe_2_id,
 V01.terminierungsgruppe_3_id,
 V01.dat_loesch_id,
 V03.dat,
  CASE
  WHEN v02.wup_id IS NULL
  THEN 0
  ELSE 1
  END AS aktuelle_listung_fg
FROM kfl_production_dbp_view.v_art_wup_status_per AS V01
 INNER JOIN kfl_production_dbp_view.v_tag AS V03 ON V03.dat BETWEEN V01.dat_von AND V01.dat_bis
 LEFT JOIN (SELECT V010.mandant_id,
   V010.wup_id,
   V010.nb_id,
   V010.art_id,
   V030.dat
  FROM kfl_production_dbp_view.v_art_list_wup_zu_per AS V010
   INNER JOIN kfl_production_dbp_view.v_tag AS V030 ON V030.dat BETWEEN V010.dat_von AND V010.dat_bis
  WHERE V010.nb_id = -111
   AND V030.dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 1095 DAY) AND (CURRENT_DATE)
  GROUP BY V010.art_id,
   V010.wup_id,
   V010.nb_id,
   V010.mandant_id,
   V030.dat) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.wup_id = v02.wup_id AND V01.art_id = v02.art_id AND V01.nb_id
     = v02.nb_id AND V03.dat = v02.dat
WHERE V03.dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 1095 DAY) AND (CURRENT_DATE)
 AND V03.akt_kj BETWEEN -2 AND 0
 AND V01.nb_id = -111 -- nur VZ, Märkte = andere View!;