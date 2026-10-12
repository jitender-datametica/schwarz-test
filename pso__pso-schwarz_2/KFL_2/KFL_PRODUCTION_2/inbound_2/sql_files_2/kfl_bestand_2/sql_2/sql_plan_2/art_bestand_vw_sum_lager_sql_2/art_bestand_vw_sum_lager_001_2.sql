--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.lagerbestand_erp_per_tag_tmp_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.lagerbestand_erp_per_tag_tmp2_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_bestand_vw_sum_tmp_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.lager_process_tag_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.lagerbestand_erp_per_tag_tmp_2  (
  wup_id INTEGER NOT NULL ,
  mandant_id BYTEINT NOT NULL ,
  nb_id SMALLINT NOT NULL ,
  art_id INTEGER NOT NULL,
  menge_lgbest_erp_frei_bme DECIMAL(18,3),
  menge_lgbest_erp_gesamt_bme DECIMAL(18,3),
  menge_lgbest_erp_qual_bme DECIMAL(18,3),
  wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
  dat DATE NOT NULL
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.lagerbestand_erp_per_tag_tmp2_2  (
  wup_id INTEGER NOT NULL ,
  mandant_id BYTEINT NOT NULL ,
  nb_id SMALLINT NOT NULL ,
  art_id INTEGER NOT NULL,
  menge_lgbest_erp_frei_bme DECIMAL(18,3),
  menge_lgbest_erp_gesamt_bme DECIMAL(18,3),
  menge_lgbest_erp_qual_bme DECIMAL(18,3),
  wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
  dat DATE NOT NULL,
  wup_id_neu INTEGER,
  nb_id_neu SMALLINT,
  vw_id BYTEINT,
  gp_id INTEGER,
  vk_netto DECIMAL(18,4)
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
CREATE TABLE DBP_ETL.art_bestand_vw_sum_tmp_2  (
  mandant_id BYTEINT NOT NULL ,
  vw_id BYTEINT NOT NULL ,
  bezugsweg_id BYTEINT NOT NULL ,
  lagerbestand_fg BYTEINT NOT NULL ,
  nb_id SMALLINT NOT NULL ,
  art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  dat DATE NOT NULL,
  gp_id INTEGER NOT NULL,
  relevant_fg BYTEINT NOT NULL ,
  wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
  menge_lgbest_erp_frei_bme DECIMAL(18,3) NOT NULL,
  menge_lgbest_erp_gesamt_bme DECIMAL(18,3) NOT NULL,              
  menge_lgbest_erp_qual_bme DECIMAL(18,3) NOT NULL,
  betrag_vk_netto_frei_bme DECIMAL(18,4),
  betrag_vk_netto_gesamt_bme DECIMAL(18,4),
  betrag_vk_netto_qual_bme DECIMAL(18,4),
  menge_abgang_bme DECIMAL(18,3) )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
CREATE TABLE DBP_ETL.lager_process_tag_2  (
  dat DATE NOT NULL,
  verarbeitet_fg BYTEINT
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.lager_process_tag_2 
--(
--  dat,
--  verarbeitet_fg
--)
--SELECT 
--  dat, 
--  1 AS verarbeitet_fg
--FROM ${DWH_COMMON_DBX_DATA}.art_bestand_vw_sum_2
--WHERE lagerbestand_fg = 1
--  AND mandant_id = ${MID}
--GROUP BY dat, verarbeitet_fg
--;
--
--Comment from validation checker
--error line 12 at position 0 unexpected 'GROUP'.
-- ^^^> GROUP BY dat, verarbeitet_fg
--translated statement
INSERT INTO DBP_ETL.lager_process_tag_2 
(
  dat,
  verarbeitet_fg
)
SELECT 
  dat, 
  1 AS verarbeitet_fg
FROM DBP_DATA.art_bestand_vw_sum_2
WHERE lagerbestand_fg = 1
  AND mandant_id = ${MID}
GROUP BY dat, verarbeitet_fg
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.lagerbestand_erp_per_tag_tmp_2
--(
--   mandant_id
--  ,wup_id
--  ,nb_id
--  ,art_id
--  ,menge_lgbest_erp_frei_bme
--  ,menge_lgbest_erp_gesamt_bme
--  ,menge_lgbest_erp_qual_bme
--  ,wrg_id
--  ,dat
--)
--SELECT
--   mandant_id
--  ,wup_id
--  ,nb_id
--  ,art_id
--  ,menge_lgbest_erp_frei_bme AS menge_lgbest_erp_frei_bme
--  ,(menge_lgbest_erp_frei_bme +
--    menge_lgbest_erp_umlag_bme +
--    menge_lgbest_erp_qual_bme +
--    menge_lgbest_erp_nf_charge_bme +
--    menge_lgbest_erp_gesp_bme +
--    menge_lgbest_erp_ret_gesp_bme) AS menge_lgbest_erp_gesamt_bme
--  ,menge_lgbest_erp_qual_bme AS menge_lgbest_erp_qual_bme
--  ,wrg_id
--  ,DATE- ${LOOP_ID} as dat
--FROM ${DWH_COMMON_DBX_DATA}.lagerbestand_erp_per_2 p
--
--WHERE p.mandant_id = ${MID}
--  AND p.nb_id IN (99, -111) -- nur echte Laeger
--  AND TRIM(p.lagerort_id) IN -- Hr. Ferber 2008.09.25 
--    ('0', '1', '2', '3', '4', '6', '7', 'W2', 'KL0', 'KL1', 'KL2', 'KL3', 'KL4', 'KL6', 'KL7')	 
--  AND DATE- ${LOOP_ID} BETWEEN p.dat_von AND dat_bis 
--;
--
--Comment from validation checker
--error line 27 at position 10 unexpected 'as'.
--  ,DATE- $ ^^^> {LOOP_ID} as dat
--syntax error line 31 at position 2 unexpected 'AND'.
--   ^^^> AND p.nb_id IN (99, -111) -- nur echte Laeger
--syntax error line 34 at position 21 unexpected 'BETWEEN'.
--  AND CURRENT_DATE- $ ^^^> {LOOP_ID} BETWEEN p.dat_von AND dat_bis 
--translated statement
INSERT INTO DBP_ETL.lagerbestand_erp_per_tag_tmp_2
(
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,wrg_id
  ,dat
)
SELECT
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,menge_lgbest_erp_frei_bme AS menge_lgbest_erp_frei_bme
  ,(menge_lgbest_erp_frei_bme +
    menge_lgbest_erp_umlag_bme +
    menge_lgbest_erp_qual_bme +
    menge_lgbest_erp_nf_charge_bme +
    menge_lgbest_erp_gesp_bme +
    menge_lgbest_erp_ret_gesp_bme) AS menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme AS menge_lgbest_erp_qual_bme
  ,wrg_id
  ,CURRENT_DATE- ${LOOP_ID} as dat
FROM DBP_DATA.lagerbestand_erp_per_2 p

WHERE p.mandant_id = ${MID}
  AND p.nb_id IN (99, -111) -- nur echte Laeger
  AND TRIM(p.lagerort_id) IN -- Hr. Ferber 2008.09.25 
    ('0', '1', '2', '3', '4', '6', '7', 'W2', 'KL0', 'KL1', 'KL2', 'KL3', 'KL4', 'KL6', 'KL7')	 
  AND CURRENT_DATE- ${LOOP_ID} BETWEEN p.dat_von AND dat_bis 
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : CSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS UNBOUNDED PRECEDING). QUALIFY CSUM(1, expr) is probably equivalent of ROW_NUMBER.
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.lagerbestand_erp_per_tag_tmp2_2
--(
--   mandant_id
--  ,wup_id
--  ,nb_id
--  ,art_id
--  ,menge_lgbest_erp_frei_bme
--  ,menge_lgbest_erp_gesamt_bme
--  ,menge_lgbest_erp_qual_bme
--  ,wrg_id
--  ,dat
--  ,wup_id_neu
--  ,nb_id_neu
--  ,vw_id
--  ,gp_id
--  ,vk_netto
--)
--
--SELECT
--   tmp.mandant_id
--  ,tmp.wup_id
--  ,tmp.nb_id
--  ,tmp.art_id
--  ,tmp.menge_lgbest_erp_frei_bme
--  ,tmp.menge_lgbest_erp_gesamt_bme
--  ,tmp.menge_lgbest_erp_qual_bme
--  ,tmp.wrg_id
--  ,tmp.dat
--  ,(CASE WHEN tmp.wup_id/100 = 69 AND tmp.nb_id IN (99, -111) THEN tmp.wup_id  
--         ELSE (CASE WHEN wgfz.wg_id IS NOT NULL  THEN 6907 /*Nonfood*/
--                    ELSE 6906                              /*Food*/
--               END) 
--   END) AS wup_id_neu
--  ,-111 AS nb_id_neu
--  ,w.vw_id
--  ,ag.gp_id 
--  ,CAST(ap.vk_brutto / (CASE WHEN mwst.mwst_id IS NULL THEN 1 ELSE 1+(mwst.mwst/100) END) AS DECIMAL(18,4)) AS vk_netto
--FROM ${DWH_COMMON_DBX_LOAD}.lagerbestand_erp_per_tag_tmp_2 tmp
--
--INNER JOIN ${DWH_COMMON_DBX_DATA}.wup_2 w
--ON w.mandant_id = ${MID}
--  AND tmp.wup_id = w.wup_id 
--  AND tmp.nb_id = w.nb_id 
--  
--INNER JOIN ${DWH_COMMON_DBX_DATA}.art_2 a
--ON a.mandant_id = ${MID}
--  AND tmp.art_id = a.art_id 
--  
--INNER JOIN 
--( 
--  SELECT
--    ag.mandant_id,  
--    ag.art_id,
--    ag.gp_id, 
--    ag.dat_von, 
--    ag.dat_bis
--  FROM ${DWH_COMMON_DBX_DATA}.art_gp_zu_per_2 ag 
--  
--  INNER JOIN 
--  ( 
--    SELECT 
--      gp_id, einkaufsorganisation_id
--    FROM ${DWH_COMMON_DBX_DATA}.gp_2
--    WHERE mandant_id = ${MID}
--    GROUP BY gp_id 
--    QUALIFY CSUM (1, einkaufsorganisation_id ASC) = 1
--  ) g
--  ON g.gp_id = ag.gp_id 
--    AND g.einkaufsorganisation_id = ag.einkaufsorganisation_id 
--  
--  WHERE ag.mandant_id = ${MID}
--)  ag
--ON tmp.art_id = ag.art_id
--AND tmp.dat BETWEEN ag.dat_von AND ag.dat_bis
--
--INNER JOIN ${DWH_COMMON_DBX_DATA}.art_wg_zu_per_2 aw
--ON aw.mandant_id = ${MID}
--  AND aw.arthiertyp_id = 2 
--  AND tmp.art_id = aw.art_id 
--  AND tmp.dat BETWEEN aw.dat_von AND aw.dat_bis 
--  
--LEFT OUTER JOIN ${DWH_COMMON_DBX_DATA}.art_pm_vw_zu_per_2 ap 
--ON ap.preistyp_id = 0 
--  AND ap.pm_id = 1 
--  AND ap.mandant_id = ${MID}
--  AND tmp.art_id = ap.art_id 
--  AND tmp.dat BETWEEN ap.dat_von AND ap.dat_bis 
--  AND w.vw_id = ap.vw_id 
--  
--LEFT OUTER JOIN ${DWH_COMMON_DBX_DATA}.mwst_per_2 mwst 
--ON mwst.mandant_id = ${MID} 
--  AND a.mwst_id = mwst.mwst_id 
--  AND tmp.dat BETWEEN mwst.dat_von AND mwst.dat_bis
--  
--LEFT OUTER JOIN ${DWH_COMMON_DBX_DATA}.wg_filter_zu_2 AS wgfz
--  ON wgfz.wg_id         = aw.wg_id
-- AND wgfz.mandant_id    = aw.mandant_id
-- AND wgfz.arthiertyp_id = aw.arthiertyp_id
-- AND wgfz.wg_filter_id  = 20
--  
--WHERE tmp.mandant_id = ${MID}
--  AND w.vw_id = 6 --SPEC0015717--
--  --AND w.vw_id IN (1,2,3) -- Herr Ferber, 2008.09.25
--;
--
--Comment from validation checker
--error line 41 at position 0 unexpected 'ON'.
-- ^^^> ON w.mandant_id = ${MID}
--translated statement
INSERT INTO DBP_ETL.lagerbestand_erp_per_tag_tmp2_2
(
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,wrg_id
  ,dat
  ,wup_id_neu
  ,nb_id_neu
  ,vw_id
  ,gp_id
  ,vk_netto
)

SELECT
   tmp.mandant_id
  ,tmp.wup_id
  ,tmp.nb_id
  ,tmp.art_id
  ,tmp.menge_lgbest_erp_frei_bme
  ,tmp.menge_lgbest_erp_gesamt_bme
  ,tmp.menge_lgbest_erp_qual_bme
  ,tmp.wrg_id
  ,tmp.dat
  ,(CASE WHEN  cast(tmp.wup_id/100 as int) = 69 AND tmp.nb_id IN (99, -111) THEN tmp.wup_id  
         ELSE (CASE WHEN wgfz.wg_id IS NOT NULL  THEN 6907 /*Nonfood*/
                    ELSE 6906                              /*Food*/
               END) 
   END) AS wup_id_neu
  ,-111 AS nb_id_neu
  ,w.vw_id
  ,ag.gp_id 
  ,CAST(ap.vk_brutto / (CASE WHEN mwst.mwst_id IS NULL THEN 1 ELSE 1+(mwst.mwst/100) END) AS DECIMAL(18,4)) AS vk_netto
FROM DBP_ETL.lagerbestand_erp_per_tag_tmp_2 tmp

INNER JOIN DBP_DATA.wup_2 w
ON w.mandant_id = ${MID}
  AND tmp.wup_id = w.wup_id 
  AND tmp.nb_id = w.nb_id 
  
INNER JOIN DBP_DATA.art_2 a
ON a.mandant_id = ${MID}
  AND tmp.art_id = a.art_id 
  
INNER JOIN 
( 
  SELECT
    ag.mandant_id,  
    ag.art_id,
    ag.gp_id, 
    ag.dat_von, 
    ag.dat_bis
  FROM DBP_DATA.art_gp_zu_per_2 ag 
  
  INNER JOIN 
  ( 
    SELECT 
      gp_id, einkaufsorganisation_id
    FROM DBP_DATA.gp_2
    WHERE mandant_id = ${MID}
    --GROUP BY gp_id 
    --QUALIFY CSUM (1, einkaufsorganisation_id ASC) = 1
    QUALIFY row_number() over (PARTITION BY gp_id order by einkaufsorganisation_id ASC) = 1


  ) g
  ON g.gp_id = ag.gp_id 
    AND g.einkaufsorganisation_id = ag.einkaufsorganisation_id 
  
  WHERE ag.mandant_id = ${MID}
)  ag
ON tmp.art_id = ag.art_id
AND tmp.dat BETWEEN ag.dat_von AND ag.dat_bis

INNER JOIN DBP_DATA.art_wg_zu_per_2 aw
ON aw.mandant_id = ${MID}
  AND aw.arthiertyp_id = 2 
  AND tmp.art_id = aw.art_id 
  AND tmp.dat BETWEEN aw.dat_von AND aw.dat_bis 
  
LEFT OUTER JOIN DBP_DATA.art_pm_vw_zu_per_2 ap 
ON ap.preistyp_id = 0 
  AND ap.pm_id = 1 
  AND ap.mandant_id = ${MID}
  AND tmp.art_id = ap.art_id 
  AND tmp.dat BETWEEN ap.dat_von AND ap.dat_bis 
  AND w.vw_id = ap.vw_id 
  
LEFT OUTER JOIN DBP_DATA.mwst_per_2 mwst 
ON mwst.mandant_id = ${MID} 
  AND a.mwst_id = mwst.mwst_id 
  AND tmp.dat BETWEEN mwst.dat_von AND mwst.dat_bis
  
LEFT OUTER JOIN DBP_DATA.wg_filter_zu_2 AS wgfz
  ON wgfz.wg_id         = aw.wg_id
 AND wgfz.mandant_id    = aw.mandant_id
 AND wgfz.arthiertyp_id = aw.arthiertyp_id
 AND wgfz.wg_filter_id  = 20
  
WHERE tmp.mandant_id = ${MID}
  AND w.vw_id = 6 --SPEC0015717--
  --AND w.vw_id IN (1,2,3) -- Herr Ferber, 2008.09.25
;



--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.art_bestand_vw_sum_tmp_2 
(
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,nb_id
  ,art_id
  ,wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,betrag_vk_netto_frei_bme
  ,betrag_vk_netto_gesamt_bme
  ,betrag_vk_netto_qual_bme
  ,menge_abgang_bme
) 
SELECT
   t01.mandant_id
  ,t01.vw_id
  ,t01.bezugsweg_id
  ,t01.lagerbestand_fg
  ,t01.nb_id_neu
  ,t01.art_id
  ,t01.wup_id_neu
  ,t01.dat
  ,t01.gp_id
  ,t01.relevant_fg
  ,t01.wrg_id
  ,t01.menge_lgbest_erp_frei_bme
  ,t01.menge_lgbest_erp_gesamt_bme
  ,t01.menge_lgbest_erp_qual_bme
  ,t01.betrag_vk_netto_frei_bme
  ,t01.betrag_vk_netto_gesamt_bme
  ,t01.betrag_vk_netto_qual_bme
  ,t02.menge_abgang_bme
FROM 
(
  SELECT
     mandant_id
    ,vw_id
    ,4 AS bezugsweg_id
    ,1 AS lagerbestand_fg
    ,nb_id_neu
    ,art_id
    ,wup_id_neu
    ,dat
    ,gp_id
    ,1 AS relevant_fg
    ,wrg_id
    ,SUM(menge_lgbest_erp_frei_bme) AS menge_lgbest_erp_frei_bme
    ,SUM(menge_lgbest_erp_gesamt_bme) AS menge_lgbest_erp_gesamt_bme
    ,SUM(menge_lgbest_erp_qual_bme) AS menge_lgbest_erp_qual_bme
    ,SUM(vk_netto * menge_lgbest_erp_frei_bme) AS betrag_vk_netto_frei_bme
    ,SUM(vk_netto * menge_lgbest_erp_gesamt_bme) AS betrag_vk_netto_gesamt_bme
    ,SUM(vk_netto * menge_lgbest_erp_qual_bme) AS betrag_vk_netto_qual_bme
  FROM DBP_ETL.lagerbestand_erp_per_tag_tmp2_2
  GROUP BY 
     mandant_id
    ,vw_id
    ,bezugsweg_id
    ,lagerbestand_fg
    ,nb_id_neu
    ,art_id
    ,wup_id_neu
    ,dat
    ,gp_id
    ,relevant_fg
    ,wrg_id
) AS t01

LEFT JOIN DBP_DATA.art_bestand_vw_sum_2 t02
ON t01.mandant_id = t02.mandant_id
  AND t01.wup_id_neu = t02.wup_id
  AND t01.nb_id_neu = t02.nb_id
  AND t01.art_id = t02.art_id
  AND t01.dat = t02.dat
  AND t01.lagerbestand_fg = t02.lagerbestand_fg
  AND t01.bezugsweg_id = t02.bezugsweg_id
  AND t01.vw_id = t02.vw_id
  AND t01.gp_id = t02.gp_id
  AND t01.wrg_id = t02.wrg_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--DROP TABLE IF EXISTS DBP_ETL.lagerbestand_erp_per_tag_tmp2_2;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_DATA}.art_bestand_vw_sum_2
--WHERE ${DWH_COMMON_DBX_DATA}.art_bestand_vw_sum.mandant_id = ${DWH_COMMON_DBX_LOAD}.art_bestand_vw_sum_tmp.mandant_id 
--  AND ${DWH_COMMON_DBX_DATA}.art_bestand_vw_sum.vw_id = ${DWH_COMMON_DBX_LOAD}.art_bestand_vw_sum_tmp.vw_id
--  AND ${DWH_COMMON_DBX_DATA}.art_bestand_vw_sum.bezugsweg_id = ${DWH_COMMON_DBX_LOAD}.art_bestand_vw_sum_tmp.bezugsweg_id 
--  AND ${DWH_COMMON_DBX_DATA}.art_bestand_vw_sum.lagerbestand_fg = ${DWH_COMMON_DBX_LOAD}.art_bestand_vw_sum_tmp.lagerbestand_fg
--  AND ${DWH_COMMON_DBX_DATA}.art_bestand_vw_sum.nb_id = ${DWH_COMMON_DBX_LOAD}.art_bestand_vw_sum_tmp.nb_id 
--  AND ${DWH_COMMON_DBX_DATA}.art_bestand_vw_sum.art_id = ${DWH_COMMON_DBX_LOAD}.art_bestand_vw_sum_tmp.art_id 
--  AND ${DWH_COMMON_DBX_DATA}.art_bestand_vw_sum.wup_id = ${DWH_COMMON_DBX_LOAD}.art_bestand_vw_sum_tmp.wup_id 
--  AND ${DWH_COMMON_DBX_DATA}.art_bestand_vw_sum.dat = ${DWH_COMMON_DBX_LOAD}.art_bestand_vw_sum_tmp.dat
--  AND ${DWH_COMMON_DBX_DATA}.art_bestand_vw_sum.gp_id = ${DWH_COMMON_DBX_LOAD}.art_bestand_vw_sum_tmp.gp_id 
----  Herr Ferber 2008.09.26: Loeschen unabhaengig vom relevant_fg
----  AND ${DWH_COMMON_DBX_DATA}.art_bestand_vw_sum.relevant_fg = ${DWH_COMMON_DBX_LOAD}.art_bestand_vw_sum_tmp.relevant_fg 
--  AND ${DWH_COMMON_DBX_DATA}.art_bestand_vw_sum.wrg_id = ${DWH_COMMON_DBX_LOAD}.art_bestand_vw_sum_tmp.wrg_id
--;
--
--Comment from validation checker
--error line 2 at position 47
--WHERE DBP_DATA.art_bestand_vw_sum.mandant_id =  ^^^> DBP_ETL.art_bestand_vw_sum_tmp.mandant_id 
--invalid identifier 'DBP_ETL.ART_BESTAND_VW_SUM_TMP.MANDANT_ID'
--translated statement
DELETE FROM DBP_DATA.art_bestand_vw_sum_2
using DBP_ETL.art_bestand_vw_sum_tmp_2
WHERE DBP_DATA.art_bestand_vw_sum.mandant_id = DBP_ETL.art_bestand_vw_sum_tmp.mandant_id 
  AND DBP_DATA.art_bestand_vw_sum.vw_id = DBP_ETL.art_bestand_vw_sum_tmp.vw_id
  AND DBP_DATA.art_bestand_vw_sum.bezugsweg_id = DBP_ETL.art_bestand_vw_sum_tmp.bezugsweg_id 
  AND DBP_DATA.art_bestand_vw_sum.lagerbestand_fg = DBP_ETL.art_bestand_vw_sum_tmp.lagerbestand_fg
  AND DBP_DATA.art_bestand_vw_sum.nb_id = DBP_ETL.art_bestand_vw_sum_tmp.nb_id 
  AND DBP_DATA.art_bestand_vw_sum.art_id = DBP_ETL.art_bestand_vw_sum_tmp.art_id 
  AND DBP_DATA.art_bestand_vw_sum.wup_id = DBP_ETL.art_bestand_vw_sum_tmp.wup_id 
  AND DBP_DATA.art_bestand_vw_sum.dat = DBP_ETL.art_bestand_vw_sum_tmp.dat
  AND DBP_DATA.art_bestand_vw_sum.gp_id = DBP_ETL.art_bestand_vw_sum_tmp.gp_id 
--  Herr Ferber 2008.09.26: Loeschen unabhaengig vom relevant_fg
--  AND DBP_DATA.art_bestand_vw_sum.relevant_fg = DBP_ETL.art_bestand_vw_sum_tmp.relevant_fg 
  AND DBP_DATA.art_bestand_vw_sum.wrg_id = DBP_ETL.art_bestand_vw_sum_tmp.wrg_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE 
FROM DBP_ETL.art_bestand_vw_sum_tmp_2 
WHERE COALESCE(menge_lgbest_erp_frei_bme, 0) =  0
  AND COALESCE(menge_lgbest_erp_gesamt_bme, 0) =  0
  AND COALESCE(menge_lgbest_erp_qual_bme, 0) = 0
  AND COALESCE(betrag_vk_netto_frei_bme, 0) =  0
  AND COALESCE(betrag_vk_netto_gesamt_bme, 0) =  0
  AND COALESCE(betrag_vk_netto_qual_bme, 0) = 0
  AND menge_abgang_bme IS NULL
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.art_bestand_vw_sum_2
(
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,nb_id
  ,art_id
  ,wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,betrag_vk_netto_frei_bme
  ,betrag_vk_netto_gesamt_bme
  ,betrag_vk_netto_qual_bme
  ,menge_abgang_bme
) 
SELECT 
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,nb_id
  ,art_id
  ,wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,betrag_vk_netto_frei_bme
  ,betrag_vk_netto_gesamt_bme
  ,betrag_vk_netto_qual_bme
  ,menge_abgang_bme
FROM DBP_ETL.art_bestand_vw_sum_tmp_2 
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.lager_process_tag_2 
(
  dat, 
  verarbeitet_fg
)
SELECT 
  dat, 
  verarbeitet_fg
FROM 
(
  SELECT 
    dat, 
    1 AS verarbeitet_fg 
  FROM DBP_ETL.art_bestand_vw_sum_tmp_2 
  GROUP BY 1, 2
) a
WHERE (dat, verarbeitet_fg) NOT IN 
(
  SELECT 
    dat, 
    verarbeitet_fg
  FROM DBP_ETL.lager_process_tag_2 
);

--[OK] statement is translated correctly (syntax and type checks are fine)
--DROP TABLE IF EXISTS DBP_ETL.art_bestand_vw_sum_tmp_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.lager_process_tag_2
(
  dat,
  verarbeitet_fg 
)
SELECT 
  t.dat,
  0 AS verarbeitet_fg
FROM DBP_DATA.tag_2 t
LEFT OUTER JOIN DBP_ETL.lager_process_tag_2 l
ON  t.dat = l.dat 

WHERE t.dat < CURRENT_DATE -- maximal bis zum Vortag 
  AND t.dat > 
  (SELECT MIN(dat) FROM DBP_ETL.lager_process_tag_2 WHERE verarbeitet_fg = 1) -- Min Verarbeitungsdatum 
  AND l.dat IS NULL -- noch nicht in lager_process_tag_2 Tabelle
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : CSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS UNBOUNDED PRECEDING). QUALIFY CSUM(1, expr) is probably equivalent of ROW_NUMBER.
--original statement
--INSERT INTO ${DWH_COMMON_DBX_DATA}.art_bestand_vw_sum_2
--(
--   mandant_id
--  ,vw_id
--  ,bezugsweg_id
--  ,lagerbestand_fg
--  ,nb_id
--  ,art_id
--  ,wup_id
--  ,dat
--  ,gp_id
--  ,relevant_fg
--  ,wrg_id
--  ,menge_lgbest_erp_frei_bme
--  ,menge_lgbest_erp_gesamt_bme
--  ,menge_lgbest_erp_qual_bme
--  ,betrag_vk_netto_frei_bme
--  ,betrag_vk_netto_gesamt_bme
--  ,betrag_vk_netto_qual_bme
--)
--SELECT 
--   a.mandant_id
--  ,a.vw_id
--  ,a.bezugsweg_id
--  ,a.lagerbestand_fg
--  ,a.nb_id
--  ,a.art_id
--  ,a.wup_id
--  ,l.dat
--  ,a.gp_id
--  ,a.relevant_fg
--  ,a.wrg_id
--  ,a.menge_lgbest_erp_frei_bme
--  ,a.menge_lgbest_erp_gesamt_bme
--  ,a.menge_lgbest_erp_qual_bme
--  ,a.betrag_vk_netto_frei_bme
--  ,a.betrag_vk_netto_gesamt_bme
--  ,a.betrag_vk_netto_qual_bme
--FROM ${DWH_COMMON_DBX_DATA}.art_bestand_vw_sum_2 a
--
--INNER JOIN 
--(
--  -- Ermittlung des maximalen bereits verarbeiteten Tag_2, 
--  -- der kleiner ist als der noch zu verarbeitende Tag.
--  SELECT 
--    l.dat, v.dat AS max_verarbeitet_dat 
--  FROM ${DWH_COMMON_DBX_LOAD}.lager_process_tag_2 l
--  
--  INNER JOIN ${DWH_COMMON_DBX_LOAD}.lager_process_tag_2 v 
--  ON v.verarbeitet_fg = 1 -- bereits verarbeitet
--    AND l.dat > v.dat 
--    
--  WHERE l.verarbeitet_fg = 0 -- noch nicht verarbeitet
--  
--  GROUP BY l.dat
--  QUALIFY CSUM(1, v.dat DESC) = 1
--) l
--ON l.dat >= a.dat
--
--WHERE lagerbestand_fg = 1
--  AND a.mandant_id = ${MID}
--  AND a.dat = max_verarbeitet_dat
--;
--
--Comment from validation checker
--error line 56 at position 24 unexpected 'DESC'.
--  QUALIFY CSUM(1, v.dat  ^^^> DESC) = 1
--syntax error line 62 at position 2 unexpected 'AND'.
--   ^^^> AND a.dat = max_verarbeitet_dat
--translated statement
INSERT INTO DBP_DATA.art_bestand_vw_sum_2
(
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,nb_id
  ,art_id
  ,wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,betrag_vk_netto_frei_bme
  ,betrag_vk_netto_gesamt_bme
  ,betrag_vk_netto_qual_bme
)
SELECT 
   a.mandant_id
  ,a.vw_id
  ,a.bezugsweg_id
  ,a.lagerbestand_fg
  ,a.nb_id
  ,a.art_id
  ,a.wup_id
  ,l.dat
  ,a.gp_id
  ,a.relevant_fg
  ,a.wrg_id
  ,a.menge_lgbest_erp_frei_bme
  ,a.menge_lgbest_erp_gesamt_bme
  ,a.menge_lgbest_erp_qual_bme
  ,a.betrag_vk_netto_frei_bme
  ,a.betrag_vk_netto_gesamt_bme
  ,a.betrag_vk_netto_qual_bme
FROM DBP_DATA.art_bestand_vw_sum_2 a

INNER JOIN 
(
  -- Ermittlung des maximalen bereits verarbeiteten Tag_2, 
  -- der kleiner ist als der noch zu verarbeitende Tag.
  SELECT 
    l.dat, v.dat AS max_verarbeitet_dat 
  FROM DBP_ETL.lager_process_tag_2 l
  
  INNER JOIN DBP_ETL.lager_process_tag_2 v 
  ON v.verarbeitet_fg = 1 -- bereits verarbeitet
    AND l.dat > v.dat 
    
  WHERE l.verarbeitet_fg = 0 -- noch nicht verarbeitet
  
 -- GROUP BY l.dat
  --QUALIFY CSUM(1, v.dat DESC) = 1
  QUALIFY row_number() OVER (PARTITION BY l.dat order by v.dat DESC) = 1
) l
ON l.dat >= a.dat

WHERE lagerbestand_fg = 1
  AND a.mandant_id = ${MID}
  AND a.dat = max_verarbeitet_dat
;


