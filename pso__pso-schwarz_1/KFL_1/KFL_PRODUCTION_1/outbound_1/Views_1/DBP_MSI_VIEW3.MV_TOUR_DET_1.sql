CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_tour_det_1 (mandant_id, system_id, nb_id, tour_pos_id, wup_id,
tour_id, mandant_id_kunde, reihenfolge_tour_dispo, lagernummer_id, kunde_id, lief_beleg_id, anzahl_stopps, kj_lief_beleg
) AS SELECT TD.mandant_id,
 TD.system_id,
 TD.nb_id,
 TD.tour_pos_id,
 TD.wup_id,
 TD.tour_id,
  CASE
  WHEN TD.mandant_id_kunde IS NULL OR TD.mandant_id_kunde = 0
  THEN TD.mandant_id
  ELSE TD.mandant_id_kunde
  END AS mandant_id_kunde,
 TD.reihenfolge_tour_dispo,
 TD.lagernummer_id,
 W.aktuell_wup_id AS kunde_id_,
 TD.lief_beleg_id,
  CASE
  WHEN COALESCE(W.aktuell_wup_id, 0) - (SUM(COALESCE(SAFE_CAST(CASE
         WHEN ROUND(SAFE_CAST(SUBSTR(TD.kunde_id, 7, 4) AS BIGNUMERIC), 0) IS NULL
         THEN CAST(- 3 AS BIGNUMERIC)
         ELSE W.aktuell_wup_id
         END AS BIGNUMERIC), 0)) OVER (PARTITION BY CAST(TD.mandant_id AS STRING), CAST(TD.wup_id AS STRING), TD.tour_id
        ORDER BY COALESCE(SAFE_CAST(CASE
           WHEN ROUND(ROUND(SAFE_CAST(SUBSTR(TD.kunde_id, 7, 4) AS BIGNUMERIC), 0), 0) IS NULL
           THEN CAST(- 3 AS BIGNUMERIC)
           ELSE W.aktuell_wup_id
           END AS BIGNUMERIC), 0) IS NULL, COALESCE(SAFE_CAST(CASE
           WHEN ROUND(ROUND(SAFE_CAST(SUBSTR(TD.kunde_id, 7, 4) AS BIGNUMERIC), 0), 0) IS NULL
           THEN CAST(- 3 AS BIGNUMERIC)
           ELSE W.aktuell_wup_id
           END AS BIGNUMERIC), 0) ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)) <> 0
  THEN 1
  ELSE 0
  END AS anzahl_stopps,
 TD.kj_lief_beleg
FROM kfl_production_dbp_view.v_tour_det_1 AS TD
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS W ON W.mandant_id = CASE
     WHEN TD.mandant_id_kunde IS NULL OR TD.mandant_id_kunde = 0
     THEN TD.mandant_id
     ELSE TD.mandant_id_kunde
     END AND W.wup_id = CASE
     WHEN ROUND(SAFE_CAST(TD.kunde_id AS BIGNUMERIC), 0) = 0
     THEN NULL
     ELSE ROUND(SAFE_CAST(TD.kunde_id AS BIGNUMERIC), 0)
     END AND (W.nb_id IN (2, 0, - 111) AND W.wup_id > 0 OR W.nb_id = - 1 AND W.wup_id = 0)
WHERE TD.loesch_fg = 0
 AND (TD.kj_lief_beleg = - 1 OR TD.kj_lief_beleg >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2);