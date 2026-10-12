--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.
INSERT INTO DBP_ETL.vis_mon_best_wg_wechsel_join_2
(
   art_id
   ,mandant_id
   ,arthiertyp_id
   ,alt_neu_kz
   ,wg_id
   ,gj
   ,gjmo
   ,kjmo
   ,max_dat
   ,mwst
   ,wrg_id
)
SELECT
    w1.art_id art_id
   ,w1.mandant_id mandant_id
   ,w1.arthiertyp_id arthiertyp_id
   ,w1.alt_neu_kz
   ,w1.wg_id
   ,m.gj
   ,m.gjmo
   ,m.kjmo
   ,CASE
      WHEN EXTRACT(MONTH FROM m.max_dat) = EXTRACT(MONTH FROM CURRENT_DATE)
      THEN CURRENT_DATE
      ELSE m.max_dat
    END AS max_dat
   ,COALESCE (mp.mwst, 0.)
   ,mwtz.default_wrg

FROM DBP_ETL.vis_mon_best_wg_wechsel_tmp_2 w1
   JOIN
     DBP_ETL.vis_mon_best_wg_wechsel_tmp_2 w2
   ON w1.mandant_id    = w2.mandant_id
  AND w1.art_id        = w2.art_id
  AND w1.arthiertyp_id = w2.arthiertyp_id
  AND ((w1.alt_neu_kz = 1 AND w2.alt_neu_kz = -1)
      OR
       (w1.alt_neu_kz = -1 AND w2.alt_neu_kz = 1))

   JOIN
     DBP_DATA.monat_2 m
  ON  m.akt_mo     <= 0
  AND m.akt_gj IN (-2, -1, 0)

   INNER JOIN DBP_DATA.art_2 a
  ON  w1.mandant_id = a.mandant_id
  AND w1.art_id     = a.art_id
  
   INNER JOIN DBP_DATA.mwst_per_2 mp
  ON  a.mandant_id = mp.mandant_id
  AND a.mwst_id    = mp.mwst_id
  AND m.max_dat BETWEEN mp.dat_von AND mp.dat_bis

   INNER JOIN DBP_DATA.mandant_2 mwtz
  ON  w1.mandant_id    = mwtz.mandant_id

WHERE (w1.wg_id <> w2.wg_id)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_monat_bestand_stamm_lkp2_2
(
    kjmo
   ,mandant_id
   ,art_id
   ,wup_id
   ,nb_id
   ,relevant_fg
)
SELECT
  t22.kjmo
  ,t21.mandant_id
  ,t21.art_id
  ,t21.wup_id
  ,t21.nb_id
  ,1                          AS relevanz_fg
FROM DBP_DATA.art_wup_zu_per_2 t21

JOIN DBP_ETL.vis_mon_best_wg_wechsel_join_2 t22
ON  t21.mandant_id = t22.mandant_id
AND t21.art_id     = t22.art_id
AND t22.alt_neu_kz = 1
AND t22.max_dat BETWEEN t21.dat_von AND t21.dat_bis

JOIN DBP_DATA.art_2 t23
ON t21.mandant_id = t23.mandant_id
AND t21.art_id = t23.art_id

JOIN DBP_DATA.wup_2 t24
ON t21.mandant_id = t24.mandant_id
AND t21.wup_id = t24.wup_id
AND t21.nb_id = t24.nb_id
AND t22.max_dat BETWEEN t24.dat_von AND t24.dat_bis

JOIN DBP_DATA.art_wup_status_per_2 t25
ON t21.mandant_id = t25.mandant_id
AND t21.art_id = t25.art_id
AND t21.wup_id = t25.wup_id
AND t21.nb_id = t25.nb_id
AND t22.max_dat BETWEEN t25.dat_von AND t25.dat_bis

WHERE t21.nb_id = 0
AND t21.listung_id = 1
AND COALESCE(t21.kdis, 0) = 0
AND t23.loesch_id <> 'L'
AND (t23.display_id NOT IN (1,2,3) OR t23.display_id IS NULL)
AND NOT t23.wg_art_fg = 1
AND ((t21.mandant_id <> 1 AND t25.dispomerkmal IN ('S2')) ---KMO: nur 'S2'---
 OR (t21.mandant_id = 1 AND t25.dispomerkmal IN ('11','ZZ'))) ---DE: '11','ZZ'---
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.vis_monat_bestand_stamm_lkp2_2
WHERE (kjmo,mandant_id,art_id,wup_id,nb_id) IN (SELECT b.kjmo,
                                                       a.mandant_id,
                                                       a.art_id,
                                                       a.wup_id,
                                                       a.nb_id 
                                                FROM DBP_ETL.vis_mard_relevant_2 a
                                                JOIN DBP_ETL.vis_mon_best_wg_wechsel_join_2 b
                                                  ON a.mandant_id = b.mandant_id AND 
                                                     a.art_id = b.art_id AND
                                                     b.alt_neu_kz = 1 AND
                                                     a.dat = b.max_dat)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_monat_bestand_stamm_lkp2_2 (kjmo
                                                   ,mandant_id
                                                   ,art_id
                                                   ,wup_id
                                                   ,nb_id
                                                   ,relevant_fg)
SELECT b.kjmo,
       a.mandant_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.relevant_fg
FROM DBP_ETL.vis_mard_relevant_2 a
JOIN DBP_ETL.vis_mon_best_wg_wechsel_join_2 b
  ON a.mandant_id = b.mandant_id AND 
     a.art_id = b.art_id AND
     b.alt_neu_kz = 1 AND
     a.dat = b.max_dat
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_mon_best_wg_wechsel_sum_t1_2
(
  mandant_id
 ,wup_id
 ,nb_id
 ,gj
 ,kjmo
 ,max_dat
 ,wg_id
 ,art_id
 ,arthiertyp_id
 ,wrg_id
 ,menge_lgbest_erp_frei_bme
 ,menge_lgbest_erp_qual_bme
 ,mwst
)
SELECT
  t1.mandant_id
 ,t1.wup_id
 ,t1.nb_id
 ,t2.gj
 ,t2.kjmo
 ,t2.max_dat
 ,t2.wg_id
 ,t2.art_id
 ,t2.arthiertyp_id
-- Falls der Artikel_2 nicht in art_wup_zu_per_2 gelistet ist, wird die Default wrg_id aus mandant_wrg_typ_zu_2 ermittelt
--  (s. Befuellung vis_monat_bestand_stamm_lkp_2)
 ,t2.wrg_id                                             AS wrg_id
 ,t1.menge_lgbest_erp_frei_bme * t2.alt_neu_kz          AS menge_lgbest_erp_frei_bme
 ,t1.menge_lgbest_erp_qual_bme * t2.alt_neu_kz          AS menge_lgbest_erp_qual_bme
 ,t2.mwst

FROM DBP_DATA.bestand_erp_monat_2 t1_2

 INNER JOIN
     DBP_ETL.vis_mon_best_wg_wechsel_join_2 t2
 ON  t1.mandant_id = t2.mandant_id
 AND t1.art_id     = t2.art_id
 AND t2.gjmo BETWEEN t1.gjmo AND t1.gjmo_bis
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_mon_best_wg_wechsel_sum_t2_2
(
  mandant_id
 ,wup_id
 ,nb_id
 ,gj
 ,kjmo
 ,wg_id
 ,arthiertyp_id
 ,bezugsweg_id
 ,relevant_fg
 ,wrg_id
 ,menge_lgbest_erp_frei_bme
 ,menge_lgbest_erp_qual_bme
 ,betrag_vk_netto_frei_bme
 ,betrag_vk_netto_qual_bme
 ,betrag_vk_brutto_frei_bme
 ,betrag_vk_brutto_qual_bme
)
SELECT
  t1.mandant_id
 ,t1.wup_id
 ,t1.nb_id
 ,t1.gj
 ,t1.kjmo
 ,t1.wg_id
 ,t1.arthiertyp_id
 ,COALESCE (t2.bezugsweg_id, 0)          AS _bezugsweg_id
 ,COALESCE (t3.relevant_fg, 0)           AS _relevant_fg
-- Falls der Artikel_2 nicht in art_wup_zu_per_2 gelistet istt, wird die Default wrg_id aus mandant_2 ermittelt
--  (s. Befuellung vis_monat_bestand_stamm_lkp_2)
 ,COALESCE ( (CASE WHEN t2.wrg_id = 'EU4' THEN 'EUR' ELSE t2.wrg_id END), t1.wrg_id)        AS _wrg_id
 ,SUM(t1.menge_lgbest_erp_frei_bme)                                        AS menge_lgbest_erp_frei_bme
 ,SUM(t1.menge_lgbest_erp_qual_bme)                                        AS menge_lgbest_erp_qual_bme
 ,SUM( CAST ((COALESCE (t2.vk_brutto, 0.)) / (1+(t1.mwst/100)) * t1.menge_lgbest_erp_frei_bme AS DECIMAL(18,4))) AS betrag_vk_netto_frei_bme
 ,SUM( CAST ((COALESCE (t2.vk_brutto, 0.)) / (1+(t1.mwst/100)) * t1.menge_lgbest_erp_qual_bme AS DECIMAL(18,4))) AS betrag_vk_netto_qual_bme
 ,SUM( CAST ((COALESCE (t2.vk_brutto, 0.)) * t1.menge_lgbest_erp_frei_bme AS DECIMAL(18,4))) AS betrag_vk_brutto_frei_bme
 ,SUM( CAST ((COALESCE (t2.vk_brutto, 0.)) * t1.menge_lgbest_erp_qual_bme AS DECIMAL(18,4))) AS betrag_vk_brutto_qual_bme

FROM DBP_ETL.vis_mon_best_wg_wechsel_sum_t1_2 t1_2

 LEFT OUTER JOIN  -- Wie in Markbestand-Verarbeitung s. bestand_mardf_delta.btq
     DBP_DATA.art_wup_zu_per_2 t2
 ON  t1.mandant_id = t2.mandant_id
 AND t1.wup_id     = t2.wup_id
 AND t1.nb_id      = t2.nb_id
 AND t1.art_id     = t2.art_id
 AND t1.max_dat BETWEEN t2.dat_von AND t2.dat_bis

 LEFT OUTER JOIN  -- Wie in Markbestand-Verarbeitung s. bestand_mardf_delta.btq
     DBP_ETL.vis_monat_bestand_stamm_lkp2_2 t3
 ON  t1.mandant_id = t3.mandant_id
 AND t1.wup_id     = t3.wup_id
 AND t1.nb_id      = t3.nb_id
 AND t1.art_id     = t3.art_id
 AND t1.kjmo       = t3.kjmo

GROUP BY
  t1.mandant_id
 ,t1.wup_id
 ,t1.nb_id
 ,t1.gj
 ,t1.kjmo
 ,t1.wg_id
 ,t1.arthiertyp_id
 ,_bezugsweg_id
 ,_relevant_fg
 ,_wrg_id

 ;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_mon_best_wg_wechsel_sum_t2_2
(
  mandant_id
 ,wup_id
 ,nb_id
 ,gj
 ,kjmo
 ,wg_id
 ,arthiertyp_id
 ,bezugsweg_id
 ,relevant_fg
 ,wrg_id
 ,menge_lgbest_erp_frei_bme
 ,menge_lgbest_erp_qual_bme
 ,betrag_vk_netto_frei_bme
 ,betrag_vk_netto_qual_bme
 ,betrag_vk_brutto_frei_bme
 ,betrag_vk_brutto_qual_bme
)
SELECT
  t1.mandant_id
 ,t1.wup_id
 ,t1.nb_id
 ,t1.gj
 ,t1.kjmo
 ,t1.wg_id
 ,t1.arthiertyp_id
 ,t1.bezugsweg_id
 ,t1.relevant_fg
 ,k.nach_wrg_id
 ,t1.menge_lgbest_erp_frei_bme
 ,t1.menge_lgbest_erp_qual_bme
 ,t1.betrag_vk_netto_frei_bme      * k.umrechnungskurs AS betrag_vk_netto_frei_bme
 ,t1.betrag_vk_netto_qual_bme      * k.umrechnungskurs AS betrag_vk_netto_qual_bme
 ,t1.betrag_vk_brutto_frei_bme     * k.umrechnungskurs AS betrag_vk_brutto_frei_bme
 ,t1.betrag_vk_brutto_qual_bme     * k.umrechnungskurs AS betrag_vk_brutto_qual_bme
FROM DBP_ETL.vis_mon_best_wg_wechsel_sum_t2_2 t1_2
   INNER JOIN
     DBP_DATA.kurs_2 k
   ON  k.von_wrg_id  = t1.wrg_id
   AND k.dat_bis     = to_date('9999-12-31','YYYY-MM_2-DD')
   AND k.nach_wrg_id = 'EUR'
   AND k.kurstyp_id  = 3
WHERE t1.wrg_id <> 'EUR'
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'ZIEL' does not exist or not authorized.
UPDATE DBP_MSI_DATA.vis_monat_bestand_wg_2 ziel

SET menge_lgbest_erp_frei_bme      = ziel.menge_lgbest_erp_frei_bme      + tmp.menge_lgbest_erp_frei_bme
   ,menge_lgbest_erp_qual_bme      = ziel.menge_lgbest_erp_qual_bme      + tmp.menge_lgbest_erp_qual_bme
   ,betrag_vk_netto_frei_bme       = ziel.betrag_vk_netto_frei_bme       + tmp.betrag_vk_netto_frei_bme
   ,betrag_vk_netto_qual_bme       = ziel.betrag_vk_netto_qual_bme       + tmp.betrag_vk_netto_qual_bme
   ,betrag_vk_brutto_frei_bme      = ziel.betrag_vk_brutto_frei_bme      + tmp.betrag_vk_brutto_frei_bme
   ,betrag_vk_brutto_qual_bme      = ziel.betrag_vk_brutto_qual_bme      + tmp.betrag_vk_brutto_qual_bme

FROM ( -- dedup FOR S4HANA tests
  SELECT *
  FROM DBP_ETL.vis_mon_best_wg_wechsel_sum_t2_2 
  QUALIFY 
    row_number() OVER (
      PARTITION BY     
        mandant_id
        ,wup_id
        ,wg_id
        ,kjmo
        ,arthiertyp_id
        ,nb_id
        ,wrg_id
        ,bezugsweg_id
        ,relevant_fg
      ORDER BY     
        mandant_id
        ,wup_id
        ,wg_id
        ,kjmo
        ,arthiertyp_id
        ,nb_id
        ,wrg_id
        ,bezugsweg_id
        ,relevant_fg
        ) = 1
) tmp
WHERE ziel.mandant_id    = tmp.mandant_id
  AND ziel.wup_id        = tmp.wup_id
  AND ziel.wg_id         = tmp.wg_id
  AND ziel.kjmo          = tmp.kjmo
  AND ziel.arthiertyp_id = tmp.arthiertyp_id
  AND ziel.nb_id         = tmp.nb_id
  AND ziel.wrg_id        = tmp.wrg_id
  AND ziel.bezugsweg_id  = tmp.bezugsweg_id
  AND ziel.relevant_fg   = tmp.relevant_fg
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_MSI_DATA.vis_monat_bestand_wg_2
(
  mandant_id
, wup_id
, wg_id
, abt_id
, gj
, kjmo
, arthiertyp_id
, bezugsweg_id
, relevant_fg
, nb_id
, wrg_id
, menge_lgbest_erp_frei_bme
, menge_lgbest_erp_qual_bme
, betrag_vk_netto_frei_bme
, betrag_vk_netto_qual_bme
, betrag_vk_brutto_frei_bme
, betrag_vk_brutto_qual_bme
)
SELECT
  t1.mandant_id
 ,t1.wup_id
 ,t1.wg_id
 ,wp.abt_id
 ,t1.gj
 ,t1.kjmo
 ,t1.arthiertyp_id
 ,t1.bezugsweg_id
 ,t1.relevant_fg
 ,t1.nb_id
 ,t1.wrg_id
 ,t1.menge_lgbest_erp_frei_bme
 ,t1.menge_lgbest_erp_qual_bme
 ,t1.betrag_vk_netto_frei_bme
 ,t1.betrag_vk_netto_qual_bme
 ,t1.betrag_vk_brutto_frei_bme
 ,t1.betrag_vk_brutto_qual_bme
FROM DBP_ETL.vis_mon_best_wg_wechsel_sum_t2_2 t1_2
   INNER JOIN
     DBP_DATA.wg_per_2 wp
   ON  t1.mandant_id    = wp.mandant_id
   AND t1.wg_id         = wp.wg_id
   AND t1.arthiertyp_id = wp.arthiertyp_id
   AND wp.dat_bis       = to_date('9999-12-31','YYYY-MM_2-DD')

   LEFT OUTER JOIN
     DBP_MSI_DATA.vis_monat_bestand_wg_2 ziel
   ON  t1.mandant_id    = ziel.mandant_id
   AND t1.wup_id        = ziel.wup_id
   AND t1.wg_id         = ziel.wg_id
   AND t1.kjmo          = ziel.kjmo
   AND t1.arthiertyp_id = ziel.arthiertyp_id
   AND t1.nb_id         = ziel.nb_id
   AND t1.wrg_id        = ziel.wrg_id
   AND t1.bezugsweg_id  = ziel.bezugsweg_id
   AND t1.relevant_fg   = ziel.relevant_fg
WHERE ziel.mandant_id IS NULL
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Modulo operator does not exist in Snowflake. Use MOD function instead.
--original statement
--UPDATE t1_2
--FROM ${DWH_COMMON_DBX_MSI_DATA}.vis_monat_bestand_wg_2 t1_2,
--(SELECT
--     t1.mandant_id
--    ,t1.wup_id
--    ,t1.wg_id
--    ,t1.abt_id
--    ,t1.kjmo
--    ,t1.arthiertyp_id
--    ,t1.bezugsweg_id
--    ,t1.relevant_fg
--    ,t1.nb_id
--    ,t1.wrg_id
--    ,SUM(t1.menge_lgbest_erp_frei_bme) OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
--                                             ORDER BY m.gjmo ASC
--                                             ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)    AS menge_lgbest_erp_frei_bme_kum
--    ,SUM(t1.menge_lgbest_erp_qual_bme) OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
--                                             ORDER BY m.gjmo ASC
--                                             ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)    AS menge_lgbest_erp_qual_bme_kum
--    ,SUM(t1.betrag_vk_netto_frei_bme)  OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
--                                             ORDER BY m.gjmo ASC
--                                             ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)    AS betrag_vk_netto_frei_bme_kum
--    ,SUM(t1.betrag_vk_netto_qual_bme)  OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
--                                             ORDER BY m.gjmo ASC
--                                             ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)    AS betrag_vk_netto_qual_bme_kum
--    ,SUM(t1.betrag_vk_brutto_frei_bme) OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
--                                             ORDER BY m.gjmo ASC
--                                             ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)    AS betrag_vk_brutto_frei_bme_kum
--    ,SUM(t1.betrag_vk_brutto_qual_bme) OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
--                                             ORDER BY m.gjmo ASC
--                                             ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)    AS betrag_vk_brutto_qual_bme_kum
-- FROM ${DWH_COMMON_DBX_MSI_DATA}.vis_monat_bestand_wg_2 t1_2
--   INNER JOIN
--      ${DWH_COMMON_DBX_DATA}.monat_2 m
--   ON t1.kjmo = m.kjmo
-- WHERE (t1.mandant_id, t1.wg_id) IN
-- (SELECT mandant_id, wg_id
--  FROM ${DWH_COMMON_DBX_LOAD}.vis_mon_best_wg_wechsel_join_2
-- )
--) tmp
--
--SET menge_lgbest_erp_frei_bme_kum = tmp.menge_lgbest_erp_frei_bme_kum
--   ,menge_lgbest_erp_qual_bme_kum = tmp.menge_lgbest_erp_qual_bme_kum
--   ,betrag_vk_netto_frei_bme_kum  = tmp.betrag_vk_netto_frei_bme_kum
--   ,betrag_vk_netto_qual_bme_kum  = tmp.betrag_vk_netto_qual_bme_kum
--   ,betrag_vk_brutto_frei_bme_kum = tmp.betrag_vk_brutto_frei_bme_kum
--   ,betrag_vk_brutto_qual_bme_kum = tmp.betrag_vk_brutto_qual_bme_kum
--WHERE t1.mandant_id    = tmp.mandant_id
--  AND t1.wup_id        = tmp.wup_id
--  AND t1.wg_id         = tmp.wg_id
--  AND t1.abt_id        = tmp.abt_id
--  AND t1.kjmo          = tmp.kjmo
--  AND t1.arthiertyp_id = tmp.arthiertyp_id
--  AND t1.nb_id         = tmp.nb_id
--  AND t1.wrg_id        = tmp.wrg_id
--  AND t1.bezugsweg_id  = tmp.bezugsweg_id
--  AND t1.relevant_fg   = tmp.relevant_fg
--;
--
--Comment from validation checker
--error line 23 at position 81 unexpected 'MOD'.
--                                             ROWS UNBOUNDED PRECEDING) / (m.gjmo  ^^^> MOD 100)    AS menge_lgbest_erp_frei_bme_kum
--syntax error line 23 at position 85 unexpected '100'.
--                                             ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD  ^^^> 100)    AS menge_lgbest_erp_frei_bme_kum
--syntax error line 24 at position 8 unexpected '('.
--    ,SUM ^^^> (t1.menge_lgbest_erp_qual_bme) OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
--syntax error line 25 at position 45 unexpected 'ORDER'.
--                                              ^^^> ORDER BY m.gjmo ASC
--translated statement
UPDATE DBP_MSI_DATA.vis_monat_bestand_wg_2 t1_2

SET menge_lgbest_erp_frei_bme_kum = tmp.menge_lgbest_erp_frei_bme_kum
   ,menge_lgbest_erp_qual_bme_kum = tmp.menge_lgbest_erp_qual_bme_kum
   ,betrag_vk_netto_frei_bme_kum  = tmp.betrag_vk_netto_frei_bme_kum
   ,betrag_vk_netto_qual_bme_kum  = tmp.betrag_vk_netto_qual_bme_kum
   ,betrag_vk_brutto_frei_bme_kum = tmp.betrag_vk_brutto_frei_bme_kum
   ,betrag_vk_brutto_qual_bme_kum = tmp.betrag_vk_brutto_qual_bme_kum
FROM 
(SELECT
     t1.mandant_id
    ,t1.wup_id
    ,t1.wg_id
    ,t1.abt_id
    ,t1.kjmo
    ,t1.arthiertyp_id
    ,t1.bezugsweg_id
    ,t1.relevant_fg
    ,t1.nb_id
    ,t1.wrg_id
    ,SUM(t1.menge_lgbest_erp_frei_bme) OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
                                             ORDER BY m.gjmo ASC
                                             ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo , 100)    AS menge_lgbest_erp_frei_bme_kum
    ,SUM(t1.menge_lgbest_erp_qual_bme) OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
                                             ORDER BY m.gjmo ASC
                                             ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo , 100)    AS menge_lgbest_erp_qual_bme_kum
    ,SUM(t1.betrag_vk_netto_frei_bme)  OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
                                             ORDER BY m.gjmo ASC
                                             ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo , 100)    AS betrag_vk_netto_frei_bme_kum
    ,SUM(t1.betrag_vk_netto_qual_bme)  OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
                                             ORDER BY m.gjmo ASC
                                             ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo , 100)    AS betrag_vk_netto_qual_bme_kum
    ,SUM(t1.betrag_vk_brutto_frei_bme) OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
                                             ORDER BY m.gjmo ASC
                                             ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo , 100)    AS betrag_vk_brutto_frei_bme_kum
    ,SUM(t1.betrag_vk_brutto_qual_bme) OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
                                             ORDER BY m.gjmo ASC
                                             ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo , 100)    AS betrag_vk_brutto_qual_bme_kum
 FROM DBP_MSI_DATA.vis_monat_bestand_wg_2 t1_2
   INNER JOIN
      DBP_DATA.monat_2 m
   ON t1.kjmo = m.kjmo
 WHERE (t1.mandant_id, t1.wg_id) IN
 (SELECT mandant_id, wg_id
  FROM DBP_ETL.vis_mon_best_wg_wechsel_join_2
 )
 QUALIFY 
   row_number() OVER ( -- dedup FOR S4HANA tests
     PARTITION BY 
       t1.mandant_id
       ,t1.wup_id
       ,t1.wg_id
       ,t1.abt_id
       ,t1.kjmo
       ,t1.arthiertyp_id
       ,t1.bezugsweg_id
       ,t1.relevant_fg
       ,t1.nb_id
       ,t1.wrg_id
     ORDER BY 
       t1.mandant_id
       ,t1.wup_id
       ,t1.wg_id
       ,t1.abt_id
       ,t1.kjmo
       ,t1.arthiertyp_id
       ,t1.bezugsweg_id
       ,t1.relevant_fg
       ,t1.nb_id
       ,t1.wrg_id
   ) = 1
) tmp
 WHERE t1.mandant_id    = tmp.mandant_id
  AND t1.wup_id        = tmp.wup_id
  AND t1.wg_id         = tmp.wg_id
  AND t1.abt_id        = tmp.abt_id
  AND t1.kjmo          = tmp.kjmo
  AND t1.arthiertyp_id = tmp.arthiertyp_id
  AND t1.nb_id         = tmp.nb_id
  AND t1.wrg_id        = tmp.wrg_id
  AND t1.bezugsweg_id  = tmp.bezugsweg_id
  AND t1.relevant_fg   = tmp.relevant_fg
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.vis_monat_best_wg_wechsel_log_2;

