--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_monat_bestand_stamm_lkp_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.vis_monat_bestand_stamm_lkp_1  (
      art_id INTEGER NOT NULL,
      mandant_id BYTEINT NOT NULL,
      gjmo INTEGER NOT NULL,
      gj SMALLINT NOT NULL,
      kjmo INTEGER NOT NULL,
      max_dat DATE NOT NULL,
      wg_id SMALLINT NOT NULL,
      abt_id SMALLINT,
      arthiertyp_id BYTEINT NOT NULL,
      mwst DECIMAL(12,2) NOT NULL,
      wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_monat_bestand_stamm_lkp2_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.vis_monat_bestand_stamm_lkp2_1  (
      mandant_id BYTEINT NOT NULL ,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL ,
      kjmo INTEGER NOT NULL,
      art_id INTEGER NOT NULL,
      relevant_fg BYTEINT NOT NULL )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_monat_bestand_wg_tmp1_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--WARNING : UNIQUE PRIMARY INDEX applied on the table. Use PRIMARY KEY or UNIQUE constraint.
CREATE TABLE DBP_ETL.vis_monat_bestand_wg_tmp1_1  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL ,
      gjmo INTEGER NOT NULL,
      gj SMALLINT NOT NULL,
      kjmo INTEGER NOT NULL,
      max_dat DATE NOT NULL, UNIQUE ( mandant_id ,wup_id, gjmo ));

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_monat_bestand_wg_tmp2_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.vis_monat_bestand_wg_tmp2_1  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL ,
      art_id INTEGER NOT NULL,
      gjmo INTEGER NOT NULL,
      gj SMALLINT NOT NULL,
      kjmo INTEGER NOT NULL,
      max_dat DATE NOT NULL,
      wg_id SMALLINT NOT NULL,
      abt_id SMALLINT NOT NULL ,
      arthiertyp_id BYTEINT NOT NULL ,
      wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
      menge_lgbest_erp_frei_bme DECIMAL(18,3) NOT NULL ,
      menge_lgbest_erp_qual_bme DECIMAL(18,3) NOT NULL ,
      mwst DECIMAL(12,2) NOT NULL)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_monat_bestand_wg_tmp3_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.vis_monat_bestand_wg_tmp3_1  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL ,
      gjmo INTEGER NOT NULL,
      gj SMALLINT NOT NULL,
      kjmo INTEGER NOT NULL,
      wg_id SMALLINT NOT NULL,
      abt_id SMALLINT NOT NULL ,
      arthiertyp_id BYTEINT NOT NULL ,
      relevant_fg BYTEINT NOT NULL ,
      bezugsweg_id BYTEINT NOT NULL ,
      wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
      menge_lgbest_erp_frei_bme DECIMAL(18,3) NOT NULL ,
      menge_lgbest_erp_qual_bme DECIMAL(18,3) NOT NULL ,
      betrag_vk_netto_frei_bme DECIMAL(18,4) ,
      betrag_vk_netto_qual_bme DECIMAL(18,4) ,
      betrag_vk_brutto_frei_bme DECIMAL(18,4) ,
      betrag_vk_brutto_qual_bme DECIMAL(18,4) )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_monat_bestand_wg_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.vis_monat_bestand_wg_1 LIKE
DBP_MSI_DATA.vis_monat_bestand_wg_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.
INSERT INTO DBP_ETL.vis_monat_bestand_wg_tmp1_1
(
   mandant_id
  ,wup_id
  ,nb_id
  ,gjmo
  ,gj
  ,kjmo
  ,max_dat
)
SELECT
    l.mandant_id
   ,l.wup_id
   ,l.nb_id
   ,m.gjmo
   ,m.gj
   ,m.kjmo
   ,CASE
      WHEN EXTRACT(MONTH FROM m.max_dat) = EXTRACT(MONTH FROM CURRENT_DATE)
      THEN CURRENT_DATE
      ELSE m.max_dat
    END AS max_dat
FROM
(
 SELECT
    mandant_id
   ,wup_id
   ,nb_id
   ,MIN(gjmo) min_gjmo
 FROM DBP_ETL.vis_monat_bestand_wg_log_1
 GROUP BY mandant_id
         ,wup_id
         ,nb_id
) l
  INNER JOIN
     DBP_DATA.monat_1 m
  ON  l.min_gjmo   <= m.gjmo
--  AND m.akt_mo     <= 0
--  AND m.akt_gj IN (-2, -1, 0)
  AND m.akt_mo BETWEEN -2 AND 0
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_monat_bestand_stamm_lkp_1
(
      art_id
     ,mandant_id
     ,kjmo
     ,gj
     ,gjmo
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
     ,zeit.kjmo
     ,zeit.gj
     ,zeit.gjmo
     ,zeit.max_dat
     ,awzp.wg_id
     ,wp.abt_id
     ,awzp.arthiertyp_id
     ,COALESCE (mp.mwst, 0.)
     ,mwtz.default_wrg
FROM DBP_DATA.art_1 a
  INNER JOIN
     DBP_DATA.monat_1 zeit_1
  ON  zeit.akt_mo     <= 0
  AND zeit.akt_gj IN (-2, -1, 0)

  INNER JOIN DBP_DATA.art_wg_zu_per_1 awzp
 ON  a.mandant_id       = awzp.mandant_id
 AND a.art_id           = awzp.art_id
 AND awzp.arthiertyp_id = 2
 AND awzp.dat_bis       = to_date('9999-12-31','YYYY-MM_1-DD')

  INNER JOIN DBP_DATA.wg_per_1 wp
 ON  awzp.mandant_id    = wp.mandant_id
 AND awzp.wg_id         = wp.wg_id
 AND awzp.arthiertyp_id = wp.arthiertyp_id
 AND wp.dat_bis         = to_date('9999-12-31','YYYY-MM_1-DD')

 INNER JOIN DBP_DATA.mwst_per_1 mp
 ON  a.mandant_id = mp.mandant_id
 AND a.mwst_id    = mp.mwst_id
 AND zeit.max_dat BETWEEN mp.dat_von AND mp.dat_bis

 INNER JOIN DBP_DATA.mandant_1 mwtz
 ON  a.mandant_id    = mwtz.mandant_id
WHERE (a.mandant_id, zeit.gjmo) IN
(SELECT mandant_id, gjmo
 FROM DBP_ETL.vis_monat_bestand_wg_tmp1_1
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_monat_bestand_stamm_lkp2_1
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
FROM DBP_DATA.art_wup_zu_per_1 t21

JOIN DBP_ETL.vis_monat_bestand_wg_tmp1_1 t22
ON  t21.mandant_id = t22.mandant_id
AND t21.wup_id     = t22.wup_id
AND t21.nb_id      = t22.nb_id
AND t22.max_dat BETWEEN t21.dat_von AND t21.dat_bis

JOIN DBP_DATA.art_1 t23
ON t21.mandant_id = t23.mandant_id
AND t21.art_id = t23.art_id

JOIN DBP_DATA.wup_1 t24
ON t21.mandant_id = t24.mandant_id
AND t21.wup_id = t24.wup_id
AND t21.nb_id = t24.nb_id
AND t22.max_dat BETWEEN t24.dat_von AND t24.dat_bis

JOIN DBP_DATA.art_wup_status_per_1 t25
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
DELETE FROM DBP_ETL.vis_monat_bestand_stamm_lkp2_1
WHERE (kjmo,mandant_id,art_id,wup_id,nb_id) IN (SELECT b.kjmo,
                                                       a.mandant_id,
                                                       a.art_id,
                                                       a.wup_id,
                                                       a.nb_id 
                                                FROM DBP_ETL.vis_mard_relevant_1 a
                                                JOIN DBP_ETL.vis_monat_bestand_wg_tmp1_1 b
                                                  ON a.mandant_id = b.mandant_id AND 
                                                     a.wup_id = b.wup_id AND
                                                     a.nb_id = b.nb_id AND
                                                     a.dat = b.max_dat)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_monat_bestand_stamm_lkp2_1 (kjmo
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
FROM DBP_ETL.vis_mard_relevant_1 a
JOIN DBP_ETL.vis_monat_bestand_wg_tmp1_1 b
  ON a.mandant_id = b.mandant_id AND 
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.dat = b.max_dat
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_monat_bestand_wg_tmp2_1
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
-- Falls der Artikel_1 nicht in art_wup_zu_per_1 gelistet ist, wird die Default wrg_id aus mandant_wrg_typ_zu_1 ermittelt
--  (s. Befuellung vis_monat_bestand_stamm_lkp_1)
-- Sobald wrg_id in den Bewegungsdaten mitgeliefert wird, sollte immer die wrg_id aus bestand_erp_monat_1 ermittelt werden.
 ,t3.wrg_id           AS wrg_id
 ,t1.menge_lgbest_erp_frei_bme                                        AS menge_lgbest_erp_frei_bme
 ,t1.menge_lgbest_erp_qual_bme                                        AS menge_lgbest_erp_qual_bme
 ,t3.mwst

FROM DBP_DATA.bestand_erp_monat_1 t1_1

 INNER JOIN
     DBP_ETL.vis_monat_bestand_stamm_lkp_1 t3
 ON  t1.mandant_id = t3.mandant_id
 AND t1.art_id     = t3.art_id
 AND t3.gjmo BETWEEN t1.gjmo AND t1.gjmo_bis

WHERE t1.nb_id = 0
  AND (t1.mandant_id, t1.wup_id, t1.nb_id, t3.gjmo) IN
(SELECT mandant_id, wup_id, nb_id, gjmo
 FROM DBP_ETL.vis_monat_bestand_wg_tmp1_1 
)

;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_monat_bestand_wg_tmp3_1
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
-- Falls der Artikel_1 nicht in art_wup_zu_per_1 gelistet ist, wird die Default wrg_id aus mandant_wrg_typ_zu_1 ermittelt
--  (s. Befuellung vis_monat_bestand_stamm_lkp_1)
 ,COALESCE ( (CASE WHEN t2.wrg_id = 'EU4' THEN 'EUR' ELSE t2.wrg_id END), t1.wrg_id)           AS _wrg_id
 ,SUM(t1.menge_lgbest_erp_frei_bme)                                        AS menge_lgbest_erp_frei_bme
 ,SUM(t1.menge_lgbest_erp_qual_bme)                                        AS menge_lgbest_erp_qual_bme
 ,SUM( CAST ((COALESCE (t2.vk_brutto, 0.)) / (1+(t1.mwst/100)) * t1.menge_lgbest_erp_frei_bme AS DECIMAL(18,4))) AS betrag_vk_netto_frei_bme
 ,SUM( CAST ((COALESCE (t2.vk_brutto, 0.)) / (1+(t1.mwst/100)) * t1.menge_lgbest_erp_qual_bme AS DECIMAL(18,4))) AS betrag_vk_netto_qual_bme
 ,SUM( CAST ((COALESCE (t2.vk_brutto, 0.)) * t1.menge_lgbest_erp_frei_bme AS DECIMAL(18,4))) AS betrag_vk_brutto_frei_bme
 ,SUM( CAST ((COALESCE (t2.vk_brutto, 0.)) * t1.menge_lgbest_erp_qual_bme AS DECIMAL(18,4))) AS betrag_vk_brutto_qual_bme

FROM DBP_ETL.vis_monat_bestand_wg_tmp2_1 t1_1

 LEFT OUTER JOIN  -- Wie in Markbestand-Verarbeitung s. bestand_mardf_delta.btq
     DBP_DATA.art_wup_zu_per_1 t2
 ON  t1.mandant_id = t2.mandant_id
 AND t1.wup_id     = t2.wup_id
 AND t1.nb_id      = t2.nb_id
 AND t1.art_id     = t2.art_id
 AND t1.max_dat BETWEEN t2.dat_von AND t2.dat_bis

 LEFT OUTER JOIN  -- Wie in Markbestand-Verarbeitung s. bestand_mardf_delta.btq
     DBP_ETL.vis_monat_bestand_stamm_lkp2_1 t3
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
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_1
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
--                                       ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo, 100)   AS menge_lgbest_erp_frei_bme_kum
-- ,SUM(tmp.menge_lgbest_erp_qual_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
--                                       ORDER BY m.gjmo ASC
--                                       ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo, 100)   AS menge_lgbest_erp_qual_bme_kum
-- ,SUM(tmp.betrag_vk_netto_frei_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
--                                       ORDER BY m.gjmo ASC
--                                       ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo, 100)   AS betrag_vk_netto_frei_bme_kum
-- ,SUM(tmp.betrag_vk_netto_qual_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
--                                       ORDER BY m.gjmo ASC
--                                       ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo, 100)   AS betrag_vk_netto_qual_bme_kum
-- ,SUM(tmp.betrag_vk_brutto_frei_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
--                                       ORDER BY m.gjmo ASC
--                                       ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo, 100)   AS betrag_vk_brutto_frei_bme_kum
-- ,SUM(tmp.betrag_vk_brutto_qual_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
--                                       ORDER BY m.gjmo ASC
--                                       ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo, 100)   AS betrag_vk_brutto_qual_bme_kum
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
-- FROM ${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_tmp3_1
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
-- FROM ${DWH_COMMON_DBX_MSI_DATA}.vis_monat_bestand_wg_1 t1_1
-- WHERE (mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, gj, bezugsweg_id, relevant_fg) IN
-- (SELECT mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, gj, bezugsweg_id, relevant_fg
--  FROM ${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_tmp3_1
-- )
--   AND (mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg) NOT IN
-- (SELECT mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg
--  FROM ${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_tmp3_1
-- )
--) tmp
--    INNER JOIN
--      ${DWH_COMMON_DBX_DATA}.monat_1 m
--    ON tmp.kjmo = m.kjmo
--
--QUALIFY (tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.wg_id, tmp.wrg_id, tmp.arthiertyp_id, tmp.kjmo, tmp.bezugsweg_id, tmp.relevant_fg) IN
-- (SELECT mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg
--  FROM ${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_tmp3_1
-- )
--;
--
--Comment from validation checker
--error line 47 at position 75 unexpected 'MOD'.
--                                       ROWS UNBOUNDED PRECEDING) / (m.gjmo  ^^^> MOD 100)   AS menge_lgbest_erp_frei_bme_kum
--syntax error line 47 at position 79 unexpected '100'.
--                                       ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD  ^^^> 100)   AS menge_lgbest_erp_frei_bme_kum
--translated statement
INSERT INTO DBP_ETL.vis_monat_bestand_wg_1
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
                                       ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo, 100)   AS menge_lgbest_erp_frei_bme_kum
 ,SUM(tmp.menge_lgbest_erp_qual_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
                                       ORDER BY m.gjmo ASC
                                       ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo, 100)   AS menge_lgbest_erp_qual_bme_kum
 ,SUM(tmp.betrag_vk_netto_frei_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
                                       ORDER BY m.gjmo ASC
                                       ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo, 100)   AS betrag_vk_netto_frei_bme_kum
 ,SUM(tmp.betrag_vk_netto_qual_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
                                       ORDER BY m.gjmo ASC
                                       ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo, 100)   AS betrag_vk_netto_qual_bme_kum
 ,SUM(tmp.betrag_vk_brutto_frei_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
                                       ORDER BY m.gjmo ASC
                                       ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo, 100)   AS betrag_vk_brutto_frei_bme_kum
 ,SUM(tmp.betrag_vk_brutto_qual_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
                                       ORDER BY m.gjmo ASC
                                       ROWS UNBOUNDED PRECEDING) / MOD(m.gjmo, 100)   AS betrag_vk_brutto_qual_bme_kum

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
 FROM DBP_ETL.vis_monat_bestand_wg_tmp3_1
 
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
 FROM DBP_MSI_DATA.vis_monat_bestand_wg_1 t1_1
 WHERE (mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, gj, bezugsweg_id, relevant_fg) IN
 (SELECT mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, gj, bezugsweg_id, relevant_fg
  FROM DBP_ETL.vis_monat_bestand_wg_tmp3_1
 )
   AND (mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg) NOT IN
 (SELECT mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg
  FROM DBP_ETL.vis_monat_bestand_wg_tmp3_1
 )
) tmp
    INNER JOIN
      DBP_DATA.monat_1 m
    ON tmp.kjmo = m.kjmo

QUALIFY (tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.wg_id, tmp.wrg_id, tmp.arthiertyp_id, tmp.kjmo, tmp.bezugsweg_id, tmp.relevant_fg) IN
 (SELECT mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg
  FROM DBP_ETL.vis_monat_bestand_wg_tmp3_1
 )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_monat_bestand_wg_1
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
FROM DBP_ETL.vis_monat_bestand_wg_1 t1_1
   INNER JOIN
     DBP_DATA.kurs_1 k
   ON  k.von_wrg_id  = t1.wrg_id
   AND k.dat_bis     = to_date('9999-12-31','YYYY-MM_1-DD')
   AND k.nach_wrg_id = 'EUR'
   AND k.kurstyp_id  = 3
WHERE t1.wrg_id <> 'EUR'
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_MSI_DATA.vis_monat_bestand_wg_1
WHERE (mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id) IN
 (SELECT mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id
  FROM DBP_ETL.vis_monat_bestand_wg_1
 )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_MSI_DATA.vis_monat_bestand_wg_1
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

FROM DBP_ETL.vis_monat_bestand_wg_1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.vis_monat_bestand_wg_log_1
;

