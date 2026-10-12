--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_bestand_vw_sum_tmp_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.art_bestand_vw_sum_tmp_2  (
  mandant_id BYTEINT NOT NULL  ,
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
  menge_abgang_bme DECIMAL(18,3)  
)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE DBP_ETL.marktbestand_erp_tmp_2

SET vw_id = _vw_id
FROM
(
SELECT
 mandant_id _mandant_id
,wup_id _wup_id
,vw_id _vw_id
FROM DBP_DATA.wup_2
)t1_2 WHERE mandant_id=_mandant_id
AND   wup_id = _wup_id
;

--[OK] statement is translated correctly-----------------------------------------------------------------
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
)
SELECT
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,0 AS lagerbestand_fg
  ,-1 _nb_id
  ,art_id
  ,-1 _wup_id
  ,CURRENT_DATE - ${LOOP_ID} as dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,SUM(menge_lgbest_erp_frei_bme)                                                       AS menge_lgbest_erp_frei_bme
  ,SUM(menge_lgbest_erp_frei_bme + menge_lgbest_erp_qual_bme)                           AS menge_lgbest_erp_gesamt_bme
  ,SUM(menge_lgbest_erp_qual_bme)                                                       AS menge_lgbest_erp_qual_bme
  ,CAST (SUM( CAST (vk_netto * menge_lgbest_erp_frei_bme AS FLOAT)) AS DECIMAL(18,4))   AS betrag_vk_netto_frei_bme
  ,CAST (SUM( CAST (vk_netto * (menge_lgbest_erp_frei_bme + menge_lgbest_erp_qual_bme) AS FLOAT)) AS DECIMAL(18,4)) AS betrag_vk_netto_gesamt_bme
  ,CAST (SUM( CAST (vk_netto * menge_lgbest_erp_qual_bme AS FLOAT)) AS DECIMAL(18,4))   AS betrag_vk_netto_qual_bme
FROM DBP_ETL.marktbestand_erp_tmp_2
WHERE vw_id IS NOT NULL
AND mandant_id NOT IN (1)
GROUP BY
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,_nb_id
  ,art_id
  ,_wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
;

--[OK] statement is translated correctly-----------------------------------------------------------------
UPDATE DBP_ETL.marktbestand_erp_tmp_2

SET gp_id = _gp_id
FROM
(
  SELECT distinct
    ag.mandant_id _mandant_id,  
    ag.art_id _art_id,
    ag.gp_id _gp_id
  FROM DBP_DATA.art_gp_zu_per_2 ag 
  INNER JOIN 
  ( 
    SELECT 
      gp_id, einkaufsorganisation_id
    FROM DBP_DATA.gp_2
    WHERE mandant_id = 1
    --GROUP BY gp_id 
    QUALIFY --CSUM (1, einkaufsorganisation_id ASC) = 1
      ROW_NUMBER() over (PARTITION BY gp_id ORDER BY einkaufsorganisation_id ASC) = 1
  ) g
  ON g.gp_id = ag.gp_id 
    AND g.einkaufsorganisation_id = ag.einkaufsorganisation_id 
  WHERE CURRENT_DATE- ${LOOP_ID} between dat_von and dat_bis
  AND ag.mandant_id=1
)t1_2 WHERE mandant_id=_mandant_id
AND   art_id=_art_id
AND   mandant_id=1
;

--[OK] statement is translated correctly-----------------------------------------------------------------
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
) 
SELECT 
   mandant_id
  ,coalesce(vw_id,6) as vw_id
  ,bezugsweg_id
  ,0 AS lagerbestand_fg
  ,CASE WHEN vz_wup_id = -1 THEN -1 ELSE -111 END AS _nb_id
  ,art_id
  ,vz_wup_id
  ,CURRENT_DATE - ${LOOP_ID} as dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,SUM(menge_lgbest_erp_frei_bme) AS menge_lgbest_erp_frei_bme
  ,SUM(menge_lgbest_erp_frei_bme + menge_lgbest_erp_qual_bme) AS menge_lgbest_erp_gesamt_bme
  ,SUM(menge_lgbest_erp_qual_bme) AS menge_lgbest_erp_qual_bme
  ,SUM(vk_netto * menge_lgbest_erp_frei_bme) AS betrag_vk_netto_frei_bme
  ,SUM(vk_netto * (menge_lgbest_erp_frei_bme + menge_lgbest_erp_qual_bme)) AS betrag_vk_netto_gesamt_bme
  ,SUM(vk_netto * menge_lgbest_erp_qual_bme) AS betrag_vk_netto_qual_bme
FROM DBP_ETL.marktbestand_erp_tmp_2
WHERE bezugsweg_id IN (1,4)
AND mandant_id=1
GROUP BY 
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,_nb_id
  ,art_id
  ,vz_wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
;

create or replace table dbp_etl.art_bestand_vw_sum_tmp2_2 as (
select mandant_id
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
      ,sum(menge_lgbest_erp_frei_bme) as menge_lgbest_erp_frei_bme
      ,sum(menge_lgbest_erp_gesamt_bme) as menge_lgbest_erp_gesamt_bme
      ,sum(menge_lgbest_erp_qual_bme) as menge_lgbest_erp_qual_bme
      ,sum(betrag_vk_netto_frei_bme) as betrag_vk_netto_frei_bme
      ,sum(betrag_vk_netto_gesamt_bme) as betrag_vk_netto_gesamt_bme
      ,sum(betrag_vk_netto_qual_bme) as betrag_vk_netto_qual_bme
      ,sum(menge_abgang_bme) as menge_abgang_bme
from dbp_etl.art_bestand_vw_sum_tmp_2
group by 1,2,3,4,5,6,7,8,9,10,11
);

UPDATE DBP_ETL.art_bestand_vw_sum_tmp2_2
SET menge_abgang_bme = DBP_DATA.art_bestand_vw_sum.menge_abgang_bme
FROM DBP_DATA.art_bestand_vw_sum_2
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

--[OK] statement is translated correctly-----------------------------------------------------------------
DELETE FROM DBP_DATA.art_bestand_vw_sum_2
USING DBP_ETL.art_bestand_vw_sum_tmp2_2
WHERE DBP_DATA.art_bestand_vw_sum.mandant_id = DBP_ETL.art_bestand_vw_sum_tmp2.mandant_id 
  AND DBP_DATA.art_bestand_vw_sum.vw_id = DBP_ETL.art_bestand_vw_sum_tmp2.vw_id
  AND DBP_DATA.art_bestand_vw_sum.bezugsweg_id = DBP_ETL.art_bestand_vw_sum_tmp2.bezugsweg_id 
  AND DBP_DATA.art_bestand_vw_sum.lagerbestand_fg = DBP_ETL.art_bestand_vw_sum_tmp2.lagerbestand_fg
  AND DBP_DATA.art_bestand_vw_sum.nb_id = DBP_ETL.art_bestand_vw_sum_tmp2.nb_id
  AND DBP_DATA.art_bestand_vw_sum.art_id = DBP_ETL.art_bestand_vw_sum_tmp2.art_id 
  AND DBP_DATA.art_bestand_vw_sum.wup_id = DBP_ETL.art_bestand_vw_sum_tmp2.wup_id 
  AND DBP_DATA.art_bestand_vw_sum.dat = DBP_ETL.art_bestand_vw_sum_tmp2.dat
  AND DBP_DATA.art_bestand_vw_sum.gp_id = DBP_ETL.art_bestand_vw_sum_tmp2.gp_id 
--  Herr Ferber 2008.09.26: Loeschen unabhaengig vom relevant_fg
--  AND DBP_DATA.art_bestand_vw_sum.relevant_fg = DBP_ETL.art_bestand_vw_sum_tmp2.relevant_fg 
  AND DBP_DATA.art_bestand_vw_sum.wrg_id = DBP_ETL.art_bestand_vw_sum_tmp2.wrg_id
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE 
FROM DBP_ETL.art_bestand_vw_sum_tmp2_2 
WHERE COALESCE(menge_lgbest_erp_frei_bme, 0) =  0
  AND COALESCE(menge_lgbest_erp_gesamt_bme, 0) =  0
  AND COALESCE(menge_lgbest_erp_qual_bme, 0) = 0
  AND COALESCE(betrag_vk_netto_frei_bme, 0) =  0
  AND COALESCE(betrag_vk_netto_gesamt_bme, 0) =  0
  AND COALESCE(betrag_vk_netto_qual_bme, 0) = 0
  AND COALESCE(menge_abgang_bme, 0) = 0
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
SELECT distinct
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
FROM DBP_ETL.art_bestand_vw_sum_tmp2_2 
;

