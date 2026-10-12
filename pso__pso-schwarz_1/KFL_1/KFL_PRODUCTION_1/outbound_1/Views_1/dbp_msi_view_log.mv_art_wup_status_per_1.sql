CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_art_wup_status_per_1 AS SELECT V01.art_id,
 V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.dat_von,
 V01.system_id,
 V01.loesch_id,
 V01.dat_bis,
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
 V01.bezugsweg_id,
 V01.terminierungsgruppe_1_id,
 V01.terminierungsgruppe_2_id,
 V01.terminierungsgruppe_3_id,
 V01.sollbestand,
 V01.dat_loesch_id,
 V01.selbstabholung_fg,
 V01.min_restlaufzeit,
 v02.lagernummer_id
FROM kfl_production_dbp_view.v_art_wup_status_per_1 AS V01
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   nb_id,
   lagernummer_id
  FROM kfl_production_dbp_view.v_l_lagernummer_1
  WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
   AND LENGTH(TRIM(lagernummer_id)) = 4) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.wup_id = v02.wup_id AND V01.nb_id
    = v02.nb_id
WHERE V01.dat_bis = DATE '9999-12-31'
 AND V01.nb_id = - 111;