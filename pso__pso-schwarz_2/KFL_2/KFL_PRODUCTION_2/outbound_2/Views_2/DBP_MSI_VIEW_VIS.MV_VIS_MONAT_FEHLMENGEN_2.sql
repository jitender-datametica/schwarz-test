CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_fehlmengen_2 AS SELECT mandant_id,
 nb_id,
 bezugsweg_id,
 arthiertyp_id,
 abt_id,
 kjmo,
 AVG(fehlmengen_quote) AS fehlmengen_top5,
 AVG(nullbestand_quote) AS nullbestand_top5,
 AVG(minusbestand_quote) AS minusbestand_top5,
 COUNT(DISTINCT wup_id) AS wup_top5
FROM (SELECT mandant_id,
   nb_id,
   wup_id,
   bezugsweg_id,
   arthiertyp_id,
   abt_id,
   kjmo,
   ROUND(CAST(AVG(bestand) AS NUMERIC), 4) AS bestand_avg,
   ROUND(CAST(AVG(fehlmengen) AS NUMERIC), 4) AS fehlmengen_avg,
   ROUND(CAST(AVG(nullbestand) AS NUMERIC), 4) AS nullbestand_avg,
   ROUND(CAST(AVG(minusbestand) AS NUMERIC), 4) AS minusbestand_avg,
   ROUND(CAST(AVG(quote_fehl) AS NUMERIC), 4) AS fehlmengen_quote,
   ROUND(CAST(AVG(quote_null) AS NUMERIC), 4) AS nullbestand_quote,
   ROUND(CAST(AVG(quote_minus) AS NUMERIC), 4) AS minusbestand_quote,
     (PERCENT_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(nb_id AS STRING), CAST(arthiertyp_id AS STRING)
        , CAST(abt_id AS STRING), CAST(bezugsweg_id AS STRING), CAST(kjmo AS STRING) ORDER BY ROUND(ROUND(CAST(AVG(quote_fehl) AS NUMERIC)
          , 4), 4) IS NULL, ROUND(ROUND(CAST(AVG(quote_fehl) AS NUMERIC), 4), 4))) * 100 AS fehlmengen_rang
  FROM (SELECT T01.mandant_id,
     T01.nb_id,
     T01.wup_id,
      CASE
      WHEN T01.abt_id = 1 AND T01.bezugsweg_id = 1
      THEN T01.bezugsweg_id + 3
      ELSE T01.bezugsweg_id
      END AS bezugsweg_id,
     T01.arthiertyp_id,
     T01.abt_id,
     T01.kjmo,
      CASE
      WHEN SUM(CAST(T01.anz_artikel_bestand AS BIGNUMERIC)) = 0
      THEN NULL
      ELSE SUM(CAST(T01.anz_artikel_bestand AS BIGNUMERIC))
      END AS bestand,
     SUM(CAST(T01.anz_artikel_fehlmengen AS BIGNUMERIC)) AS fehlmengen,
     SUM(CAST(T01.anz_artikel_nullbestand AS BIGNUMERIC)) AS nullbestand,
     SUM(CAST(T01.anz_artikel_minusbestand AS BIGNUMERIC)) AS minusbestand,
       SUM(CAST(T01.anz_artikel_fehlmengen AS BIGNUMERIC)) * 100.0000 / CASE
       WHEN SUM(CAST(T01.anz_artikel_bestand AS BIGNUMERIC)) = 0
       THEN NULL
       ELSE SUM(CAST(T01.anz_artikel_bestand AS BIGNUMERIC))
       END AS quote_fehl,
       SUM(CAST(T01.anz_artikel_nullbestand AS BIGNUMERIC)) * 100.0000 / CASE
       WHEN SUM(CAST(T01.anz_artikel_bestand AS BIGNUMERIC)) = 0
       THEN NULL
       ELSE SUM(CAST(T01.anz_artikel_bestand AS BIGNUMERIC))
       END AS quote_null,
       SUM(CAST(T01.anz_artikel_minusbestand AS BIGNUMERIC)) * 100.0000 / CASE
       WHEN SUM(CAST(T01.anz_artikel_bestand AS BIGNUMERIC)) = 0
       THEN NULL
       ELSE SUM(CAST(T01.anz_artikel_bestand AS BIGNUMERIC))
       END AS quote_minus
    FROM kfl_production_dbp_msi_v_view.v_vis_tag_bestand_wg_2 AS T01
     INNER JOIN kfl_production_dbp_view.v_wup_2 AS T03 ON T01.mandant_id = T03.mandant_id AND T01.wup_id = T03.wup_id AND
        T03.verkaufsflaeche >= 1000 AND T03.dat_bis > DATE_SUB(T01.dat, INTERVAL EXTRACT(DAY FROM T01.dat) DAY)
    WHERE T01.relevant_fg = 1
     AND T01.abt_id IN (1, 2, 3, 5, 6, 7)
    GROUP BY T01.mandant_id,
     T01.nb_id,
     T01.wup_id,
     bezugsweg_id,
     T01.arthiertyp_id,
     T01.abt_id,
     T01.dat,
     T01.kjmo) AS dt01
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   bezugsweg_id,
   arthiertyp_id,
   abt_id,
   kjmo
  HAVING ROUND(CAST(AVG(bestand) AS NUMERIC), 4) >= 100
  QUALIFY (PERCENT_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(nb_id AS STRING), CAST(arthiertyp_id AS STRING)
         , CAST(abt_id AS STRING), CAST(bezugsweg_id AS STRING), CAST(kjmo AS STRING) ORDER BY ROUND(ROUND(CAST(AVG(quote_fehl) AS NUMERIC)
           , 4), 4) IS NULL, ROUND(ROUND(CAST(AVG(quote_fehl) AS NUMERIC), 4), 4))) * 100 <= 5) AS t6
GROUP BY mandant_id,
 nb_id,
 bezugsweg_id,
 arthiertyp_id,
 abt_id,
 kjmo
UNION ALL
SELECT mandant_id,
 nb_id,
 bezugsweg_id,
 arthiertyp_id,
 abt_id,
 kjmo,
 AVG(fehlmengen_quote) AS fehlmengen_top5,
 AVG(nullbestand_quote) AS nullbestand_top5,
 AVG(minusbestand_quote) AS minusbestand_top5,
 COUNT(DISTINCT wup_id) AS wup_top5
FROM (SELECT mandant_id,
   nb_id,
   wup_id,
   bezugsweg_id,
   arthiertyp_id,
   abt_id,
   kjmo,
   ROUND(CAST(AVG(bestand) AS NUMERIC), 4) AS bestand_avg,
   ROUND(CAST(AVG(fehlmengen) AS NUMERIC), 4) AS fehlmengen_avg,
   ROUND(CAST(AVG(nullbestand) AS NUMERIC), 4) AS nullbestand_avg,
   ROUND(CAST(AVG(minusbestand) AS NUMERIC), 4) AS minusbestand_avg,
   ROUND(CAST(AVG(quote_fehl) AS NUMERIC), 4) AS fehlmengen_quote,
   ROUND(CAST(AVG(quote_null) AS NUMERIC), 4) AS nullbestand_quote,
   ROUND(CAST(AVG(quote_minus) AS NUMERIC), 4) AS minusbestand_quote,
     (PERCENT_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(nb_id AS STRING), CAST(arthiertyp_id AS STRING)
        , abt_id, CAST(bezugsweg_id AS STRING), CAST(kjmo AS STRING) ORDER BY ROUND(ROUND(CAST(AVG(quote_fehl) AS NUMERIC)
          , 4), 4) IS NULL, ROUND(ROUND(CAST(AVG(quote_fehl) AS NUMERIC), 4), 4))) * 100 AS fehlmengen_rang
  FROM (SELECT T01.mandant_id,
     T01.nb_id,
     T01.wup_id,
      CASE
      WHEN T01.abt_id = 1 AND T01.bezugsweg_id = 1
      THEN T01.bezugsweg_id + 3
      ELSE T01.bezugsweg_id
      END AS bezugsweg_id,
     T01.arthiertyp_id,
     0 AS abt_id,
     T01.kjmo,
      CASE
      WHEN SUM(CAST(T01.anz_artikel_bestand AS BIGNUMERIC)) = 0
      THEN NULL
      ELSE SUM(CAST(T01.anz_artikel_bestand AS BIGNUMERIC))
      END AS bestand,
     SUM(CAST(T01.anz_artikel_fehlmengen AS BIGNUMERIC)) AS fehlmengen,
     SUM(CAST(T01.anz_artikel_nullbestand AS BIGNUMERIC)) AS nullbestand,
     SUM(CAST(T01.anz_artikel_minusbestand AS BIGNUMERIC)) AS minusbestand,
     CAST(SUM(CAST(T01.anz_artikel_fehlmengen AS BIGNUMERIC)) * 100.0000 / CASE
        WHEN SUM(CAST(T01.anz_artikel_bestand AS BIGNUMERIC)) = 0
        THEN NULL
        ELSE SUM(CAST(T01.anz_artikel_bestand AS BIGNUMERIC))
        END AS NUMERIC) AS quote_fehl,
     CAST(SUM(CAST(T01.anz_artikel_nullbestand AS BIGNUMERIC)) * 100.0000 / CASE
        WHEN SUM(CAST(T01.anz_artikel_bestand AS BIGNUMERIC)) = 0
        THEN NULL
        ELSE SUM(CAST(T01.anz_artikel_bestand AS BIGNUMERIC))
        END AS NUMERIC) AS quote_null,
     CAST(SUM(CAST(T01.anz_artikel_minusbestand AS BIGNUMERIC)) * 100.0000 / CASE
        WHEN SUM(CAST(T01.anz_artikel_bestand AS BIGNUMERIC)) = 0
        THEN NULL
        ELSE SUM(CAST(T01.anz_artikel_bestand AS BIGNUMERIC))
        END AS NUMERIC) AS quote_minus
    FROM kfl_production_dbp_msi_v_view.v_vis_tag_bestand_wg_2 AS T01
     INNER JOIN kfl_production_dbp_view.v_wup_2 AS T03 ON T01.mandant_id = T03.mandant_id AND T01.wup_id = T03.wup_id AND
        T03.verkaufsflaeche >= 1000 AND T03.dat_bis > DATE_SUB(T01.dat, INTERVAL EXTRACT(DAY FROM T01.dat) DAY)
    WHERE T01.relevant_fg = 1
     AND T01.abt_id IN (1, 2, 3, 5, 6, 7)
    GROUP BY T01.mandant_id,
     T01.nb_id,
     T01.wup_id,
     bezugsweg_id,
     T01.arthiertyp_id,
     T01.dat,
     T01.kjmo) AS dt01
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   bezugsweg_id,
   arthiertyp_id,
   abt_id,
   kjmo
  HAVING ROUND(CAST(AVG(bestand) AS NUMERIC), 4) >= 100
  QUALIFY (PERCENT_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(nb_id AS STRING), CAST(arthiertyp_id AS STRING)
         , abt_id, CAST(bezugsweg_id AS STRING), CAST(kjmo AS STRING) ORDER BY ROUND(ROUND(CAST(AVG(quote_fehl) AS NUMERIC)
           , 4), 4) IS NULL, ROUND(ROUND(CAST(AVG(quote_fehl) AS NUMERIC), 4), 4))) * 100 <= 5) AS t16
GROUP BY mandant_id,
 nb_id,
 bezugsweg_id,
 arthiertyp_id,
 abt_id,
 kjmo;