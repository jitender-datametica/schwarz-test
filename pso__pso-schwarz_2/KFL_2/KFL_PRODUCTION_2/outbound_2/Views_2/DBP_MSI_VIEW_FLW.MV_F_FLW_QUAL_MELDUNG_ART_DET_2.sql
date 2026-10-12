CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_qual_meldung_art_det_2 (mandant_id, qual_meldung_id,
in_art_id, kopf_fehlerpunkte) AS SELECT v01.mandant_id,
 v01.qual_meldung_id,
 v03.flw_art_id AS in_art_id,
 SUM(CAST(v01.anz_fehlerpunkte_pro_qm AS BIGNUMERIC) / v03.anz_best_pos) AS kopf_fehlerpunkte
FROM (SELECT QM.qual_meldung_id,
   QM.mandant_id,
   QM.best_beleg_id,
    CASE
    WHEN SUM(FK.fehlerklasse_kennzahl_ber) > 100
    THEN 100
    ELSE SUM(FK.fehlerklasse_kennzahl_ber)
    END AS anz_fehlerpunkte_pro_qm
  FROM kfl_production_dbp_view.v_flw_qual_meldung_2 AS QM
   INNER JOIN kfl_production_dbp_view.v_flw_qual_meldung_det_2 AS QMD ON QM.mandant_id = QMD.mandant_id AND QM.qual_meldung_id
      = QMD.qual_meldung_id
   INNER JOIN kfl_production_dbp_msi_view_flw.mv_l_flw_l_fehlerklasse_qual_2 AS FK ON QMD.fehlerklasse_id = FK.fehlerklasse_id
      AND QMD.mandant_id = FK.mandant_id
  GROUP BY QM.qual_meldung_id,
   QM.mandant_id,
   QM.best_beleg_id) AS v01
 INNER JOIN kfl_production_dbp_view.v_flw_besch_best_2 AS V02 ON v01.best_beleg_id = V02.best_beleg_id AND v01.mandant_id
   = V02.mandant_id
 LEFT JOIN (SELECT best_beleg_id,
   mandant_id,
   flw_art_id,
   SUM(1) OVER (PARTITION BY best_beleg_id, CAST(mandant_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS anz_best_pos
  FROM kfl_production_dbp_view.v_flw_besch_best_det_2) AS v03 ON V02.best_beleg_id = v03.best_beleg_id AND V02.mandant_id
   = v03.mandant_id
WHERE V02.einkaufsorganisation_id IN (5000, 5013, 5014)
GROUP BY v01.mandant_id,
 v01.qual_meldung_id,
 in_art_id;