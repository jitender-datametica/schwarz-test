CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_art_wup_status_per_vz_1 AS SELECT art_id,
 dat_bis,
 dat_von,
 loesch_id,
 mandant_id,
 nb_id,
 wup_id,
 wg_verkett_id,
 fremd_lagerort_id,
 disponent_id,
 system_id,
 pps_plan_kalender_id,
 disposition_rhythmus_id,
 planlieferzeit,
 dispomerkmal,
 we_bearbeitungszeit,
 min_sicherh_bestand,
 anliefer_kalender,
 kdis,
 bezugsweg_id,
 terminierungsgruppe_1_id,
 terminierungsgruppe_2_id,
 terminierungsgruppe_3_id,
 sollbestand,
 dat_loesch_id,
  CASE
  WHEN EXISTS (SELECT 1
   FROM kfl_production_dbp_view.v_art_list_wup_zu_per_1 AS V02
   WHERE DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN dat_von AND dat_bis
    AND V01.mandant_id = mandant_id
    AND V01.wup_id = wup_id
    AND V01.art_id = art_id)
  THEN 1
  ELSE 0
  END AS aktuelle_listung_fg,
 min_restlaufzeit,
 selbstabholung_fg
FROM kfl_production_dbp_view.v_art_wup_status_per_1 AS V01
WHERE dat_bis = DATE '9999-12-31'
 AND nb_id = - 111;