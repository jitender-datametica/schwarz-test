CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_art_wup_status_per_hist_markt_1 AS SELECT V01.art_id,
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
FROM kfl_production_dbp_view.v_art_wup_status_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS V03 ON V03.dat BETWEEN V01.dat_von AND V01.dat_bis AND V03.dat BETWEEN
     DATE_SUB(CURRENT_DATE, INTERVAL 1095 DAY) AND (CURRENT_DATE) AND V03.akt_kj BETWEEN - 2 AND 0 AND V01.nb_id = 0
 LEFT JOIN (SELECT V010.mandant_id,
   V010.wup_id,
   V010.nb_id,
   V010.art_id,
   V030.dat
  FROM kfl_production_dbp_view.v_art_list_wup_zu_per_1 AS V010
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS V030 ON V030.dat BETWEEN V010.dat_von AND V010.dat_bis
  WHERE V010.nb_id = 0
   AND V030.dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 1095 DAY) AND (CURRENT_DATE)
  GROUP BY V010.art_id,
   V010.wup_id,
   V010.nb_id,
   V010.mandant_id,
   V030.dat) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.wup_id = v02.wup_id AND V01.art_id = v02.art_id AND V01.nb_id
     = v02.nb_id AND V03.dat = v02.dat
WHERE V03.dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 1095 DAY) AND (CURRENT_DATE)
 AND V03.akt_kj BETWEEN - 2 AND 0
 AND V01.nb_id = 0;