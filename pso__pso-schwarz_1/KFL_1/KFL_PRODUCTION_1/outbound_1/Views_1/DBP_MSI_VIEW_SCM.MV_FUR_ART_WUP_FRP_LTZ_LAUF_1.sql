CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_fur_art_wup_frp_ltz_lauf_1 (mandant_id, wup_id, nb_id, art_id,
fur_standardabweichung, fur_klassifikationsmittelwert, drehklasse_kz, verbrauchskonstanz_kz) AS SELECT V01.mandant_id,
 V05.aktuell_wup_id AS wup_id,
 V01.nb_id,
 V01.art_id,
 V01.standardabweichung AS fur_standardabweichung,
 V01.klassifikationsmittelwert AS fur_klassifikationsmittelwert,
 v02.drehklasse_id AS drehklasse_kz,
  CASE
  WHEN V01.standardabweichung = 0
  THEN 'nicht ermittelbar'
  WHEN V01.standardabweichung / IF(V01.klassifikationsmittelwert = 0, NULL, V01.klassifikationsmittelwert) < 0.25
  THEN 'X'
  WHEN V01.standardabweichung / IF(V01.klassifikationsmittelwert = 0, NULL, V01.klassifikationsmittelwert) >= 0.5
  THEN 'Z'
  ELSE 'Y'
  END AS verbrauchskonstanz_kz
FROM kfl_production_dbp_view.v_fur_art_wup_frp_ltz_lauf_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON V01.mandant_id = V05.mandant_id AND V01.wup_id = V05.wup_id AND (V05
      .nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id = 0)
 LEFT JOIN (SELECT AB.mandant_id,
   AB.wup_id,
   AB.art_id,
    1 - (PERCENT_RANK() OVER (PARTITION BY CAST(AB.mandant_id AS STRING), CAST(AB.wup_id AS STRING) ORDER BY (SUM(CASE
             WHEN wo.akt_wo IN (- 1, - 2)
             THEN AB.menge
             ELSE 0
             END) * 0.2 + SUM(CASE
             WHEN wo.akt_wo < - 2
             THEN AB.menge
             ELSE 0
             END) * 0.8) IS NULL DESC, SUM(CASE
            WHEN wo.akt_wo IN (- 1, - 2)
            THEN AB.menge
            ELSE 0
            END) * 0.2 + SUM(CASE
            WHEN wo.akt_wo < - 2
            THEN AB.menge
            ELSE 0
            END) * 0.8 DESC)) AS perc_rank,
    CASE
    WHEN (1 - (PERCENT_RANK() OVER (PARTITION BY CAST(AB.mandant_id AS STRING), CAST(AB.wup_id AS STRING) ORDER BY (SUM(CASE
                WHEN wo.akt_wo IN (- 1, - 2)
                THEN AB.menge
                ELSE 0
                END) * 0.2 + SUM(CASE
                WHEN wo.akt_wo < - 2
                THEN AB.menge
                ELSE 0
                END) * 0.8) IS NULL DESC, SUM(CASE
               WHEN wo.akt_wo IN (- 1, - 2)
               THEN AB.menge
               ELSE 0
               END) * 0.2 + SUM(CASE
               WHEN wo.akt_wo < - 2
               THEN AB.menge
               ELSE 0
               END) * 0.8 DESC))) BETWEEN 0.200000 AND 1.000000
    THEN 'A'
    WHEN (1 - (PERCENT_RANK() OVER (PARTITION BY CAST(AB.mandant_id AS STRING), CAST(AB.wup_id AS STRING) ORDER BY (SUM(CASE
                WHEN wo.akt_wo IN (- 1, - 2)
                THEN AB.menge
                ELSE 0
                END) * 0.2 + SUM(CASE
                WHEN wo.akt_wo < - 2
                THEN AB.menge
                ELSE 0
                END) * 0.8) IS NULL DESC, SUM(CASE
               WHEN wo.akt_wo IN (- 1, - 2)
               THEN AB.menge
               ELSE 0
               END) * 0.2 + SUM(CASE
               WHEN wo.akt_wo < - 2
               THEN AB.menge
               ELSE 0
               END) * 0.8 DESC))) BETWEEN 0.150000 AND 0.199999
    THEN 'B'
    ELSE 'C'
    END AS drehklasse_id
  FROM kfl_production_dbp_view.v_artbew_wo_sum_1 AS AB
   INNER JOIN (SELECT DISTINCT kjwo,
     akt_wo
    FROM kfl_production_dbp_view.v_tag_1) AS wo ON AB.kjwo_kl = wo.kjwo
   INNER JOIN kfl_production_dbp_view.v_art_wup_status_per_1 AS ASP ON AB.art_id = ASP.art_id AND AB.mandant_id = ASP.mandant_id
        AND AB.wup_id = ASP.wup_id AND ASP.dat_bis = DATE '9999-12-31'
  WHERE wo.akt_wo BETWEEN - 60 AND (- 1)
   AND ASP.dispomerkmal IN ('10', '11', '12', '14', 'S1', 'S2')
   AND AB.bewart_id = 1001
   AND AB.menge > 0
  GROUP BY AB.mandant_id,
   AB.wup_id,
   AB.art_id) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.wup_id = v02.wup_id AND V01.art_id = v02.art_id;