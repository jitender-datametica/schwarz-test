--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_monat_bestand_stamm_lkp
(
      art_id
     ,mandant_id
     ,gjmo
     ,gj
     ,kjmo
     ,max_dat
     ,wg_id
     ,abt_id
     ,arthiertyp_id
     ,mwst
     ,wrg_id
)
SELECT
      a.art_id
     ,a.mandant_id
     ,m.gjmo
     ,m.gj
     ,m.kjmo
     ,m.max_dat
     ,awzp.wg_id
     ,wp.abt_id
     ,awzp.arthiertyp_id
     ,COALESCE (mp.mwst, 0.)
     ,mwtz.default_wrg
FROM DBP_DATA.art a

 INNER JOIN
     DBP_ETL.vis_monat_bestand_relevanz m
 ON  a.mandant_id = m.mandant_id

 INNER JOIN DBP_DATA.art_wg_zu_per awzp
 ON  a.mandant_id        = awzp.mandant_id
 AND a.art_id            = awzp.art_id
 AND awzp.arthiertyp_id  = 2
 AND awzp.dat_bis        = to_date('9999-12-31','YYYY-MM-DD')

 INNER JOIN DBP_DATA.wg_per wp
 ON  awzp.mandant_id    = wp.mandant_id
 AND awzp.wg_id         = wp.wg_id
 AND awzp.arthiertyp_id = wp.arthiertyp_id
 AND wp.dat_bis         = to_date('9999-12-31','YYYY-MM-DD')

 LEFT OUTER JOIN DBP_DATA.mwst_per mp
 ON  a.mandant_id = mp.mandant_id
 AND a.mwst_id    = mp.mwst_id
 AND m.max_dat    BETWEEN mp.dat_von AND mp.dat_bis

 INNER JOIN DBP_DATA.mandant mwtz
 ON  a.mandant_id    = mwtz.mandant_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_monat_bestand_stamm_lkp2
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
FROM DBP_DATA.art_wup_zu_per t21

JOIN DBP_ETL.vis_monat_bestand_relevanz t22
ON  t21.mandant_id = t22.mandant_id
AND t22.max_dat BETWEEN t21.dat_von AND t21.dat_bis

JOIN DBP_DATA.art t23
ON t21.mandant_id = t23.mandant_id
AND t21.art_id = t23.art_id

JOIN DBP_DATA.wup t24
ON t21.mandant_id = t24.mandant_id
AND t21.wup_id = t24.wup_id
AND t21.nb_id = t24.nb_id
AND t22.max_dat BETWEEN t24.dat_von AND t24.dat_bis

JOIN DBP_DATA.art_wup_status_per t25
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
DELETE FROM DBP_ETL.vis_monat_bestand_stamm_lkp2
WHERE (kjmo,mandant_id,art_id,wup_id,nb_id) IN (SELECT b.kjmo,
                                                       a.mandant_id,
                                                       a.art_id,
                                                       a.wup_id,
                                                       a.nb_id 
                                                FROM DBP_ETL.vis_mard_relevant a
                                                JOIN DBP_ETL.vis_monat_bestand_relevanz b
                                                  ON a.mandant_id = b.mandant_id AND 
                                                     a.dat = b.max_dat)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_monat_bestand_stamm_lkp2 (kjmo
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
FROM DBP_ETL.vis_mard_relevant a
JOIN DBP_ETL.vis_monat_bestand_relevanz b
  ON a.mandant_id = b.mandant_id AND 
     a.dat = b.max_dat
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_monat_bestand_wg_tmp2
(
  mandant_id
 ,wup_id
 ,nb_id
 ,art_id
 ,gjmo
 ,gj
 ,kjmo
 ,max_dat
 ,wg_id
 ,abt_id
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
 ,t1.art_id
 ,t3.gjmo
 ,t3.gj
 ,t3.kjmo
 ,t3.max_dat
 ,t3.wg_id
 ,t3.abt_id
 ,t3.arthiertyp_id
-- Falls der Artikel nicht in art_wup_zu_per gelistet ist, wird die Default wrg_id aus mandant_wrg_typ_zu ermittelt
--  (s. Befuellung vis_monat_bestand_stamm_lkp)
-- Sobald wrg_id in den Bewegungsdaten mitgeliefert wird, sollte immer die wrg_id aus bestand_erp_monat ermittelt werden.
 ,t3.wrg_id           AS wrg_id
 ,t1.menge_lgbest_erp_frei_bme                                        AS menge_lgbest_erp_frei_bme
 ,t1.menge_lgbest_erp_qual_bme                                        AS menge_lgbest_erp_qual_bme
 ,t3.mwst

FROM DBP_DATA.bestand_erp_monat t1

 INNER JOIN
     DBP_ETL.vis_monat_bestand_stamm_lkp t3
 ON  t1.mandant_id = t3.mandant_id
 AND t1.art_id     = t3.art_id
 AND t3.gjmo BETWEEN t1.gjmo AND t1.gjmo_bis

WHERE t1.nb_id = 0
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_monat_bestand_wg_tmp3
(
  mandant_id
 ,wup_id
 ,nb_id
 ,gjmo
 ,gj
 ,kjmo
 ,wg_id
 ,abt_id
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
 ,t1.gjmo
 ,t1.gj
 ,t1.kjmo
 ,t1.wg_id
 ,t1.abt_id
 ,t1.arthiertyp_id
 ,COALESCE (t2.bezugsweg_id, 0)          AS _bezugsweg_id
 ,COALESCE (t3.relevant_fg, 0)           AS _relevant_fg
-- Falls der Artikel nicht in art_wup_zu_per gelistet istt, wird die Default wrg_id aus mandant ermittelt
--  (s. Befuellung vis_monat_bestand_stamm_lkp)
 ,COALESCE ( (CASE WHEN t2.wrg_id = 'EU4' THEN 'EUR' ELSE t2.wrg_id END), t1.wrg_id)        AS _wrg_id
 ,SUM(t1.menge_lgbest_erp_frei_bme)                                        AS menge_lgbest_erp_frei_bme
 ,SUM(t1.menge_lgbest_erp_qual_bme)                                        AS menge_lgbest_erp_qual_bme
 ,SUM( CAST ((COALESCE (t2.vk_brutto, 0.)) / (1+(t1.mwst/100)) * t1.menge_lgbest_erp_frei_bme AS DECIMAL(18,4))) AS betrag_vk_netto_frei_bme
 ,SUM( CAST ((COALESCE (t2.vk_brutto, 0.)) / (1+(t1.mwst/100)) * t1.menge_lgbest_erp_qual_bme AS DECIMAL(18,4))) AS betrag_vk_netto_qual_bme
 ,SUM( CAST ((COALESCE (t2.vk_brutto, 0.)) * t1.menge_lgbest_erp_frei_bme AS DECIMAL(18,4))) AS betrag_vk_brutto_frei_bme
 ,SUM( CAST ((COALESCE (t2.vk_brutto, 0.)) * t1.menge_lgbest_erp_qual_bme AS DECIMAL(18,4))) AS betrag_vk_brutto_qual_bme

FROM DBP_ETL.vis_monat_bestand_wg_tmp2 t1

 LEFT OUTER JOIN  -- Wie in Markbestand-Verarbeitung s. bestand_mardf_delta.btq
     DBP_DATA.art_wup_zu_per t2
 ON  t1.mandant_id = t2.mandant_id
 AND t1.wup_id     = t2.wup_id
 AND t1.nb_id      = t2.nb_id
 AND t1.art_id     = t2.art_id
 AND t1.max_dat BETWEEN t2.dat_von AND t2.dat_bis

 LEFT OUTER JOIN  -- Wie in Markbestand-Verarbeitung s. bestand_mardf_delta.btq
     DBP_ETL.vis_monat_bestand_stamm_lkp2 t3
 ON  t1.mandant_id = t3.mandant_id
 AND t1.wup_id     = t3.wup_id
 AND t1.nb_id      = t3.nb_id
 AND t1.art_id     = t3.art_id
 AND t1.kjmo       = t3.kjmo

GROUP BY
  t1.mandant_id
 ,t1.wup_id
 ,t1.nb_id
 ,t1.gjmo
 ,t1.gj
 ,t1.kjmo
 ,t1.wg_id
 ,t1.abt_id
 ,t1.arthiertyp_id
 ,_bezugsweg_id
 ,_relevant_fg
 ,_wrg_id

 ;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Modulo operator does not exist in Snowflake. Use MOD function instead.
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg
--(
--  mandant_id
-- ,wup_id
-- ,nb_id
-- ,gj
-- ,kjmo
-- ,wg_id
-- ,abt_id
-- ,arthiertyp_id
-- ,bezugsweg_id
-- ,relevant_fg
-- ,wrg_id
-- ,menge_lgbest_erp_frei_bme
-- ,menge_lgbest_erp_qual_bme
-- ,betrag_vk_netto_frei_bme
-- ,betrag_vk_netto_qual_bme
-- ,betrag_vk_brutto_frei_bme
-- ,betrag_vk_brutto_qual_bme
-- ,menge_lgbest_erp_frei_bme_kum
-- ,menge_lgbest_erp_qual_bme_kum
-- ,betrag_vk_netto_frei_bme_kum
-- ,betrag_vk_netto_qual_bme_kum
-- ,betrag_vk_brutto_frei_bme_kum
-- ,betrag_vk_brutto_qual_bme_kum
--)
--SELECT
--  tmp.mandant_id
-- ,tmp.wup_id
-- ,tmp.nb_id
-- ,tmp.gj
-- ,tmp.kjmo
-- ,tmp.wg_id
-- ,tmp.abt_id
-- ,tmp.arthiertyp_id
-- ,tmp.bezugsweg_id
-- ,tmp.relevant_fg
-- ,tmp.wrg_id
-- ,tmp.menge_lgbest_erp_frei_bme
-- ,tmp.menge_lgbest_erp_qual_bme
-- ,tmp.betrag_vk_netto_frei_bme
-- ,tmp.betrag_vk_netto_qual_bme
-- ,tmp.betrag_vk_brutto_frei_bme
-- ,tmp.betrag_vk_brutto_qual_bme
-- ,SUM(tmp.menge_lgbest_erp_frei_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
--                                       ORDER BY m.gjmo ASC
--                                       ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)   AS menge_lgbest_erp_frei_bme_kum
-- ,SUM(tmp.menge_lgbest_erp_qual_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
--                                       ORDER BY m.gjmo ASC
--                                       ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)   AS menge_lgbest_erp_qual_bme_kum
-- ,SUM(tmp.betrag_vk_netto_frei_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
--                                       ORDER BY m.gjmo ASC
--                                       ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)   AS betrag_vk_netto_frei_bme_kum
-- ,SUM(tmp.betrag_vk_netto_qual_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
--                                       ORDER BY m.gjmo ASC
--                                       ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)   AS betrag_vk_netto_qual_bme_kum
-- ,SUM(tmp.betrag_vk_brutto_frei_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
--                                       ORDER BY m.gjmo ASC
--                                       ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)   AS betrag_vk_brutto_frei_bme_kum
-- ,SUM(tmp.betrag_vk_brutto_qual_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
--                                       ORDER BY m.gjmo ASC
--                                       ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)   AS betrag_vk_brutto_qual_bme_kum
--
--FROM
--(SELECT
--    mandant_id
--   ,wup_id
--   ,nb_id
--   ,gj
--   ,kjmo
--   ,wg_id
--   ,abt_id
--   ,arthiertyp_id
--   ,bezugsweg_id
--   ,relevant_fg
--   ,wrg_id
--   ,menge_lgbest_erp_frei_bme
--   ,menge_lgbest_erp_qual_bme
--   ,betrag_vk_netto_frei_bme
--   ,betrag_vk_netto_qual_bme
--   ,betrag_vk_brutto_frei_bme
--   ,betrag_vk_brutto_qual_bme
-- FROM ${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_tmp3
-- 
--   UNION ALL
-- SELECT
--    mandant_id
--   ,wup_id
--   ,nb_id
--   ,gj
--   ,kjmo
--   ,wg_id
--   ,abt_id
--   ,arthiertyp_id
--   ,bezugsweg_id
--   ,relevant_fg
--   ,wrg_id
--   ,menge_lgbest_erp_frei_bme
--   ,menge_lgbest_erp_qual_bme
--   ,betrag_vk_netto_frei_bme
--   ,betrag_vk_netto_qual_bme
--   ,betrag_vk_brutto_frei_bme
--   ,betrag_vk_brutto_qual_bme
-- FROM ${DWH_COMMON_DBX_MSI_DATA}.vis_monat_bestand_wg t1
-- WHERE (mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, gj, bezugsweg_id, relevant_fg) IN
-- (SELECT mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, gj, bezugsweg_id, relevant_fg
--  FROM ${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_tmp3
-- )
--   AND (mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg) NOT IN
-- (SELECT mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg
--  FROM ${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_tmp3
-- )
--) tmp
--    INNER JOIN
--      ${DWH_COMMON_DBX_DATA}.monat m
--    ON tmp.kjmo = m.kjmo
--
--QUALIFY (tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.wg_id, tmp.wrg_id, tmp.arthiertyp_id, tmp.kjmo, tmp.bezugsweg_id, tmp.relevant_fg) IN
-- (SELECT mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg
--  FROM ${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_tmp3
-- )
--;
--
--Comment from validation checker
--error line 47 at position 75 unexpected 'MOD'.
--                                       ROWS UNBOUNDED PRECEDING) / (m.gjmo  ^^^> MOD 100)   AS menge_lgbest_erp_frei_bme_kum
--syntax error line 47 at position 79 unexpected '100'.
--                                       ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD  ^^^> 100)   AS menge_lgbest_erp_frei_bme_kum
--translated statement
INSERT INTO DBP_ETL.vis_monat_bestand_wg
(
  mandant_id
 ,wup_id
 ,nb_id
 ,gj
 ,kjmo
 ,wg_id
 ,abt_id
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
 ,menge_lgbest_erp_frei_bme_kum
 ,menge_lgbest_erp_qual_bme_kum
 ,betrag_vk_netto_frei_bme_kum
 ,betrag_vk_netto_qual_bme_kum
 ,betrag_vk_brutto_frei_bme_kum
 ,betrag_vk_brutto_qual_bme_kum
)
SELECT
  tmp.mandant_id
 ,tmp.wup_id
 ,tmp.nb_id
 ,tmp.gj
 ,tmp.kjmo
 ,tmp.wg_id
 ,tmp.abt_id
 ,tmp.arthiertyp_id
 ,tmp.bezugsweg_id
 ,tmp.relevant_fg
 ,tmp.wrg_id
 ,tmp.menge_lgbest_erp_frei_bme
 ,tmp.menge_lgbest_erp_qual_bme
 ,tmp.betrag_vk_netto_frei_bme
 ,tmp.betrag_vk_netto_qual_bme
 ,tmp.betrag_vk_brutto_frei_bme
 ,tmp.betrag_vk_brutto_qual_bme
 ,SUM(tmp.menge_lgbest_erp_frei_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
                                       ORDER BY m.gjmo ASC
                                       ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo , 100)   AS menge_lgbest_erp_frei_bme_kum
 ,SUM(tmp.menge_lgbest_erp_qual_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
                                       ORDER BY m.gjmo ASC
                                       ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo , 100)   AS menge_lgbest_erp_qual_bme_kum
 ,SUM(tmp.betrag_vk_netto_frei_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
                                       ORDER BY m.gjmo ASC
                                       ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo , 100)   AS betrag_vk_netto_frei_bme_kum
 ,SUM(tmp.betrag_vk_netto_qual_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
                                       ORDER BY m.gjmo ASC
                                       ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo , 100)   AS betrag_vk_netto_qual_bme_kum
 ,SUM(tmp.betrag_vk_brutto_frei_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
                                       ORDER BY m.gjmo ASC
                                       ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo , 100)   AS betrag_vk_brutto_frei_bme_kum
 ,SUM(tmp.betrag_vk_brutto_qual_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
                                       ORDER BY m.gjmo ASC
                                       ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo , 100)   AS betrag_vk_brutto_qual_bme_kum

FROM
(SELECT
    mandant_id
   ,wup_id
   ,nb_id
   ,gj
   ,kjmo
   ,wg_id
   ,abt_id
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
 FROM DBP_ETL.vis_monat_bestand_wg_tmp3
 
   UNION ALL
 SELECT
    mandant_id
   ,wup_id
   ,nb_id
   ,gj
   ,kjmo
   ,wg_id
   ,abt_id
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
 FROM DBP_MSI_DATA.vis_monat_bestand_wg t1
 WHERE (mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, gj, bezugsweg_id, relevant_fg) IN
 (SELECT mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, gj, bezugsweg_id, relevant_fg
  FROM DBP_ETL.vis_monat_bestand_wg_tmp3
 )
   AND (mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg) NOT IN
 (SELECT mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg
  FROM DBP_ETL.vis_monat_bestand_wg_tmp3
 )
) tmp
    INNER JOIN
      DBP_DATA.monat m
    ON tmp.kjmo = m.kjmo

QUALIFY (tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.wg_id, tmp.wrg_id, tmp.arthiertyp_id, tmp.kjmo, tmp.bezugsweg_id, tmp.relevant_fg) IN
 (SELECT mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg
  FROM DBP_ETL.vis_monat_bestand_wg_tmp3
 )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_monat_bestand_wg
(
  mandant_id
 ,wup_id
 ,nb_id
 ,gj
 ,kjmo
 ,wg_id
 ,abt_id
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
 ,menge_lgbest_erp_frei_bme_kum
 ,menge_lgbest_erp_qual_bme_kum
 ,betrag_vk_netto_frei_bme_kum
 ,betrag_vk_netto_qual_bme_kum
 ,betrag_vk_brutto_frei_bme_kum
 ,betrag_vk_brutto_qual_bme_kum
)
SELECT
  t1.mandant_id
 ,t1.wup_id
 ,t1.nb_id
 ,t1.gj
 ,t1.kjmo
 ,t1.wg_id
 ,t1.abt_id
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
 ,t1.menge_lgbest_erp_frei_bme_kum
 ,t1.menge_lgbest_erp_qual_bme_kum
 ,t1.betrag_vk_netto_frei_bme_kum  * k.umrechnungskurs AS betrag_vk_netto_frei_bme_kum
 ,t1.betrag_vk_netto_qual_bme_kum  * k.umrechnungskurs AS betrag_vk_netto_qual_bme_kum
 ,t1.betrag_vk_brutto_frei_bme_kum * k.umrechnungskurs AS betrag_vk_brutto_frei_bme_kum
 ,t1.betrag_vk_brutto_qual_bme_kum * k.umrechnungskurs AS betrag_vk_brutto_qual_bme_kum
FROM DBP_ETL.vis_monat_bestand_wg t1
   INNER JOIN
     DBP_DATA.kurs k
   ON  k.von_wrg_id  = t1.wrg_id
   AND k.dat_bis     = to_date('9999-12-31','YYYY-MM-DD')
   AND k.nach_wrg_id = 'EUR'
   AND k.kurstyp_id  = 3
WHERE t1.wrg_id <> 'EUR'
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_MSI_DATA.vis_monat_bestand_wg
WHERE (mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg) IN
 (SELECT mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg
  FROM DBP_ETL.vis_monat_bestand_wg
 )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_MSI_DATA.vis_monat_bestand_wg
(
  mandant_id
 ,wup_id
 ,nb_id
 ,gj
 ,kjmo
 ,wg_id
 ,abt_id
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
 ,menge_lgbest_erp_frei_bme_kum
 ,menge_lgbest_erp_qual_bme_kum
 ,betrag_vk_netto_frei_bme_kum
 ,betrag_vk_netto_qual_bme_kum
 ,betrag_vk_brutto_frei_bme_kum
 ,betrag_vk_brutto_qual_bme_kum
)
SELECT
  mandant_id
 ,wup_id
 ,nb_id
 ,gj
 ,kjmo
 ,wg_id
 ,abt_id
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
 ,menge_lgbest_erp_frei_bme_kum
 ,menge_lgbest_erp_qual_bme_kum
 ,betrag_vk_netto_frei_bme_kum
 ,betrag_vk_netto_qual_bme_kum
 ,betrag_vk_brutto_frei_bme_kum
 ,betrag_vk_brutto_qual_bme_kum

FROM DBP_ETL.vis_monat_bestand_wg
;

