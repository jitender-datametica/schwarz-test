CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FEHLMENGEN_2
AS
   -- FAKT-AGGREGAT Fehlmengen nationale Quoten (Top 5 Prozent) pro Monat_2 - Land_2/Abteilung
   -- Abloesung mv_fehlmengen_top1
   -- 2011KW47 Initial
   -- 2011KW5x Anpassung/Finetuning
   -- 20120325 Harmonierung Abt_2/WG
   -- 2012KW42 Anpassung Topquote / Gruppierung nach Abteilung
   -- 2014-06-03 Anpassung/Patch Quoten (NULLIFZERO)

   -- 1. nationale Quoten pro Abteilung
   SELECT
   dt02.mandant_id, dt02.nb_id, dt02.bezugsweg_id, dt02.arthiertyp_id, dt02.abt_id, dt02.kjmo, AVG(dt02.fehlmengen_quote)   AS fehlmengen_top5, AVG(dt02.nullbestand_quote)  AS nullbestand_top5, AVG(dt02.minusbestand_quote) AS minusbestand_top5, COUNT(DISTINCT wup_id)       AS wup_top5
   FROM
   (
   SELECT
   dt01.mandant_id, dt01.nb_id, dt01.wup_id, dt01.bezugsweg_id, dt01.arthiertyp_id, dt01.abt_id, dt01.kjmo, AVG(bestand)::DECIMAL(18,4)      AS bestand_avg, AVG(fehlmengen)::DECIMAL(18,4)   AS fehlmengen_avg, AVG(nullbestand)::DECIMAL(18,4)  AS nullbestand_avg, AVG(minusbestand)::DECIMAL(18,4) AS minusbestand_avg, AVG(quote_fehl)::DECIMAL(18,4)   AS fehlmengen_quote, AVG(quote_null)::DECIMAL(18,4)   AS nullbestand_quote, AVG(quote_minus)::DECIMAL(18,4)  AS minusbestand_quote, PERCENT_RANK() OVER (
   PARTITION BY dt01.mandant_id, dt01.nb_id, dt01.arthiertyp_id, dt01.abt_id, dt01.bezugsweg_id, dt01.kjmo
   ORDER BY fehlmengen_quote
   ) * 100    AS fehlmengen_rang
   FROM
   (
   SELECT
   t01.mandant_id, t01.nb_id, t01.wup_id, CASE WHEN t01.abt_id = 1 AND t01.bezugsweg_id = 1 THEN t01.bezugsweg_id + 3 ELSE t01.bezugsweg_id END AS bezugsweg_id, t01.arthiertyp_id, t01.abt_id, t01.dat, t01.kjmo, CASE WHEN SUM(t01.anz_artikel_bestand * 1.0000) = 0 THEN null ELSE SUM(t01.anz_artikel_bestand * 1.0000) END      AS bestand, SUM(t01.anz_artikel_fehlmengen * 1.0000)   AS fehlmengen, SUM(t01.anz_artikel_nullbestand * 1.0000)  AS nullbestand, SUM(t01.anz_artikel_minusbestand * 1.0000) AS minusbestand, (fehlmengen * 100.0000) / bestand         AS quote_fehl,  (nullbestand * 100.0000) / bestand        AS quote_null, (minusbestand * 100.0000) / bestand        AS quote_minus
   FROM dbp_msi_v_view.v_vis_tag_bestand_wg_2  t01
   INNER JOIN dbp_view.v_wup_2 AS t03
   ON t01.mandant_id = t03.mandant_id
   AND t01.wup_id = t03.wup_id
   AND t03.verkaufsflaeche >= 1000  -- Filialen mit VK_2-Flaeche >= 1000!
   AND t03.dat_bis > t01.dat - EXTRACT(DAY FROM t01.dat)  -- inkl. Schliessungen im Berichtsmonat

   WHERE t01.relevant_fg = 1 -- nur relevante Artikel_2 (WG)
   AND t01.abt_id in (1, 2, 3, 5, 6, 7)   -- ohne Abteilung 4 Obst und Gemuese / Pflanzen NEUE ID!
   -- zeitliche Abgrenzung in vis_tag_bestand

   GROUP BY
   t01.mandant_id
   , t01.nb_id
   , t01.wup_id
   , CASE WHEN t01.abt_id = 1 AND t01.bezugsweg_id = 1 THEN t01.bezugsweg_id + 3 ELSE t01.bezugsweg_id END
   , t01.arthiertyp_id
   , t01.abt_id
   , t01.dat
   , t01.kjmo
   ) AS dt01

   GROUP BY
   dt01.mandant_id
   , dt01.nb_id
   , dt01.wup_id
   , dt01.bezugsweg_id
   , dt01.arthiertyp_id
   , dt01.abt_id
   , dt01.kjmo

   HAVING bestand_avg >= 100  -- Durchschnittlicher Bestand pro Monat_2/Abt_2

   ) dt02

   WHERE fehlmengen_rang <= 5

   GROUP BY
   dt02.mandant_id
   , dt02.nb_id
   , dt02.bezugsweg_id
   , dt02.arthiertyp_id
   , dt02.abt_id
   , dt02.kjmo

   UNION ALL
   -- 2. nationale Quoten Gesamt (gemappt auf Abteilung 0)
   SELECT
   dt02.mandant_id, dt02.nb_id, dt02.bezugsweg_id, dt02.arthiertyp_id, dt02.abt_id, dt02.kjmo, AVG(dt02.fehlmengen_quote)   AS fehlmengen_top5, AVG(dt02.nullbestand_quote)  AS nullbestand_top5, AVG(dt02.minusbestand_quote) AS minusbestand_top5, COUNT(DISTINCT wup_id)       AS wup_top5
   FROM
   (
   SELECT
   dt01.mandant_id, dt01.nb_id, dt01.wup_id, dt01.bezugsweg_id, dt01.arthiertyp_id, dt01.abt_id, dt01.kjmo, AVG(bestand)::DECIMAL(18,4)      AS bestand_avg, AVG(fehlmengen)::DECIMAL(18,4)   AS fehlmengen_avg, AVG(nullbestand)::DECIMAL(18,4)  AS nullbestand_avg, AVG(minusbestand)::DECIMAL(18,4) AS minusbestand_avg, AVG(quote_fehl)::DECIMAL(18,4)   AS fehlmengen_quote, AVG(quote_null)::DECIMAL(18,4)   AS nullbestand_quote, AVG(quote_minus)::DECIMAL(18,4)  AS minusbestand_quote, PERCENT_RANK() OVER (
   PARTITION BY dt01.mandant_id, dt01.nb_id, dt01.arthiertyp_id, dt01.abt_id, dt01.bezugsweg_id, dt01.kjmo
   ORDER BY fehlmengen_quote
   ) * 100    AS fehlmengen_rang
   FROM
   (
   SELECT
   t01.mandant_id, t01.nb_id, t01.wup_id, CASE WHEN t01.abt_id = 1 AND t01.bezugsweg_id = 1 THEN t01.bezugsweg_id + 3 ELSE t01.bezugsweg_id END AS bezugsweg_id, t01.arthiertyp_id, 0 AS abt_id                                           -- WICHTIG: Mapping der nationalen/Topquote auf Abteilung 0
   , t01.dat, t01.kjmo, CASE WHEN SUM(t01.anz_artikel_bestand * 1.0000) = 0 THEN null ELSE SUM(t01.anz_artikel_bestand * 1.0000) END      AS bestand, SUM(t01.anz_artikel_fehlmengen * 1.0000)   AS fehlmengen, SUM(t01.anz_artikel_nullbestand * 1.0000)  AS nullbestand, SUM(t01.anz_artikel_minusbestand * 1.0000) AS minusbestand, ( fehlmengen * 100.0000) / bestand * 1.0000          AS quote_fehl,  (nullbestand * 100.0000) / bestand * 1.0000         AS quote_null,  (minusbestand * 100.0000) / bestand * 1.0000        AS quote_minus
   FROM dbp_msi_v_view.v_vis_tag_bestand_wg_2  t01
   INNER JOIN dbp_view.v_wup_2 AS t03
   ON t01.mandant_id = t03.mandant_id
   AND t01.wup_id = t03.wup_id
   AND t03.verkaufsflaeche >= 1000  -- Filialen mit VK_2-Flaeche >= 1000!
   AND t03.dat_bis > t01.dat - EXTRACT(DAY FROM t01.dat)  -- inkl. Schliessungen im Berichtsmonat

   WHERE t01.relevant_fg = 1 -- nur relevante Artikel_2 (WG)
   AND t01.abt_id in (1, 2, 3, 5, 6, 7)   -- ohne Abteilung 4 Obst und Gemuese / Pflanzen NEUE ID!
   -- zeitliche Abgrenzung in vis_tag_bestand

   GROUP BY
   t01.mandant_id
   , t01.nb_id
   , t01.wup_id
   , CASE WHEN t01.abt_id = 1 AND t01.bezugsweg_id = 1
   THEN t01.bezugsweg_id + 3
   ELSE t01.bezugsweg_id
   END
   , t01.arthiertyp_id
   -- , t01.abt_id Keine Gruppierung > Topquote ueber alle Abteilungen
   , t01.dat
   , t01.kjmo
   ) AS dt01

   GROUP BY
   dt01.mandant_id
   , dt01.nb_id
   , dt01.wup_id
   , dt01.bezugsweg_id
   , dt01.arthiertyp_id
   , dt01.abt_id
   , dt01.kjmo

   HAVING bestand_avg >= 100  -- Durchschnittlicher Bestand pro Monat_2/Abt_2

   ) dt02

   WHERE fehlmengen_rang <= 5

   GROUP BY
   dt02.mandant_id
   , dt02.nb_id
   , dt02.bezugsweg_id
   , dt02.arthiertyp_id
   , dt02.kjmo
   , DT02.ABT_ID
   ;