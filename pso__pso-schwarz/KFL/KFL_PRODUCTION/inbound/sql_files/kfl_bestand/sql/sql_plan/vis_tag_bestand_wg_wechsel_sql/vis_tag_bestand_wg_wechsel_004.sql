INSERT INTO DBP_ETL.vis_tag_best_wg_wechsel_join
(
   art_id
   ,mandant_id
   ,arthiertyp_id
   ,dat
   ,alt_neu_kz
   ,wg_id
   ,gj
   ,kjmo
   ,kjwo
)
SELECT
    w1.art_id art_id
   ,w1.mandant_id mandant_id
   ,w1.arthiertyp_id arthiertyp_id
   ,tmp.dat dat
   ,w1.alt_neu_kz
   ,w1.wg_id
   ,tmp.gj
   ,tmp.kjmo
   ,tmp.kjwo

FROM DBP_ETL.vis_tag_best_wg_wechsel_tmp w1
   JOIN
     DBP_ETL.vis_tag_best_wg_wechsel_tmp w2
   ON w1.mandant_id    = w2.mandant_id
  AND w1.art_id        = w2.art_id
  AND w1.arthiertyp_id = w2.arthiertyp_id
  AND ((w1.alt_neu_kz = 1 AND w2.alt_neu_kz = -1)
      OR
       (w1.alt_neu_kz = -1 AND w2.alt_neu_kz = 1))

 CROSS JOIN
  (SELECT dat
         ,gj
         ,kjmo
         ,kjwo
   FROM DBP_DATA.tag
   WHERE (akt_mo BETWEEN $VIS_BESTAND_AKT_MO_VON AND 0
      OR dat IN
        (SELECT MAX(dat)
         FROM DBP_DATA.tag
         WHERE akt_mo = $VIS_BESTAND_AKT_MO_VON -1
        )
     )
     AND dat <= (SELECT MAX(dat)
                 FROM DBP_MSI_DATA.vis_tag_bestand_wg)
  ) tmp

WHERE (w1.wg_id <> w2.wg_id)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_tag_best_wg_wechsel_sum_t1
(
    mandant_id
   ,wup_id
   ,wg_id
   ,dat
-- Abteilung wird nur beim spaeteren INSERT INTO benoetigt und dort direkt herangejoint.
--   ,abt_id
   ,gj
   ,kjmo
   ,kjwo
   ,arthiertyp_id
   ,nb_id
   ,relevant_fg
   ,bezugsweg_id
   ,wrg_id
   ,anz_artikel_bestand
   ,anz_artikel_fehlmengen
   ,anz_artikel_nullbestand
   ,anz_artikel_minusbestand
   ,menge_lgbest_erp_frei_bme
   ,menge_lgbest_erp_qual_bme
   ,betrag_vk_netto_frei_bme
   ,betrag_vk_netto_qual_bme
   ,betrag_vk_brutto_frei_bme
   ,betrag_vk_brutto_qual_bme
)
SELECT
  t2.mandant_id
 ,t2.wup_id
 ,t1.wg_id
 ,t1.dat
-- ,t4.abt_id
 ,t1.gj
 ,t1.kjmo
 ,t1.kjwo
 ,t1.arthiertyp_id
 ,t2.nb_id
 ,t2.relevant_fg
 ,t2.bezugsweg_id
 ,t3.wrg_id
 ,SUM(t1.alt_neu_kz)                                                                                             AS anz_artikel_bestand
 ,SUM(CASE WHEN t2.menge_lgbest_erp_frei_bme <= 0 THEN t1.alt_neu_kz ELSE 0 END )                                AS anz_artikel_fehlmenge
 ,SUM(CASE WHEN t2.menge_lgbest_erp_frei_bme = 0 THEN t1.alt_neu_kz ELSE 0 END )                                 AS anz_artikel_nullbestand
 ,SUM(CASE WHEN t2.menge_lgbest_erp_frei_bme < 0 THEN t1.alt_neu_kz ELSE 0 END )                                 AS anz_artikel_minusbestand
 ,SUM(t2.menge_lgbest_erp_frei_bme * t1.alt_neu_kz)                                                              AS menge_lgbest_erp_frei_bme
 ,SUM(t2.menge_lgbest_erp_qual_bme * t1.alt_neu_kz)                                                              AS menge_lgbest_erp_qual_bme
 ,SUM( CAST (t3.vk_netto * t2.menge_lgbest_erp_frei_bme * t1.alt_neu_kz AS DECIMAL(18,4)))                       AS betrag_vk_netto_frei_bme
 ,SUM( CAST (t3.vk_netto * t2.menge_lgbest_erp_qual_bme * t1.alt_neu_kz AS DECIMAL(18,4)))                       AS betrag_vk_netto_qual_bme
 ,SUM( CAST ( (COALESCE(t4.vk_brutto, 0.)) * t3.vk_netto * t2.menge_lgbest_erp_frei_bme * t1.alt_neu_kz AS DECIMAL(18,4)))  AS betrag_vk_brutto_frei_bme
 ,SUM( CAST ( (COALESCE(t4.vk_brutto, 0.)) * t3.vk_netto * t2.menge_lgbest_erp_qual_bme * t1.alt_neu_kz AS DECIMAL(18,4)))  AS betrag_vk_brutto_qual_bme

FROM DBP_ETL.vis_tag_best_wg_wechsel_join t1

 INNER JOIN DBP_DATA.marktbestand_erp t2
 ON t1.dat         = t2.dat
 AND t1.art_id     = t2.art_id
 and t1.mandant_id = t2.mandant_id

 INNER JOIN DBP_DATA.marktbestand_erp_zu t3
 ON  t2.bestand_id = t3.bestand_id and
     t2.mandant_id = t3.mandant_id

 LEFT OUTER JOIN DBP_DATA.art_wup_zu_per t4
 ON  t2.mandant_id = t4.mandant_id
 AND t2.art_id     = t4.art_id
 AND t2.wup_id     = t4.wup_id
 AND t2.nb_id      = t4.nb_id
 AND t2.dat BETWEEN t4.dat_von AND t4.dat_bis

GROUP BY
 t2.mandant_id
 ,t2.wup_id
 ,t1.wg_id
 ,t1.dat
-- ,t4.abt_id
 ,t1.gj
 ,t1.kjmo
 ,t1.kjwo
 ,t1.arthiertyp_id
 ,t2.nb_id
 ,t2.relevant_fg
 ,t2.bezugsweg_id
 ,t3.wrg_id

;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'T1' does not exist or not authorized.
UPDATE t1

SET betrag_mo_anf_vk_ntto_frei_bme = tmp.betrag_vk_netto_frei_bme
   ,betrag_mo_anf_vk_ntto_qual_bme = tmp.betrag_vk_netto_qual_bme
   ,betrag_mo_anf_vk_btto_frei_bme = tmp.betrag_vk_brutto_frei_bme
   ,betrag_mo_anf_vk_btto_qual_bme = tmp.betrag_vk_brutto_qual_bme
FROM DBP_ETL.vis_tag_best_wg_wechsel_sum_t1 t1,
(SELECT vtbw.mandant_id
       ,vtbw.wup_id
       ,vtbw.wg_id
       ,vtbw.gj
       ,m.kjmo
       ,vtbw.arthiertyp_id
       ,vtbw.nb_id
       ,vtbw.relevant_fg
       ,vtbw.bezugsweg_id
       ,vtbw.wrg_id
       ,vtbw.betrag_vk_netto_frei_bme
       ,vtbw.betrag_vk_netto_qual_bme
       ,vtbw.betrag_vk_brutto_frei_bme
       ,vtbw.betrag_vk_brutto_qual_bme
 FROM DBP_ETL.vis_tag_best_wg_wechsel_sum_t1 vtbw
    INNER JOIN
      DBP_DATA.monat m
    ON  m.min_dat -1 = vtbw.dat
) tmp WHERE t1.mandant_id    = tmp.mandant_id
  AND t1.wup_id        = tmp.wup_id
  AND t1.wg_id         = tmp.wg_id
  AND t1.gj            = tmp.gj
  AND t1.kjmo          = tmp.kjmo
  AND t1.arthiertyp_id = tmp.arthiertyp_id
  AND t1.nb_id         = tmp.nb_id
  AND t1.relevant_fg   = tmp.relevant_fg
  AND t1.bezugsweg_id  = tmp.bezugsweg_id
  AND t1.wrg_id        = tmp.wrg_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Possible parameter resolution issue
DELETE FROM DBP_ETL.vis_tag_best_wg_wechsel_sum_t1
WHERE kjmo IN
  (SELECT kjmo
   FROM DBP_DATA.monat
   WHERE akt_mo = $VIS_BESTAND_AKT_MO_VON -1
  )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_tag_best_wg_wechsel_sum_t1
(
mandant_id
, wup_id
, wg_id
, dat
--, abt_id
, gj
, kjmo
, kjwo
, arthiertyp_id
, nb_id
, relevant_fg
, bezugsweg_id
, wrg_id
, anz_artikel_bestand
, anz_artikel_fehlmengen
, anz_artikel_nullbestand
, anz_artikel_minusbestand
, menge_lgbest_erp_frei_bme
, menge_lgbest_erp_qual_bme
, betrag_vk_netto_frei_bme
, betrag_vk_netto_qual_bme
, betrag_vk_brutto_frei_bme
, betrag_vk_brutto_qual_bme
, betrag_mo_anf_vk_ntto_frei_bme
, betrag_mo_anf_vk_ntto_qual_bme
, betrag_mo_anf_vk_btto_frei_bme
, betrag_mo_anf_vk_btto_qual_bme
)
SELECT
  t1.mandant_id
 ,t1.wup_id
 ,t1.wg_id
 ,t1.dat
-- ,t1.abt_id
 ,t1.gj
 ,t1.kjmo
 ,t1.kjwo
 ,t1.arthiertyp_id
 ,t1.nb_id
 ,t1.relevant_fg
 ,t1.bezugsweg_id
 ,k.nach_wrg_id
 ,0 AS anz_artikel_bestand
 ,0 AS anz_artikel_fehlmengen
 ,0 AS anz_artikel_nullbestand
 ,0 AS anz_artikel_minusbestand
 ,t1.menge_lgbest_erp_frei_bme                           AS menge_lgbest_erp_frei_bme
 ,t1.menge_lgbest_erp_qual_bme                           AS menge_lgbest_erp_qual_bme
 ,t1.betrag_vk_netto_frei_bme       * k.umrechnungskurs  AS betrag_vk_netto_frei_bme
 ,t1.betrag_vk_netto_qual_bme       * k.umrechnungskurs  AS betrag_vk_netto_qual_bme
 ,t1.betrag_vk_brutto_frei_bme      * k.umrechnungskurs  AS betrag_vk_brutto_frei_bme
 ,t1.betrag_vk_brutto_qual_bme      * k.umrechnungskurs  AS betrag_vk_brutto_qual_bme
 ,t1.betrag_mo_anf_vk_ntto_frei_bme * k.umrechnungskurs  AS betrag_mo_anf_vk_ntto_frei_bme
 ,t1.betrag_mo_anf_vk_ntto_qual_bme * k.umrechnungskurs  AS betrag_mo_anf_vk_ntto_qual_bme
 ,t1.betrag_mo_anf_vk_btto_frei_bme * k.umrechnungskurs  AS betrag_mo_anf_vk_btto_frei_bme
 ,t1.betrag_mo_anf_vk_btto_qual_bme * k.umrechnungskurs  AS betrag_mo_anf_vk_btto_qual_bme
FROM DBP_ETL.vis_tag_best_wg_wechsel_sum_t1 t1
   INNER JOIN
     DBP_DATA.kurs k
   ON  k.von_wrg_id  = t1.wrg_id
   AND k.dat_bis     = to_date('9999-12-31','YYYY-MM-DD')
   AND k.nach_wrg_id = 'EUR'
   AND k.kurstyp_id  = 3
WHERE t1.wrg_id <> 'EUR'
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'ZIEL' does not exist or not authorized.
UPDATE ziel
FROM DBP_MSI_DATA.vis_tag_bestand_wg ziel,
     DBP_ETL.vis_tag_best_wg_wechsel_sum_t1 tmp
SET anz_artikel_bestand            = ziel.anz_artikel_bestand            + tmp.anz_artikel_bestand
   ,anz_artikel_fehlmengen         = ziel.anz_artikel_fehlmengen         + tmp.anz_artikel_fehlmengen
   ,anz_artikel_nullbestand        = ziel.anz_artikel_nullbestand        + tmp.anz_artikel_nullbestand
   ,anz_artikel_minusbestand       = ziel.anz_artikel_minusbestand       + tmp.anz_artikel_minusbestand
   ,menge_lgbest_erp_frei_bme      = ziel.menge_lgbest_erp_frei_bme      + tmp.menge_lgbest_erp_frei_bme
   ,menge_lgbest_erp_qual_bme      = ziel.menge_lgbest_erp_qual_bme      + tmp.menge_lgbest_erp_qual_bme
   ,betrag_vk_netto_frei_bme       = ziel.betrag_vk_netto_frei_bme       + tmp.betrag_vk_netto_frei_bme
   ,betrag_vk_netto_qual_bme       = ziel.betrag_vk_netto_qual_bme       + tmp.betrag_vk_netto_qual_bme
   ,betrag_vk_brutto_frei_bme      = ziel.betrag_vk_brutto_frei_bme      + tmp.betrag_vk_brutto_frei_bme
   ,betrag_vk_brutto_qual_bme      = ziel.betrag_vk_brutto_qual_bme      + tmp.betrag_vk_brutto_qual_bme
   ,betrag_mo_anf_vk_ntto_frei_bme = ziel.betrag_mo_anf_vk_ntto_frei_bme + tmp.betrag_mo_anf_vk_ntto_frei_bme
   ,betrag_mo_anf_vk_ntto_qual_bme = ziel.betrag_mo_anf_vk_ntto_qual_bme + tmp.betrag_mo_anf_vk_ntto_qual_bme
   ,betrag_mo_anf_vk_btto_frei_bme = ziel.betrag_mo_anf_vk_btto_frei_bme + tmp.betrag_mo_anf_vk_btto_frei_bme
   ,betrag_mo_anf_vk_btto_qual_bme = ziel.betrag_mo_anf_vk_btto_qual_bme + tmp.betrag_mo_anf_vk_btto_qual_bme
WHERE ziel.mandant_id    = tmp.mandant_id
  AND ziel.wup_id        = tmp.wup_id
  AND ziel.wg_id         = tmp.wg_id
  AND ziel.dat           = tmp.dat
  AND ziel.arthiertyp_id = tmp.arthiertyp_id
  AND ziel.nb_id         = tmp.nb_id
  AND ziel.relevant_fg   = tmp.relevant_fg
  AND ziel.bezugsweg_id  = tmp.bezugsweg_id
  AND ziel.wrg_id        = tmp.wrg_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_MSI_DATA.vis_tag_bestand_wg
(
  mandant_id
, wup_id
, wg_id
, dat
, abt_id
, gj
, kjmo
, kjwo
, arthiertyp_id
, nb_id
, relevant_fg
, bezugsweg_id
, wrg_id
, anz_artikel_bestand
, anz_artikel_fehlmengen
, anz_artikel_nullbestand
, anz_artikel_minusbestand
, menge_lgbest_erp_frei_bme
, menge_lgbest_erp_qual_bme
, betrag_vk_netto_frei_bme
, betrag_vk_netto_qual_bme
, betrag_vk_brutto_frei_bme
, betrag_vk_brutto_qual_bme
, betrag_mo_anf_vk_ntto_frei_bme
, betrag_mo_anf_vk_ntto_qual_bme
, betrag_mo_anf_vk_btto_frei_bme
, betrag_mo_anf_vk_btto_qual_bme
)
SELECT
  t1.mandant_id
 ,t1.wup_id
 ,t1.wg_id
 ,t1.dat
 ,wp.abt_id
 ,t1.gj
 ,t1.kjmo
 ,t1.kjwo
 ,t1.arthiertyp_id
 ,t1.nb_id
 ,t1.relevant_fg
 ,t1.bezugsweg_id
 ,t1.wrg_id
 ,t1.anz_artikel_bestand
 ,t1.anz_artikel_fehlmengen
 ,t1.anz_artikel_nullbestand
 ,t1.anz_artikel_minusbestand
 ,t1.menge_lgbest_erp_frei_bme
 ,t1.menge_lgbest_erp_qual_bme
 ,t1.betrag_vk_netto_frei_bme
 ,t1.betrag_vk_netto_qual_bme
 ,t1.betrag_vk_brutto_frei_bme
 ,t1.betrag_vk_brutto_qual_bme
 ,t1.betrag_mo_anf_vk_ntto_frei_bme
 ,t1.betrag_mo_anf_vk_ntto_qual_bme
 ,t1.betrag_mo_anf_vk_btto_frei_bme
 ,t1.betrag_mo_anf_vk_btto_qual_bme
FROM DBP_ETL.vis_tag_best_wg_wechsel_sum_t1 t1
   INNER JOIN
     DBP_DATA.wg_per wp
   ON  t1.mandant_id    = wp.mandant_id
   AND t1.wg_id         = wp.wg_id
   AND t1.arthiertyp_id = wp.arthiertyp_id
   AND wp.dat_bis       = to_date('9999-12-31','YYYY-MM-DD')

   LEFT OUTER JOIN
     DBP_MSI_DATA.vis_tag_bestand_wg ziel
   ON  t1.mandant_id    = ziel.mandant_id
   AND t1.wup_id        = ziel.wup_id
   AND t1.wg_id         = ziel.wg_id
   AND t1.dat           = ziel.dat
   AND t1.arthiertyp_id = ziel.arthiertyp_id
   AND t1.nb_id         = ziel.nb_id
   AND t1.relevant_fg   = ziel.relevant_fg
   AND t1.bezugsweg_id  = ziel.bezugsweg_id
   AND t1.wrg_id        = ziel.wrg_id
WHERE ziel.mandant_id IS NULL
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'T1' does not exist or not authorized.
UPDATE t1

SET betrag_d_vmo_vk_ntto_frei_bme = tmp.d_betrag_vk_netto_frei_bme
   ,betrag_d_vmo_vk_ntto_qual_bme = tmp.d_betrag_vk_netto_qual_bme
   ,betrag_d_vmo_vk_btto_frei_bme = tmp.d_betrag_vk_brutto_frei_bme
   ,betrag_d_vmo_vk_btto_qual_bme = tmp.d_betrag_vk_brutto_qual_bme
FROM DBP_MSI_DATA.vis_tag_bestand_wg t1,
(SELECT
     mandant_id
    ,wup_id
    ,wg_id
    ,abt_id
    ,dat
    ,kjmo
    ,arthiertyp_id
    ,nb_id
    ,relevant_fg
    ,bezugsweg_id
    ,wrg_id
    ,SUM(betrag_vk_netto_frei_bme)  OVER (PARTITION BY mandant_id, wup_id, nb_id, wg_id, abt_id, relevant_fg, bezugsweg_id, kjmo, wrg_id
                                          ORDER BY dat ASC
                                          ROWS UNBOUNDED PRECEDING) / EXTRACT (DAY FROM dat) AS d_betrag_vk_netto_frei_bme
    ,SUM(betrag_vk_netto_qual_bme)  OVER (PARTITION BY mandant_id, wup_id, nb_id, wg_id, abt_id, relevant_fg, bezugsweg_id, kjmo, wrg_id
                                          ORDER BY dat ASC
                                          ROWS UNBOUNDED PRECEDING) / EXTRACT (DAY FROM dat) AS d_betrag_vk_netto_qual_bme
    ,SUM(betrag_vk_brutto_frei_bme) OVER (PARTITION BY mandant_id, wup_id, nb_id, wg_id, abt_id, relevant_fg, bezugsweg_id, kjmo, wrg_id
                                          ORDER BY dat ASC
                                          ROWS UNBOUNDED PRECEDING) / EXTRACT (DAY FROM dat) AS d_betrag_vk_brutto_frei_bme
    ,SUM(betrag_vk_brutto_qual_bme) OVER (PARTITION BY mandant_id, wup_id, nb_id, wg_id, abt_id, relevant_fg, bezugsweg_id, kjmo, wrg_id
                                          ORDER BY dat ASC
                                          ROWS UNBOUNDED PRECEDING) / EXTRACT (DAY FROM dat) AS d_betrag_vk_brutto_qual_bme
 FROM DBP_MSI_DATA.vis_tag_bestand_wg
 WHERE (mandant_id, wg_id) IN
 (SELECT mandant_id, wg_id
  FROM DBP_ETL.vis_tag_best_wg_wechsel_join
 )
) tmp
 WHERE t1.mandant_id    = tmp.mandant_id
  AND t1.wup_id        = tmp.wup_id
  AND t1.wg_id         = tmp.wg_id
  AND t1.abt_id        = tmp.abt_id
  AND t1.dat           = tmp.dat
  AND t1.arthiertyp_id = tmp.arthiertyp_id
  AND t1.nb_id         = tmp.nb_id
  AND t1.relevant_fg   = tmp.relevant_fg
  AND t1.bezugsweg_id  = tmp.bezugsweg_id
  AND t1.wrg_id        = tmp.wrg_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.vis_tag_bestand_wg_wechsel_log;

