-- filter auf kjwo_update ist wichtig, Service Layer kennt nur MATs ab 202001, wenn was von davor kommt kracht es

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_art_nielsen_wug_zu_pflege (mandant_id, art_nielsen_id,
art_nielsen_bez, wg_id, wug_id, nielsen_abteilung_bez, nielsen_wg_bez, nielsen_uwg1_bez, nielsen_uwg2_bez, wg_id_vorschl
, wug_id_vorschl, gtin_id, umsatz_nielsen, rang_umsatz_owg, a36_gewichtete_distribution, kjmo_date, wo_dat_von,
wo_dat_von_vj, kjmo_datenstand, datenstand, a425_kjmo_date, umsatz_6monate) AS
-- 15.02.2021 sgro2903: CROSS JOIN auf das aktuelle MAT der tupel_mat, damit die Anwender keine Potentialartikel zuordnen die nicht mehr relevant sind

-- 13.04.2020 sgro2903: CROSS JOIN erweitert um mandant_id statt auf Tabelle kjmo_sort gehen wir über die view damit die richtigen Wochen gezogen werden

SELECT V01.mandant_id,
 V01.art_nielsen_id,
 V01.art_nielsen_bez,
 V01.fb_pflege_wg_id AS wg_id,
 V01.fb_pflege_wug_id AS wug_id,
 V01.nielsen_abteilung_bez,
 V01.nielsen_wg_bez,
 V01.nielsen_uwg1_bez,
 V01.nielsen_uwg2_bez,
 V01.kalk_vorschl_wg_id AS wg_id_vorschl,
 V01.kalk_vorschl_wug_id AS wug_id_vorschl,
 V02.gtin_id,
 t1.a35_umsatz_nielsen AS umsatz_nielsen,
 t1.a58_rang_umsatz_owg AS rang_umsatz_owg,
 ROUND(CAST(t1.a36_gewichtete_distribution_nielsen AS NUMERIC), 1) AS a36_gewichtete_distribution,
  CASE
  WHEN nf.kjmo > 0
  THEN PARSE_DATE('%Y%m', CAST(nf.kjmo AS STRING))
  ELSE NULL
  END AS kjmo_date,
 nf_w.wo_dat_von,
 DATE_SUB(nf_w.wo_dat_von, INTERVAL 364 DAY) AS wo_dat_von_vj,
 t1.a425_kjmo AS kjmo_datenstand,
 CONCAT('Datenstand MAT ', FORMAT_DATE('%b', PARSE_DATE('%Y%m', CAST(t1.a425_kjmo AS STRING))), ' ', SUBSTR(SUBSTR(CAST(t1.a425_kjmo AS STRING)
    , 1, 39), 0, 4)) AS datenstand,
  CASE
  WHEN t1.a425_kjmo > 0
  THEN PARSE_DATE('%Y%m', CAST(t1.a425_kjmo AS STRING))
  ELSE NULL
  END AS a425_kjmo_date,
  CASE
  WHEN nf.umsatz_brutto > 0 AND CASE
      WHEN nf.kjmo > 0
      THEN PARSE_DATE('%Y%m', CAST(nf.kjmo AS STRING))
      ELSE NULL
      END > IF(CASE
        WHEN t1.a425_kjmo > 0
        THEN PARSE_DATE('%Y%m', CAST(t1.a425_kjmo AS STRING))
        ELSE NULL
        END = LAST_DAY(CASE
         WHEN t1.a425_kjmo > 0
         THEN PARSE_DATE('%Y%m', CAST(t1.a425_kjmo AS STRING))
         ELSE NULL
         END), LAST_DAY(DATE_ADD(CASE
         WHEN t1.a425_kjmo > 0
         THEN PARSE_DATE('%Y%m', CAST(t1.a425_kjmo AS STRING))
         ELSE NULL
         END, INTERVAL - 6 MONTH)), DATE_ADD(CASE
        WHEN t1.a425_kjmo > 0
        THEN PARSE_DATE('%Y%m', CAST(t1.a425_kjmo AS STRING))
        ELSE NULL
        END, INTERVAL - 6 MONTH)) OR nf_w.umsatz_brutto > 0 AND nf_w.wo_dat_von > IF(CASE
        WHEN t1.a425_kjmo > 0
        THEN PARSE_DATE('%Y%m', CAST(t1.a425_kjmo AS STRING))
        ELSE NULL
        END = LAST_DAY(CASE
         WHEN t1.a425_kjmo > 0
         THEN PARSE_DATE('%Y%m', CAST(t1.a425_kjmo AS STRING))
         ELSE NULL
         END), LAST_DAY(DATE_ADD(CASE
         WHEN t1.a425_kjmo > 0
         THEN PARSE_DATE('%Y%m', CAST(t1.a425_kjmo AS STRING))
         ELSE NULL
         END, INTERVAL - 6 MONTH)), DATE_ADD(CASE
        WHEN t1.a425_kjmo > 0
        THEN PARSE_DATE('%Y%m', CAST(t1.a425_kjmo AS STRING))
        ELSE NULL
        END, INTERVAL - 6 MONTH))
  THEN 'X'
  ELSE NULL
  END AS umsatz_6monate
FROM kfl_production_dbp_view.v_art_nielsen_wug_zu_pflege AS V01
 INNER JOIN kfl_production_dbp_view.v_art_nielsen AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_nielsen_id = V02
   .art_nielsen_id
 INNER JOIN (SELECT *
  FROM kfl_production_dbp_msi_v_view.v_tupel_mat AS V03
  WHERE (mandant_id, a500_kjwo_update) IN (SELECT (mandant_id, MAX(kjwo_update))
     FROM kfl_production_dbp_msi_view_ek_sort.java_mat_kjwo_update
     GROUP BY mandant_id)) AS t1 ON V01.mandant_id = t1.mandant_id AND V01.art_nielsen_id = t1.a450_art_nielsen_nr
 LEFT JOIN (SELECT NEU1.mandant_id,
   NEU1.art_nielsen_id,
   MAX(NEU1.kjmo) AS kjmo,
   SUM(NEU1.umsatz_brutto) AS umsatz_brutto
  FROM kfl_production_dbp_view.v_art_nielsen_fakten_kjmo AS NEU1
   INNER JOIN kfl_production_dbp_view.v_nielsen_market AS NM ON NEU1.mandant_id = NM.mandant_id AND NEU1.nielsen_market_id
      = NM.nielsen_market_id
  WHERE (NM.mandant_id = 1 AND NM.nielsen_market_cluster_id = 2 OR NM.mandant_id > 1 AND NM.nielsen_market_cluster_id =
       1)
   AND PARSE_DATE('%Y%m', CAST(NEU1.kjmo AS STRING)) > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE
       ,INTERVAL - 6 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL - 6 MONTH))
  GROUP BY NEU1.mandant_id,
   NEU1.art_nielsen_id) AS nf ON V01.mandant_id = nf.mandant_id AND V01.art_nielsen_id = nf.art_nielsen_id
 LEFT JOIN (SELECT NEU2.mandant_id,
   NEU2.art_nielsen_id,
   MAX(W1.wo_dat_von) AS wo_dat_von,
   MAX(NEU2.kjwo) AS kjwo,
   SUM(NEU2.umsatz_brutto) AS umsatz_brutto
  FROM kfl_production_dbp_view.v_art_nielsen_fakten_kjwo AS NEU2
   INNER JOIN kfl_production_dbp_view.v_nielsen_market AS NM0 ON NEU2.mandant_id = NM0.mandant_id AND NEU2.nielsen_market_id
      = NM0.nielsen_market_id
   INNER JOIN kfl_production_dbp_view.v_woche AS W1 ON NEU2.kjwo = W1.kjwo
  WHERE (NM0.mandant_id = 1 AND NM0.nielsen_market_cluster_id = 2 OR NM0.mandant_id > 1 AND NM0.nielsen_market_cluster_id
        = 1)
   AND W1.wo_dat_von > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 6 MONTH)),
     DATE_ADD(CURRENT_DATE, INTERVAL - 6 MONTH))
  GROUP BY NEU2.mandant_id,
   NEU2.art_nielsen_id) AS nf_w ON V01.mandant_id = nf_w.mandant_id AND V01.art_nielsen_id = nf_w.art_nielsen_id;