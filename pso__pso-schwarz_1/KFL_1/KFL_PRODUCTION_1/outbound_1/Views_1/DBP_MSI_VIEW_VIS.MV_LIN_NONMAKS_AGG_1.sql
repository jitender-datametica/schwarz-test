CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_lin_nonmaks_agg_1 (mandant_id, lin_kurs_id, hr_objekt_id, kjmo,
unternehmens_bereich_id, anzahl_kurse_gesamt, anzahl_kurse_abgeschlossen, ki_fg, wup_id, kurs_ampel, markt_ampel) AS
SELECT v01.mandant_id,
 v01.lin_kurs_id,
 v01.hr_objekt_id,
 V02.kjmo,
 v01.unternehmens_bereich_id,
 v01.anzahl_kurse_gesamt,
 v01.anzahl_kurse_abgeschlossen,
 v01.ki_fg,
 v01.wup_id,
  CASE
  WHEN CAST(v01.anzahl_kurse_abgeschlossen AS NUMERIC) / CAST(v01.anzahl_kurse_gesamt AS NUMERIC) < 0.795
  THEN 'rot'
  WHEN CAST(v01.anzahl_kurse_abgeschlossen AS NUMERIC) / CAST(v01.anzahl_kurse_gesamt AS NUMERIC) >= 0.895
  THEN 'gruen'
  ELSE 'gelb'
  END AS kurs_ampel,
  CASE
  WHEN CAST(SUM(v01.anzahl_kurse_abgeschlossen) OVER (PARTITION BY CAST(V02.kjmo AS STRING), CAST(v01.mandant_id AS STRING)
        , CAST(v01.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS NUMERIC) / CAST(COUNT(v01.lin_kurs_id) OVER (PARTITION BY CAST(V02.kjmo AS STRING)
        , CAST(v01.mandant_id AS STRING), CAST(v01.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS NUMERIC) < 0.795
  THEN 'rot'
  WHEN CAST(SUM(v01.anzahl_kurse_abgeschlossen) OVER (PARTITION BY CAST(V02.kjmo AS STRING), CAST(v01.mandant_id AS STRING)
        , CAST(v01.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS NUMERIC) / CAST(COUNT(v01.lin_kurs_id) OVER (PARTITION BY CAST(V02.kjmo AS STRING)
        , CAST(v01.mandant_id AS STRING), CAST(v01.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS NUMERIC) >= 0.895
  THEN 'gruen'
  ELSE 'gelb'
  END AS markt_ampel
FROM (SELECT V01.mandant_id,
   V01.lin_kurs_id,
   V01.hr_objekt_id,
   V01.dat,
   V01.unternehmens_bereich_id,
   V01.ki_fg,
   WUP.aktuell_wup_id AS wup_id,
   SUM(V01.anzahl_kurse_gesamt) AS anzahl_kurse_gesamt,
   SUM(V01.anzahl_kurse_abgeschlossen) AS anzahl_kurse_abgeschlossen
  FROM kfl_production_dbp_view.v_linbew_nonmaks_1 AS V01
   INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id
  WHERE V01.wup_id BETWEEN 1 AND 8999
  GROUP BY V01.mandant_id,
   V01.lin_kurs_id,
   V01.hr_objekt_id,
   V01.dat,
   V01.unternehmens_bereich_id,
   V01.ki_fg,
   wup_id) AS v01
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS V02 ON v01.dat = V02.dat
WHERE v01.wup_id BETWEEN 1 AND 8999
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(v01.mandant_id AS STRING), v01.lin_kurs_id, v01.hr_objekt_id, CAST(v01.wup_id AS STRING)
      , v01.unternehmens_bereich_id, CAST(V02.kjmo AS STRING) ORDER BY v01.dat IS NULL, v01.dat)) = 1;