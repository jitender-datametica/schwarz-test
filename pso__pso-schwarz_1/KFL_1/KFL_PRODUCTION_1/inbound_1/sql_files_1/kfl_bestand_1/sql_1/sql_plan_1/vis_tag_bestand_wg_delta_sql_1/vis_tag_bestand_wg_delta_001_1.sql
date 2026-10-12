--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_tag_bestand_wg_delta_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.vis_tag_bestand_wg_delta_1  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      wg_id SMALLINT NOT NULL,
      dat DATE NOT NULL,
      abt_id SMALLINT NOT NULL ,
      gj SMALLINT NOT NULL,
      kjmo INTEGER NOT NULL,
      kjwo INTEGER NOT NULL,
      arthiertyp_id BYTEINT NOT NULL ,
      nb_id SMALLINT NOT NULL ,
      relevant_fg BYTEINT NOT NULL ,
      bezugsweg_id BYTEINT NOT NULL ,
      wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
      anz_artikel_bestand INTEGER NOT NULL,
      anz_artikel_fehlmengen INTEGER NOT NULL ,
      anz_artikel_nullbestand INTEGER NOT NULL ,
      anz_artikel_minusbestand INTEGER NOT NULL ,
      menge_lgbest_erp_frei_bme DECIMAL(18,3) NOT NULL ,
      menge_lgbest_erp_qual_bme DECIMAL(18,3) NOT NULL ,
      betrag_vk_netto_frei_bme DECIMAL(18,4) ,
      betrag_vk_netto_qual_bme DECIMAL(18,4) ,
      betrag_vk_brutto_frei_bme DECIMAL(18,4) ,
      betrag_vk_brutto_qual_bme DECIMAL(18,4) ,
      betrag_mo_anf_vk_ntto_frei_bme DECIMAL(18,4) ,
      betrag_mo_anf_vk_ntto_qual_bme DECIMAL(18,4) ,
      betrag_mo_anf_vk_btto_frei_bme DECIMAL(18,4) ,
      betrag_mo_anf_vk_btto_qual_bme DECIMAL(18,4) )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_tag_bestand_stamm_lkp_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--WARNING : UNIQUE PRIMARY INDEX applied on the table. Use PRIMARY KEY or UNIQUE constraint.
CREATE TABLE DBP_ETL.vis_tag_bestand_stamm_lkp_1  (
      art_id INTEGER NOT NULL,
      mandant_id BYTEINT NOT NULL,
      wg_id SMALLINT NOT NULL,
      abt_id SMALLINT,
      arthiertyp_id BYTEINT NOT NULL)
;
--      mwst DECIMAL(12,2) NOT NULL,
--      mwst_dat_von DATE NOT NULL,
--      mwst_dat_bis DATE NOT NULL, UNIQUE ( art_id ,mandant_id  ));

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_tag_bestand_tag_lkp_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--WARNING : UNIQUE PRIMARY INDEX applied on the table. Use PRIMARY KEY or UNIQUE constraint.
CREATE TABLE DBP_ETL.vis_tag_bestand_tag_lkp_1  (
      dat DATE NOT NULL,
      gj SMALLINT NOT NULL,
      kjmo INTEGER NOT NULL,
      kjwo INTEGER NOT NULL, UNIQUE ( dat ));

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_tag_bestand_tag_lkp_1
(
   dat
  ,gj
  ,kjmo
  ,kjwo
)
SELECT
   dat
  ,gj
  ,kjmo
  ,kjwo
FROM DBP_DATA.tag_1
WHERE akt_tag <= 0
  AND dat > (SELECT MAX(dat)
             FROM DBP_MSI_DATA.vis_tag_bestand_wg_1)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_tag_bestand_stamm_lkp_1
(
      art_id
     ,mandant_id
     ,wg_id
     ,abt_id
     ,arthiertyp_id
/*     ,mwst
     ,mwst_dat_von
     ,mwst_dat_bis
*/
)
SELECT
      a.art_id
     ,a.mandant_id
     ,awzp.wg_id
     ,wp.abt_id
     ,awzp.arthiertyp_id
/*     ,COALESCE (mp.mwst, 0.)
     ,COALESCE (mp.dat_von, to_date('1900-01-01','YYYY-MM_1-DD'))
     ,COALESCE (mp.dat_bis, CURRENT_DATE '9999-12-31')
*/
FROM DBP_DATA.art_1 a

 INNER JOIN DBP_DATA.art_wg_zu_per_1 awzp
 ON  a.mandant_id       = awzp.mandant_id
 AND a.art_id           = awzp.art_id
 AND awzp.arthiertyp_id = 2
 AND awzp.dat_bis       = to_date('9999-12-31','YYYY-MM_1-DD')

 INNER JOIN DBP_DATA.wg_per_1 wp
 ON awzp.mandant_id     = wp.mandant_id
 AND awzp.wg_id         = wp.wg_id
 AND awzp.arthiertyp_id = wp.arthiertyp_id
 AND wp.dat_bis         = to_date('9999-12-31','YYYY-MM_1-DD')
/* 
 LEFT OUTER JOIN DBP_DATA.mwst_per_1 mp
 ON  a.mandant_id = mp.mandant_id
 AND a.mwst_id    = mp.mwst_id
*/
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_tag_bestand_wg_delta_1
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
)
SELECT
  t2.mandant_id
 ,t2.wup_id
 ,t4.wg_id
 ,t1.dat
 ,t4.abt_id
 ,t1.gj
 ,t1.kjmo
 ,t1.kjwo
 ,t4.arthiertyp_id
 ,t2.nb_id
 ,t2.relevant_fg
 ,t2.bezugsweg_id
 ,t3.wrg_id
 ,COUNT(t2.art_id) AS anz_artikel_bestand
 ,SUM(CASE WHEN t2.menge_lgbest_erp_frei_bme <= 0 THEN 1 ELSE 0 END )      AS anz_artikel_fehlmenge
 ,SUM(CASE WHEN t2.menge_lgbest_erp_frei_bme = 0 THEN 1 ELSE 0 END )       AS anz_artikel_nullbestand
 ,SUM(CASE WHEN t2.menge_lgbest_erp_frei_bme < 0 THEN 1 ELSE 0 END )       AS anz_artikel_minusbestand
 ,SUM(t2.menge_lgbest_erp_frei_bme)                                        AS menge_lgbest_erp_frei_bme
 ,SUM(t2.menge_lgbest_erp_qual_bme)                                        AS menge_lgbest_erp_qual_bme
 ,SUM( CAST (t3.vk_netto * t2.menge_lgbest_erp_frei_bme AS DECIMAL(18,4))) AS betrag_vk_netto_frei_bme
 ,SUM( CAST (t3.vk_netto * t2.menge_lgbest_erp_qual_bme AS DECIMAL(18,4))) AS betrag_vk_netto_qual_bme
 ,SUM( CAST ( (COALESCE(t5.vk_brutto, 0.)) * t2.menge_lgbest_erp_frei_bme AS DECIMAL(18,4))) AS betrag_vk_brutto_frei_bme
 ,SUM( CAST ( (COALESCE(t5.vk_brutto, 0.)) * t2.menge_lgbest_erp_qual_bme AS DECIMAL(18,4))) AS betrag_vk_brutto_qual_bme

FROM DBP_ETL.vis_tag_bestand_tag_lkp_1 t1_1

 INNER JOIN DBP_DATA.marktbestand_erp_1 t2
 ON t1.dat  = t2.dat

 INNER JOIN DBP_DATA.marktbestand_erp_zu_1 t3
 ON  t2.bestand_id = t3.bestand_id and
     t2.mandant_id = t3.mandant_id

 INNER JOIN DBP_ETL.vis_tag_bestand_stamm_lkp_1 t4
 ON  t2.mandant_id = t4.mandant_id
 AND t2.art_id     = t4.art_id
-- AND t1.dat BETWEEN t4.mwst_dat_von AND t4.mwst_dat_bis

 LEFT OUTER JOIN DBP_DATA.art_wup_zu_per_1 t5
 ON  t2.mandant_id = t5.mandant_id
 AND t2.art_id     = t5.art_id
 AND t2.wup_id     = t5.wup_id
 AND t2.nb_id      = t5.nb_id
 AND t2.dat BETWEEN t5.dat_von AND t5.dat_bis

GROUP BY
 t2.mandant_id
 ,t2.wup_id
 ,t4.wg_id
 ,t1.dat
 ,t4.abt_id
 ,t1.gj
 ,t1.kjmo
 ,t1.kjwo
 ,t4.arthiertyp_id
 ,t2.nb_id
 ,t2.relevant_fg
 ,t2.bezugsweg_id
 ,t3.wrg_id

;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'T1_1' does not exist or not authorized.
UPDATE DBP_ETL.vis_tag_bestand_wg_delta_1 t1_1

SET betrag_mo_anf_vk_ntto_frei_bme = tmp.betrag_vk_netto_frei_bme
   ,betrag_mo_anf_vk_ntto_qual_bme = tmp.betrag_vk_netto_qual_bme
   ,betrag_mo_anf_vk_btto_frei_bme = tmp.betrag_vk_brutto_frei_bme
   ,betrag_mo_anf_vk_btto_qual_bme = tmp.betrag_vk_brutto_qual_bme
FROM 
(SELECT vtbw.mandant_id
       ,vtbw.wup_id
       ,vtbw.wg_id
       ,vtbw.abt_id
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
 FROM DBP_MSI_DATA.vis_tag_bestand_wg_1 vtbw
    INNER JOIN
      DBP_DATA.monat_1 m
    ON  m.min_dat -1 = vtbw.dat
    AND m.akt_mo     = 0
) tmp WHERE t1.mandant_id    = tmp.mandant_id
  AND t1.wup_id        = tmp.wup_id
  AND t1.wg_id         = tmp.wg_id
  AND t1.abt_id        = tmp.abt_id
  AND t1.gj            = tmp.gj
  AND t1.kjmo          = tmp.kjmo
  AND t1.arthiertyp_id = tmp.arthiertyp_id
  AND t1.nb_id         = tmp.nb_id
  AND t1.relevant_fg   = tmp.relevant_fg
  AND t1.bezugsweg_id  = tmp.bezugsweg_id
  AND t1.wrg_id        = tmp.wrg_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_tag_bestand_wg_delta_1
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
 ,t1.abt_id
 ,t1.gj
 ,t1.kjmo
 ,t1.kjwo
 ,t1.arthiertyp_id
 ,t1.nb_id
 ,t1.relevant_fg
 ,t1.bezugsweg_id
 ,k.nach_wrg_id
 ,0 AS anz_artikel_bestand
 ,0 AS anz_artikel_fehlmenge
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
FROM DBP_ETL.vis_tag_bestand_wg_delta_1 t1_1
   INNER JOIN
     DBP_DATA.kurs_1 k
   ON  k.von_wrg_id  = t1.wrg_id
   AND k.dat_bis     = to_date('9999-12-31','YYYY-MM_1-DD')
   AND k.nach_wrg_id = 'EUR'
   AND k.kurstyp_id  = 3
WHERE t1.wrg_id <> 'EUR'
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_MSI_DATA.vis_tag_bestand_wg_1
WHERE dat IN
(SELECT dat
 FROM DBP_ETL.vis_tag_bestand_tag_lkp_1
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_MSI_DATA.vis_tag_bestand_wg_1
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

FROM DBP_ETL.vis_tag_bestand_wg_delta_1
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'T1_1' does not exist or not authorized.
UPDATE  DBP_MSI_DATA.vis_tag_bestand_wg_1 t1_1

SET betrag_d_vmo_vk_ntto_frei_bme = tmp.d_betrag_vk_netto_frei_bme
   ,betrag_d_vmo_vk_ntto_qual_bme = tmp.d_betrag_vk_netto_qual_bme
   ,betrag_d_vmo_vk_btto_frei_bme = tmp.d_betrag_vk_brutto_frei_bme
   ,betrag_d_vmo_vk_btto_qual_bme = tmp.d_betrag_vk_brutto_qual_bme
FROM
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
 FROM DBP_MSI_DATA.vis_tag_bestand_wg_1
 WHERE kjmo IN
 (SELECT kjmo
  FROM DBP_ETL.vis_tag_bestand_tag_lkp_1
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

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_MSI_DATA}.vis_tag_bestand_wg_1
--WHERE kjmo IN
--(SELECT kjmo
-- FROM ${DWH_COMMON_DBX_DATA}.monat_1
-- WHERE akt_mo < ${VIS_BESTAND_AKT_MO_VON}
--)
--;
--
--Comment from validation checker
--error line 3 at position 1 unexpected 'SELECT'.
--( ^^^> SELECT kjmo
--translated statement
DELETE FROM DBP_MSI_DATA.vis_tag_bestand_wg_1

WHERE kjmo IN
(SELECT kjmo
 FROM DBP_DATA.monat_1
 WHERE akt_mo < ${VIS_BESTAND_AKT_MO_VON}
)
;

