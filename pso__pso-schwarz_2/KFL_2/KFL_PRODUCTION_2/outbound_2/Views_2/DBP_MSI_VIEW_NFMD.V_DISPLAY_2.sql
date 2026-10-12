CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.v_display_2 AS SELECT T1.mandant_id,
 T1.stueckliste_id,
 T1.art_id AS art_id_display,
 T2.art_id AS art_id_komponente,
 T2.komponentenmenge,
 T2.komponentenmenge_einh_id,
 COALESCE(SUM(CASE
    WHEN T3.nb_id = - 111
    THEN T3.menge_lgbest_erp_frei_bme
    ELSE 0
    END), 0) AS bestand_vz,
 COALESCE(SUM(CASE
    WHEN T3.nb_id = 0
    THEN T3.menge_lgbest_erp_frei_bme
    ELSE 0
    END), 0) AS bestand_markt,
  CASE
  WHEN COALESCE(SUM(CASE
      WHEN T3.nb_id = - 111
      THEN T3.menge_lgbest_erp_frei_bme
      ELSE 0
      END), 0) = 0
  THEN NULL
  ELSE CAST(ROUND(SUM(CASE
       WHEN T3.nb_id = - 111
       THEN T3.menge_lgbest_erp_frei_bme
       ELSE 0
       END / T2.komponentenmenge), 0) AS INTEGER)
  END AS display_vz,
  CASE
  WHEN COALESCE(SUM(CASE
      WHEN T3.nb_id = 0
      THEN T3.menge_lgbest_erp_frei_bme
      ELSE 0
      END), 0) = 0
  THEN NULL
  ELSE CAST(ROUND(SUM(CASE
       WHEN T3.nb_id = 0
       THEN T3.menge_lgbest_erp_frei_bme
       ELSE 0
       END / T2.komponentenmenge), 0) AS INTEGER)
  END AS display_markt
FROM kfl_production_dbp_data.stueckliste_2 AS T1_2
 INNER JOIN kfl_production_dbp_data.stueckliste_det_2 AS T2 ON T1.mandant_id = T2.mandant_id AND T1.stueckliste_id = T2.stueckliste_id
   
 LEFT JOIN kfl_production_dbp_data.marktbestand_erp_2 AS T3 ON T2.art_id = T3.art_id AND T3.nb_id IN (- 111, 0)
WHERE T2.dat_bis > CURRENT_DATE
 AND T3.dat = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
GROUP BY T1.mandant_id,
 T1.stueckliste_id,
 art_id_display,
 art_id_komponente,
 T2.komponentenmenge,
 T2.komponentenmenge_einh_id;