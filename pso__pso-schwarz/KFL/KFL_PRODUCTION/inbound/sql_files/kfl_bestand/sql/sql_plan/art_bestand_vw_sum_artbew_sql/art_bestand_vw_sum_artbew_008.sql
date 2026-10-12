--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.art_bestand_vw_sum_artbew_tmp
(
  mandant_id, 
  wup_id, 
  nb_id, 
  art_id, 
  gp_id, 
  wrg_id, 
  relevant_fg, 
  bezugsweg_id, 
  dat, 
  menge_abgang_bme,
  herkunft
)
SELECT 
  m.mandant_id, 
  m.wup_id, 
  m.nb_id, 
  m.art_id, 
  a.gp_id, 
  a.wrg AS wrg_id, 
  m.relevant_fg, 
  m.bezugsweg_id, 
  d.dat, 
  a.menge AS menge_abgang_bme,
  'm' AS herkunft 
FROM DBP_DATA.marktbestand_erp m,
  DBP_DATA.artbew a,
  DBP_ETL.art_bestand_vw_sum_artbew_dat d
WHERE m.mandant_id = a.mandant_id 
  AND m.mandant_id = d.mandant_id 
  AND d.dat = m.dat
  AND a.dat = d.dat 
  AND m.wup_id = a.wup_id 
  AND m.nb_id = a.nb_id
  AND m.art_id = a.art_id 
  AND a.bezugsweg_id IN (1, 4) 
  AND a.mandant_id = 1
  AND m.bezugsweg_id IN (1, 4) 
  AND a.bezugsweg_id = m.bezugsweg_id 
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.art_bestand_vw_sum_artbew_tmp
(
  mandant_id, 
  wup_id, 
  nb_id, 
  art_id, 
  gp_id, 
  wrg_id, 
  relevant_fg, 
  bezugsweg_id, 
  dat, 
  menge_abgang_bme, 
  herkunft
)
SELECT 
  a.mandant_id, 
  a.wup_id, 
  a.nb_id, 
  a.art_id, 
  a.gp_id, 
  a.wrg_id, 
  a.relevant_fg, 
  a.bezugsweg_id, 
  a.dat, 
  a.menge_abgang_bme, 
  'a' AS herkunft 
FROM 
(
  SELECT 
    a.mandant_id, 
    a.wup_id, 
    a.nb_id, 
    a.art_id, 
    a.gp_id, 
    a.wrg AS wrg_id, 
    -1 AS relevant_fg, 
    a.bezugsweg_id, 
    d.dat, 
    a.menge AS menge_abgang_bme
  FROM DBP_DATA.artbew a,
    DBP_ETL.art_bestand_vw_sum_artbew_dat d
  WHERE a.mandant_id = d.mandant_id 
    AND a.dat = d.dat 
    AND a.bezugsweg_id IN (1, 4) 
    AND a.mandant_id = 1
) a

LEFT OUTER JOIN DBP_ETL.art_bestand_vw_sum_artbew_tmp m
ON m.mandant_id = a.mandant_id 
  AND m.dat = a.dat 
  AND m.wup_id = a.wup_id 
  AND m.nb_id = a.nb_id
  AND m.art_id = a.art_id 
  AND a.bezugsweg_id = m.bezugsweg_id 
  
WHERE m.mandant_id IS NULL 
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.art_bestand_vw_sum_artbew_tmp2
(
  mandant_id, 
  wup_id, 
  nb_id, 
  art_id, 
  gp_id, 
  vw_id, 
  relevant_fg, 
  bezugsweg_id, 
  dat, 
  wrg_id, 
  menge_abgang_bme,
  herkunft
)
SELECT
   t.mandant_id
  ,(CASE WHEN t.bezugsweg_id = 1 THEN -1 
         WHEN t.bezugsweg_id = 4 THEN (CASE WHEN wgfz.wg_id IS NOT NULL  THEN 6907 /*Nonfood*/
                                            ELSE 6906 /*Food*/
                                       END) 
         ELSE t.wup_id 
   END) AS wup_id_neu
  ,CASE WHEN wup_id_neu = -1 THEN -1 ELSE -111 END AS nb_id_neu
  ,t.art_id
  ,t.gp_id
  ,w.vw_id
  ,t.relevant_fg
  ,t.bezugsweg_id
  ,t.dat
  ,t.wrg_id
  ,SUM(t.menge_abgang_bme)
  ,herkunft
FROM DBP_ETL.art_bestand_vw_sum_artbew_tmp t

INNER JOIN DBP_DATA.wup w 
ON t.mandant_id = w.mandant_id 
  AND t.wup_id = w.wup_id 
  AND t.nb_id = w.nb_id 

INNER JOIN DBP_DATA.art_wg_zu_per awg
ON awg.mandant_id = t.mandant_id 
  AND awg.art_id = t.art_id 
  AND t.dat BETWEEN awg.dat_von AND awg.dat_bis 
  AND awg.arthiertyp_id = 2
  
LEFT JOIN DBP_DATA.wg_filter_zu AS wgfz
  ON wgfz.mandant_id    = awg.mandant_id
 AND wgfz.arthiertyp_id = awg.arthiertyp_id
 AND wgfz.wg_id         = awg.wg_id
 AND wgfz.wg_filter_id  = 20
  
WHERE t.mandant_id = 1
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBP_ETL.art_bestand_vw_sum_tmp 
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
--  ,menge_abgang_bme
--  ,herkunft 
--) 
--SELECT 
--   d.mandant_id
--  ,d.vw_id
--  ,d.bezugsweg_id
--  ,d.lagerbestand_fg
--  ,d.nb_id
--  ,d.art_id
--  ,d.wup_id
--  ,d.dat
--  ,d.gp_id
--  ,d.relevant_fg
--  ,d.wrg_id
--  ,d.menge_lgbest_erp_frei_bme
--  ,d.menge_lgbest_erp_gesamt_bme
--  ,d.menge_lgbest_erp_qual_bme
--  ,d.betrag_vk_netto_frei_bme
--  ,d.betrag_vk_netto_gesamt_bme
--  ,d.betrag_vk_netto_qual_bme
--  ,t.menge_abgang_bme 
--  ,t.herkunft
--FROM DBP_DATA.art_bestand_vw_sum d
--
--INNER JOIN DBP_ETL.art_bestand_vw_sum_artbew_tmp2 t
--ON d.mandant_id = t.mandant_id 
--  AND d.wup_id = t.wup_id 
--  AND d.nb_id = t.nb_id 
--  AND d.art_id = t.art_id 
--  AND d.gp_id = t.gp_id 
--  AND d.vw_id = t.vw_id 
--  AND d.bezugsweg_id = t.bezugsweg_id 
--  AND d.dat = t.dat
--  AND d.wrg_id = t.wrg_id 
--  AND d.relevant_fg = t.relevant_fg
--  
--WHERE d.mandant_id = 1
--  AND d.lagerbestand_fg = 0
--  AND t.herkunft = 'm' /*Herkunft marktbestand_erp_per*/
--;
--
--Comment from validation checker
--error line 21 at position 3
--  , ^^^> herkunft 
--invalid identifier 'HERKUNFT'
--translated statement
INSERT INTO DBP_ETL.art_bestand_vw_sum_tmp 
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
  ,herkunft 
) 
SELECT 
   d.mandant_id
  ,d.vw_id
  ,d.bezugsweg_id
  ,d.lagerbestand_fg
  ,d.nb_id
  ,d.art_id
  ,d.wup_id
  ,d.dat
  ,d.gp_id
  ,d.relevant_fg
  ,d.wrg_id
  ,d.menge_lgbest_erp_frei_bme
  ,d.menge_lgbest_erp_gesamt_bme
  ,d.menge_lgbest_erp_qual_bme
  ,d.betrag_vk_netto_frei_bme
  ,d.betrag_vk_netto_gesamt_bme
  ,d.betrag_vk_netto_qual_bme
  ,t.menge_abgang_bme 
  ,t.herkunft
FROM DBP_DATA.art_bestand_vw_sum d

INNER JOIN DBP_ETL.art_bestand_vw_sum_artbew_tmp2 t
ON d.mandant_id = t.mandant_id 
  AND d.wup_id = t.wup_id 
  AND d.nb_id = t.nb_id 
  AND d.art_id = t.art_id 
  AND d.gp_id = t.gp_id 
  AND d.vw_id = t.vw_id 
  AND d.bezugsweg_id = t.bezugsweg_id 
  AND d.dat = t.dat
  AND d.wrg_id = t.wrg_id 
  AND d.relevant_fg = t.relevant_fg
  
WHERE d.mandant_id = 1
  AND d.lagerbestand_fg = 0
  AND t.herkunft = 'm' /*Herkunft marktbestand_erp_per*/
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBP_ETL.art_bestand_vw_sum_artbew_tmp2 v
--WHERE DBP_ETL.art_bestand_vw_sum_tmp.mandant_id   = v.mandant_id 
--  AND DBP_ETL.art_bestand_vw_sum_tmp.vw_id        = v.vw_id
--  AND DBP_ETL.art_bestand_vw_sum_tmp.bezugsweg_id = v.bezugsweg_id
--  AND DBP_ETL.art_bestand_vw_sum_tmp.nb_id        = v.nb_id
--  AND DBP_ETL.art_bestand_vw_sum_tmp.art_id       = v.art_id
--  AND DBP_ETL.art_bestand_vw_sum_tmp.wup_id       = v.wup_id
--  AND DBP_ETL.art_bestand_vw_sum_tmp.gp_id        = v.gp_id
--  AND DBP_ETL.art_bestand_vw_sum_tmp.relevant_fg  = v.relevant_fg
--  AND DBP_ETL.art_bestand_vw_sum_tmp.wrg_id       = v.wrg_id
--  AND DBP_ETL.art_bestand_vw_sum_tmp.dat          = v.dat
--  AND v.mandant_id = 1
--  AND v.herkunft   = 'm'
--;
--
--Comment from validation checker
--error line 2 at position 6
--WHERE  ^^^> DBP_ETL.art_bestand_vw_sum_tmp.mandant_id   = v.mandant_id 
--invalid identifier 'DBP_ETL.ART_BESTAND_VW_SUM_TMP.MANDANT_ID'
--translated statement
DELETE FROM DBP_ETL.art_bestand_vw_sum_artbew_tmp2 v
using DBP_ETL.art_bestand_vw_sum_tmp
WHERE DBP_ETL.art_bestand_vw_sum_tmp.mandant_id   = v.mandant_id 
  AND DBP_ETL.art_bestand_vw_sum_tmp.vw_id        = v.vw_id
  AND DBP_ETL.art_bestand_vw_sum_tmp.bezugsweg_id = v.bezugsweg_id
  AND DBP_ETL.art_bestand_vw_sum_tmp.nb_id        = v.nb_id
  AND DBP_ETL.art_bestand_vw_sum_tmp.art_id       = v.art_id
  AND DBP_ETL.art_bestand_vw_sum_tmp.wup_id       = v.wup_id
  AND DBP_ETL.art_bestand_vw_sum_tmp.gp_id        = v.gp_id
  AND DBP_ETL.art_bestand_vw_sum_tmp.relevant_fg  = v.relevant_fg
  AND DBP_ETL.art_bestand_vw_sum_tmp.wrg_id       = v.wrg_id
  AND DBP_ETL.art_bestand_vw_sum_tmp.dat          = v.dat
  AND v.mandant_id = 1
  AND v.herkunft   = 'm'
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : CSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS UNBOUNDED PRECEDING). QUALIFY CSUM(1, expr) is probably equivalent of ROW_NUMBER.
--original statement
--INSERT INTO DBP_ETL.art_bestand_vw_sum_tmp 
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
--  ,menge_abgang_bme
--  ,herkunft
--) 
--SELECT 
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
--  ,menge_abgang_bme 
--  ,herkunft
--FROM 
--(
--  SELECT 
--     d.mandant_id
--    ,d.vw_id
--    ,d.bezugsweg_id
--    ,d.lagerbestand_fg
--    ,d.nb_id
--    ,d.art_id
--    ,d.wup_id
--    ,t.dat
--    ,d.dat AS csum_dat 
--    ,d.gp_id
--    ,d.relevant_fg
--    ,d.wrg_id
--    ,0 AS menge_lgbest_erp_frei_bme
--    ,0 AS menge_lgbest_erp_gesamt_bme
--    ,0 AS menge_lgbest_erp_qual_bme
--    ,0 AS betrag_vk_netto_frei_bme
--    ,0 AS betrag_vk_netto_gesamt_bme
--    ,0 AS betrag_vk_netto_qual_bme 
--    ,t.menge_abgang_bme 
--    ,t.herkunft
--  FROM DBP_ETL.art_bestand_vw_sum_artbew_tmp2 t
--  
--  INNER JOIN DBP_DATA.art_bestand_vw_sum d     
--  ON d.mandant_id = t.mandant_id 
--    AND d.wup_id = t.wup_id 
--    AND d.nb_id = t.nb_id 
--    AND d.art_id = t.art_id 
--    AND d.gp_id = t.gp_id 
--    AND d.vw_id = t.vw_id 
--    AND d.bezugsweg_id = t.bezugsweg_id 
--    AND d.relevant_fg = t.relevant_fg 
--    AND d.dat <= t.dat                           
--    AND d.wrg_id = t.wrg_id 
--    AND d.mandant_id = 1
--    AND d.lagerbestand_fg = 0
--   
--  WHERE t.mandant_id = 1
--    AND t.herkunft = 'm' /*Herkunft marktbestand_erp_per*/                     
--)  a
--GROUP BY 
--   mandant_id
--  ,vw_id
--  ,bezugsweg_id
--  ,lagerbestand_fg
--  ,nb_id
--  ,art_id
--  ,wup_id
--  ,gp_id
--  ,relevant_fg
--  ,wrg_id
--  ,dat
--QUALIFY CSUM (1, csum_dat DESC) = 1        
--;
--
--Comment from validation checker
--error line 97 at position 26 unexpected 'DESC'.
--QUALIFY CSUM (1, csum_dat  ^^^> DESC) = 1        
--translated statement
INSERT INTO DBP_ETL.art_bestand_vw_sum_tmp 
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
  ,herkunft
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
  ,herkunft
FROM 
(
  SELECT 
     d.mandant_id
    ,d.vw_id
    ,d.bezugsweg_id
    ,d.lagerbestand_fg
    ,d.nb_id
    ,d.art_id
    ,d.wup_id
    ,t.dat
    ,d.dat AS csum_dat 
    ,d.gp_id
    ,d.relevant_fg
    ,d.wrg_id
    ,0 AS menge_lgbest_erp_frei_bme
    ,0 AS menge_lgbest_erp_gesamt_bme
    ,0 AS menge_lgbest_erp_qual_bme
    ,0 AS betrag_vk_netto_frei_bme
    ,0 AS betrag_vk_netto_gesamt_bme
    ,0 AS betrag_vk_netto_qual_bme 
    ,t.menge_abgang_bme 
    ,t.herkunft
  FROM DBP_ETL.art_bestand_vw_sum_artbew_tmp2 t
  
  INNER JOIN DBP_DATA.art_bestand_vw_sum d     
  ON d.mandant_id = t.mandant_id 
    AND d.wup_id = t.wup_id 
    AND d.nb_id = t.nb_id 
    AND d.art_id = t.art_id 
    AND d.gp_id = t.gp_id 
    AND d.vw_id = t.vw_id 
    AND d.bezugsweg_id = t.bezugsweg_id 
    AND d.relevant_fg = t.relevant_fg 
    AND d.dat <= t.dat                           
    AND d.wrg_id = t.wrg_id 
    AND d.mandant_id = 1
    AND d.lagerbestand_fg = 0
   
  WHERE t.mandant_id = 1
    AND t.herkunft = 'm' /*Herkunft marktbestand_erp_per*/                     
)  a


QUALIFY row_number() over (PARTITION BY mandant_id,vw_id  ,bezugsweg_id  ,lagerbestand_fg  ,nb_id  ,art_id  ,wup_id  ,gp_id  ,relevant_fg,wrg_id  ,dat order by csum_dat DESC) = 1  
        
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : CSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS UNBOUNDED PRECEDING). QUALIFY CSUM(1, expr) is probably equivalent of ROW_NUMBER.
--original statement
--INSERT INTO DBP_ETL.art_bestand_vw_sum_tmp 
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
--  ,menge_abgang_bme
--  ,herkunft
--) 
--SELECT 
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
--  ,menge_abgang_bme 
--  ,herkunft
--FROM 
--(
--  SELECT 
--     d.mandant_id
--    ,d.vw_id
--    ,d.bezugsweg_id
--    ,d.lagerbestand_fg
--    ,d.nb_id
--    ,d.art_id
--    ,d.wup_id
--    ,t.dat
--    ,d.dat AS csum_dat
--    ,d.gp_id
--    ,d.relevant_fg
--    ,d.wrg_id
--    ,0 AS menge_lgbest_erp_frei_bme
--    ,0 AS menge_lgbest_erp_gesamt_bme
--    ,0 AS menge_lgbest_erp_qual_bme 
--    ,0 AS betrag_vk_netto_frei_bme
--    ,0 AS betrag_vk_netto_gesamt_bme
--    ,0 AS betrag_vk_netto_qual_bme 
--    ,t.menge_abgang_bme 
--    ,t.herkunft
--  FROM DBP_ETL.art_bestand_vw_sum_artbew_tmp2 t
--  
--  INNER JOIN DBP_DATA.art_bestand_vw_sum d     
--  ON d.mandant_id = t.mandant_id 
--    AND d.wup_id = t.wup_id 
--    AND d.nb_id = t.nb_id 
--    AND d.art_id = t.art_id 
--    AND d.gp_id = t.gp_id 
--    AND d.vw_id = t.vw_id 
--    AND d.bezugsweg_id = t.bezugsweg_id 
--    AND d.dat <= t.dat
--    AND d.wrg_id = t.wrg_id 
--    
--  WHERE d.mandant_id = 1
--    AND d.lagerbestand_fg = 0 
--    AND t.herkunft = 'a' /*Herkunft artbew*/
--)  a
--GROUP BY 
--   mandant_id
--  ,vw_id
--  ,bezugsweg_id
--  ,lagerbestand_fg
--  ,nb_id
--  ,art_id
--  ,wup_id
--  ,gp_id
--  ,wrg_id
--  ,dat
--QUALIFY CSUM (1, csum_dat DESC, relevant_fg ASC) = 1
--;
--
--Comment from validation checker
--error line 94 at position 26 unexpected 'DESC'.
--QUALIFY CSUM (1, csum_dat  ^^^> DESC, relevant_fg ASC) = 1
--syntax error line 94 at position 44 unexpected 'ASC'.
--QUALIFY CSUM (1, csum_dat DESC, relevant_fg  ^^^> ASC) = 1
--translated statement
INSERT INTO DBP_ETL.art_bestand_vw_sum_tmp 
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
  ,herkunft
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
  ,herkunft
FROM 
(
  SELECT 
     d.mandant_id
    ,d.vw_id
    ,d.bezugsweg_id
    ,d.lagerbestand_fg
    ,d.nb_id
    ,d.art_id
    ,d.wup_id
    ,t.dat
    ,d.dat AS csum_dat
    ,d.gp_id
    ,d.relevant_fg
    ,d.wrg_id
    ,0 AS menge_lgbest_erp_frei_bme
    ,0 AS menge_lgbest_erp_gesamt_bme
    ,0 AS menge_lgbest_erp_qual_bme 
    ,0 AS betrag_vk_netto_frei_bme
    ,0 AS betrag_vk_netto_gesamt_bme
    ,0 AS betrag_vk_netto_qual_bme 
    ,t.menge_abgang_bme 
    ,t.herkunft
  FROM DBP_ETL.art_bestand_vw_sum_artbew_tmp2 t
  
  INNER JOIN DBP_DATA.art_bestand_vw_sum d     
  ON d.mandant_id = t.mandant_id 
    AND d.wup_id = t.wup_id 
    AND d.nb_id = t.nb_id 
    AND d.art_id = t.art_id 
    AND d.gp_id = t.gp_id 
    AND d.vw_id = t.vw_id 
    AND d.bezugsweg_id = t.bezugsweg_id 
    AND d.dat <= t.dat
    AND d.wrg_id = t.wrg_id 
    
  WHERE d.mandant_id = 1
    AND d.lagerbestand_fg = 0 
    AND t.herkunft = 'a' /*Herkunft artbew*/
)  a

QUALIFY row_number() over (PARTITION BY mandant_id,vw_id  ,bezugsweg_id  ,lagerbestand_fg  ,nb_id  ,art_id  ,wup_id  ,gp_id  ,wrg_id  ,dat order by csum_dat DESC) = 1  
        
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.art_bestand_vw_sum_tmp2
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
  ,SUM(menge_lgbest_erp_frei_bme)
  ,SUM(menge_lgbest_erp_gesamt_bme)
  ,SUM(menge_lgbest_erp_qual_bme)
  ,SUM(betrag_vk_netto_frei_bme)
  ,SUM(betrag_vk_netto_gesamt_bme)
  ,SUM(betrag_vk_netto_qual_bme)
  ,SUM(menge_abgang_bme)
FROM DBP_ETL.art_bestand_vw_sum_tmp
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBP_DATA.art_bestand_vw_sum
--WHERE DBP_DATA.art_bestand_vw_sum.mandant_id = DBP_ETL.art_bestand_vw_sum_tmp2.mandant_id 
--  AND DBP_DATA.art_bestand_vw_sum.vw_id = DBP_ETL.art_bestand_vw_sum_tmp2.vw_id
--  AND DBP_DATA.art_bestand_vw_sum.bezugsweg_id = DBP_ETL.art_bestand_vw_sum_tmp2.bezugsweg_id 
--  AND DBP_DATA.art_bestand_vw_sum.lagerbestand_fg = DBP_ETL.art_bestand_vw_sum_tmp2.lagerbestand_fg
--  AND DBP_DATA.art_bestand_vw_sum.nb_id = DBP_ETL.art_bestand_vw_sum_tmp2.nb_id
--  AND DBP_DATA.art_bestand_vw_sum.art_id = DBP_ETL.art_bestand_vw_sum_tmp2.art_id 
--  AND DBP_DATA.art_bestand_vw_sum.wup_id = DBP_ETL.art_bestand_vw_sum_tmp2.wup_id 
--  AND DBP_DATA.art_bestand_vw_sum.dat = DBP_ETL.art_bestand_vw_sum_tmp2.dat
--  AND DBP_DATA.art_bestand_vw_sum.gp_id = DBP_ETL.art_bestand_vw_sum_tmp2.gp_id 
--  AND DBP_DATA.art_bestand_vw_sum.relevant_fg = DBP_ETL.art_bestand_vw_sum_tmp2.relevant_fg 
--  AND DBP_DATA.art_bestand_vw_sum.wrg_id = DBP_ETL.art_bestand_vw_sum_tmp2.wrg_id
--;
--
--Comment from validation checker
--error line 2 at position 47
--WHERE DBP_DATA.art_bestand_vw_sum.mandant_id =  ^^^> DBP_ETL.art_bestand_vw_sum_tmp2.mandant_id 
--invalid identifier 'DBP_ETL.ART_BESTAND_VW_SUM_TMP2.MANDANT_ID'
--translated statement
DELETE FROM DBP_DATA.art_bestand_vw_sum
using DBP_ETL.art_bestand_vw_sum_tmp2
WHERE DBP_DATA.art_bestand_vw_sum.mandant_id = DBP_ETL.art_bestand_vw_sum_tmp2.mandant_id 
  AND DBP_DATA.art_bestand_vw_sum.vw_id = DBP_ETL.art_bestand_vw_sum_tmp2.vw_id
  AND DBP_DATA.art_bestand_vw_sum.bezugsweg_id = DBP_ETL.art_bestand_vw_sum_tmp2.bezugsweg_id 
  AND DBP_DATA.art_bestand_vw_sum.lagerbestand_fg = DBP_ETL.art_bestand_vw_sum_tmp2.lagerbestand_fg
  AND DBP_DATA.art_bestand_vw_sum.nb_id = DBP_ETL.art_bestand_vw_sum_tmp2.nb_id
  AND DBP_DATA.art_bestand_vw_sum.art_id = DBP_ETL.art_bestand_vw_sum_tmp2.art_id 
  AND DBP_DATA.art_bestand_vw_sum.wup_id = DBP_ETL.art_bestand_vw_sum_tmp2.wup_id 
  AND DBP_DATA.art_bestand_vw_sum.dat = DBP_ETL.art_bestand_vw_sum_tmp2.dat
  AND DBP_DATA.art_bestand_vw_sum.gp_id = DBP_ETL.art_bestand_vw_sum_tmp2.gp_id 
  AND DBP_DATA.art_bestand_vw_sum.relevant_fg = DBP_ETL.art_bestand_vw_sum_tmp2.relevant_fg 
  AND DBP_DATA.art_bestand_vw_sum.wrg_id = DBP_ETL.art_bestand_vw_sum_tmp2.wrg_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.art_bestand_vw_sum
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
FROM DBP_ETL.art_bestand_vw_sum_tmp2 
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_bestand_vw_sum_artbew_tmp;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_bestand_vw_sum_artbew_tmp2;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_bestand_vw_sum_tmp;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_bestand_vw_sum_tmp2;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.art_bestand_vw_sum_artbew_dat;

