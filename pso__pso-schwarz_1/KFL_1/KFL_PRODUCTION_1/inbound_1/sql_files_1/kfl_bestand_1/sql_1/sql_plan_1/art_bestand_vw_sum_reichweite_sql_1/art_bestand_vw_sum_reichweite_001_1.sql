--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_bestand_vw_sum_rw_tmp_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.art_bestand_vw_sum_rw_tmp_1  (
  mandant_id BYTEINT NOT NULL 
  ,vw_id BYTEINT NOT NULL 
  ,bezugsweg_id BYTEINT NOT NULL 
  ,lagerbestand_fg BYTEINT NOT NULL 
  ,nb_id SMALLINT NOT NULL 
  ,art_id INTEGER NOT NULL
  ,wup_id INTEGER NOT NULL
  ,dat DATE NOT NULL
  ,gp_id INTEGER NOT NULL
  ,relevant_fg BYTEINT NOT NULL 
  ,wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' 
  ,menge_lgbest_erp_frei_bme DECIMAL(18,3) NOT NULL
  ,menge_lgbest_erp_gesamt_bme DECIMAL(18,3) NOT NULL
  ,menge_lgbest_erp_qual_bme DECIMAL(18,3) NOT NULL
  ,betrag_vk_netto_frei_bme DECIMAL(18,4)
  ,betrag_vk_netto_gesamt_bme DECIMAL(18,4)
  ,betrag_vk_netto_qual_bme DECIMAL(18,4)
  ,menge_abgang_bme DECIMAL(18,3) )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.art_bestand_vw_sum_rw_tmp_1
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
   tmp.mandant_id
  ,tmp.vw_id
  ,4 AS bezugsweg_id
  ,1 AS lagerbestand_fg
  ,tmp.nb_id
  ,tmp.art_id
  ,tmp.wup_id
  ,tmp.dat_buch
  ,tmp.gp_id
  ,1 AS relevant_fg
  ,tmp.wrg_id
  ,COALESCE(t03.menge_lgbest_erp_frei_bme, 0) AS menge_lgbest_erp_frei_bme
  ,COALESCE(t03.menge_lgbest_erp_gesamt_bme, 0) AS menge_lgbest_erp_gesamt_bme
  ,COALESCE(t03.menge_lgbest_erp_qual_bme, 0) AS menge_lgbest_erp_qual_bme 
  ,CASE WHEN t03.mandant_id IS NOT NULL THEN t03.betrag_vk_netto_frei_bme END AS betrag_vk_netto_frei_bme
  ,CASE WHEN t03.mandant_id IS NOT NULL THEN t03.betrag_vk_netto_gesamt_bme END AS betrag_vk_netto_gesamt_bme
  ,CASE WHEN t03.mandant_id IS NOT NULL THEN t03.betrag_vk_netto_qual_bme END AS betrag_vk_netto_qual_bme 
  ,tmp.menge_abgang_bme
FROM 
(
  SELECT
     t01.mandant_id
    ,w.vw_id
    ,t01.nb_id
    ,t02.art_id
    ,t01.wup_id
    ,t01.dat_buch
    ,ag.gp_id
    ,t02.wrg_id
    ,SUM(t02.menge_lagerbew_bme * -1) AS menge_abgang_bme
  FROM DBP_ETL.mseg_reichweite_1 AS t01
  
  INNER JOIN DBP_DATA.wup_1 AS w
  ON t01.mandant_id = w.mandant_id
    AND t01.wup_id = w.wup_id
    AND t01.nb_id = w.nb_id
  
  INNER JOIN DBP_DATA.lagerbew_det_1 AS t02
  ON t01.mandant_id = t02.mandant_id
    AND t01.dat_buch = t02.dat_buch
    AND t01.wup_id = t02.wup_id
    AND t01.nb_id = t02.nb_id
  
  INNER JOIN
  (
    SELECT ag.mandant_id, ag.art_id, ag.gp_id, ag.dat_von, ag.dat_bis
    FROM DBP_DATA.art_gp_zu_per_1 ag
  
    INNER JOIN
    (
      SELECT mandant_id, gp_id, einkaufsorganisation_id
      FROM DBP_DATA.gp_1
      QUALIFY ROW_NUMBER() OVER (PARTITION BY mandant_id, gp_id ORDER BY einkaufsorganisation_id ASC) = 1
    ) g
    ON g.gp_id = ag.gp_id
      AND g.einkaufsorganisation_id = ag.einkaufsorganisation_id
      AND g.mandant_id = ag.mandant_id
  ) AS ag
  ON t02.art_id = ag.art_id
    AND t02.mandant_id = ag.mandant_id
    AND t02.dat_buch BETWEEN ag.dat_von AND ag.dat_bis
  
  WHERE TRIM(t02.lagerort_id) IN ('0', '1', '2', '3', '4', '6', '7', 'W2', 'KL0', 'KL1', 'KL2', 'KL3', 'KL4', 'KL6', 'KL7') -- Hr. Ferber 2008.09.25
    AND t02.lager_bewart_id IN ('641', '643', '645', '651', '945', 'Z46', 'Z48')
  
  GROUP BY t01.mandant_id
    ,w.vw_id
    ,t01.nb_id
    ,t02.art_id
    ,t01.wup_id
    ,t01.dat_buch
    ,ag.gp_id
    ,t02.wrg_id
) tmp

LEFT OUTER JOIN DBP_DATA.art_bestand_vw_sum_1 t03
ON tmp.mandant_id = t03.mandant_id
  AND tmp.dat_buch = t03.dat
  AND tmp.wup_id = t03.wup_id
  AND tmp.nb_id = t03.nb_id
  AND tmp.art_id = t03.art_id
  AND tmp.gp_id = t03.gp_id
  AND t03.lagerbestand_fg = 1
;

DELETE FROM DBP_DATA.art_bestand_vw_sum_1
using DBP_ETL.art_bestand_vw_sum_rw_tmp_1
WHERE DBP_DATA.art_bestand_vw_sum.mandant_id = DBP_ETL.art_bestand_vw_sum_rw_tmp.mandant_id
  AND DBP_DATA.art_bestand_vw_sum.dat = DBP_ETL.art_bestand_vw_sum_rw_tmp.dat
  AND DBP_DATA.art_bestand_vw_sum.wup_id = DBP_ETL.art_bestand_vw_sum_rw_tmp.wup_id
  AND DBP_DATA.art_bestand_vw_sum.nb_id = DBP_ETL.art_bestand_vw_sum_rw_tmp.nb_id
  AND DBP_DATA.art_bestand_vw_sum.vw_id = DBP_ETL.art_bestand_vw_sum_rw_tmp.vw_id
  AND DBP_DATA.art_bestand_vw_sum.art_id = DBP_ETL.art_bestand_vw_sum_rw_tmp.art_id
  AND DBP_DATA.art_bestand_vw_sum.bezugsweg_id = DBP_ETL.art_bestand_vw_sum_rw_tmp.bezugsweg_id
  AND DBP_DATA.art_bestand_vw_sum.relevant_fg = DBP_ETL.art_bestand_vw_sum_rw_tmp.relevant_fg
  AND DBP_DATA.art_bestand_vw_sum.lagerbestand_fg = DBP_ETL.art_bestand_vw_sum_rw_tmp.lagerbestand_fg
  AND DBP_DATA.art_bestand_vw_sum.gp_id = DBP_ETL.art_bestand_vw_sum_rw_tmp.gp_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.art_bestand_vw_sum_1
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
FROM DBP_ETL.art_bestand_vw_sum_rw_tmp_1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_bestand_vw_sum_rw_tmp_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.mseg_reichweite_1;


