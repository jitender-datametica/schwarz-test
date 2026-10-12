CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_lin_maks_agg_1 (mandant_id, wup_id, ausbildung_id,
lin_kursgruppe_id, kjmo, lehrjahr, bestanden, mitarbeiter_in_lin_aktiv, lernpensum_soll, lehrjahr_monate) AS SELECT V01
 .mandant_id,
 V01.wup_id,
 V01.ausbildung_id,
 v02.lin_kursgruppe_id,
 V01.kjmo,
 V01.rate_group AS lehrjahr,
 SUM(V01.learning_historie_fg) AS bestanden,
 COUNT(DISTINCT V01.maks_id) AS mitarbeiter_in_lin_aktiv,
 AVG(CASE
   WHEN DATE_DIFF(V03.max_dat, V01.dat_ausbildung_von, DAY) / 30.4 * (v04.anzahl_kurse / (DATE_DIFF(V01.dat_ausbildung_bis
           ,V01.dat_ausbildung_von, DAY) - v02.pauschalabzug - v02.sonderabzug)) > v04.anzahl_kurse
   THEN v04.anzahl_kurse
   ELSE DATE_DIFF(V03.max_dat, V01.dat_ausbildung_von, DAY) / 30.4 * (v04.anzahl_kurse / (DATE_DIFF(V01.dat_ausbildung_bis
          ,V01.dat_ausbildung_von, DAY) - v02.pauschalabzug - v02.sonderabzug))
   END) AS lernpensum_soll,
 AVG(DISTINCT DATE_DIFF(V03.max_dat, V01.dat_ausbildung_von, DAY) / 30.4) AS lehrjahr_monate
FROM kfl_production_dbp_view.v_linbew_maks_1 AS V01
 LEFT JOIN (SELECT mandant_id,
   ausbildung_id,
   lin_kursgruppe_id,
   sonderabzug,
   pauschalabzug
  FROM kfl_production_dbp_msi_view_vis.mv_l_lin_taetigkeiten_1) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.ausbildung_id
     = v02.ausbildung_id AND V01.wup_id BETWEEN 1 AND 8999
 LEFT JOIN kfl_production_dbp_view.v_monat_1 AS V03 ON V01.kjmo = V03.kjmo
 LEFT JOIN (SELECT mandant_id,
   ausbildung_id,
   kjmo,
   CAST(COUNT(DISTINCT lin_kurs_id) AS NUMERIC) AS anzahl_kurse
  FROM kfl_production_dbp_view.v_linbew_maks_1
  WHERE wup_id BETWEEN 1 AND 8999
  GROUP BY mandant_id,
   ausbildung_id,
   kjmo) AS v04 ON V01.mandant_id = v04.mandant_id AND V01.ausbildung_id = v04.ausbildung_id AND V01.kjmo = v04.kjmo
GROUP BY V01.mandant_id,
 V01.wup_id,
 V01.ausbildung_id,
 v02.lin_kursgruppe_id,
 V01.kjmo,
 lehrjahr;