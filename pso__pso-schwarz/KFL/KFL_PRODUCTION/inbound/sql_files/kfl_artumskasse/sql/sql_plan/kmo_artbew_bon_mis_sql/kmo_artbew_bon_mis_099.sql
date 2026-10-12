--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.kmo_artbew_wg_sum_tmp;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.kmo_artbew_wg_sum_tmp 
LIKE DBP_DATA.artbew_wg_sum;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.kmo_artbew_bon
WHERE mandant_id = 6 /*Kroatien*/
  AND kl_art_id IN 
  (
     9800130
    ,9800131
    ,9800132
  )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.kmo_artbew_bon
WHERE (mandant_id,lkp_art_id) IN 
(SELECT mandant_id,
        art_id
 FROM DBP_DATA.art_wg_zu_per
 WHERE mandant_id = 7 AND
 arthiertyp_id = 2 AND
 dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
 wg_id = 969 AND
 wug_id = 6
)
;


--translated statement
INSERT INTO DBP_ETL.kmo_artbew_wg_sum_tmp
(
   mandant_id
  ,wup_id
  ,wg_id
  ,bewart_id
  ,dat
  ,nb_id
  ,arthiertyp_id
  ,umsatz_brutto
  ,umsatz_netto
  ,umsatz_wrg
  ,umsatz_brutto_konz
  ,umsatz_netto_konz
  ,kjmo
  ,menge
  ,quelle
)
SELECT
   mandant_id
  ,wup_id
  ,wg_id
  ,1001 AS bewart_id  /*Kassen Direktentsorgung*/
  ,dat
  ,nb_id
  ,arthiertyp_id
  ,SUM(umsatz_brutto)
  ,SUM(umsatz_netto)
  ,umsatz_wrg
  ,SUM(umsatz_brutto_konz)
  ,SUM(umsatz_netto_konz)
  ,kjmo
  ,SUM(menge)
  ,1 AS quelle  /*Kassen Direktentsorgung*/
FROM
(
  SELECT
     l.mandant_id AS mandant_id
    ,l.wup_id AS wup_id
    ,l.lkp_wg_id AS wg_id
    ,l.dat_booking AS dat
    ,l.lkp_nb_id AS nb_id
    ,2 AS arthiertyp_id      /*mue 13.01.2010: Nach Abstimmung mit Hr. Ferber/VIS auf Arthiertyp 2 gesetzt*/
    -- Mai 2011: Promotionswert von Umsatz abziehen (addieren, weil negatives Vorzeichen)
	--,umsatz_brutto_ + umsatz_promotion_brutto_ AS umsatz_brutto  /*Belegbruttoumsatz - Promotionsumsatz = (Brutto)Kassenumsatz*/
	-- (25.09.2017 cdab) Laut A. Wolter sind die Umsätze im KPOS ODS schon Promo bereinigt. Daher sollen die Umsatz im wg_sum ohne Abzug gespeichert werden.
    ,umsatz_brutto_ umsatz_brutto  
    ,CAST(umsatz_brutto / (1+(lkp_mwst/100)) AS DECIMAL(18,4)) AS umsatz_netto
    ,lkp_wrg AS umsatz_wrg
    ,0 AS umsatz_brutto_konz                                -- die Konz Betraege werden in einem folgenden
    ,0 AS umsatz_netto_konz                                 -- Schritt berechnet
    -- bartosiewiczadm - cloud migration
    --,(l.dat_booking / 100) +  190000 AS kjmo
    ,CAST(to_varchar(l.dat_booking, 'YYYYMM') AS INTEGER) AS kjmo
    ,menge_ AS menge
  FROM 
  (
    SELECT 
       mandant_id
      ,wup_id 
      ,lkp_wg_id 
      ,dat_booking      
      ,lkp_posten_id 
      ,lkp_nb_id
      ,lkp_mwst
      ,lkp_wrg
      ,SUM(umsatz_brutto) AS umsatz_brutto_
      ,SUM(umsatz_promotion_brutto) AS umsatz_promotion_brutto_
      ,SUM(menge) AS menge_
    FROM 
    (
      SELECT 
         z.mandant_id
        ,z.bon_id 
        ,z.wup_id 
        ,z.lkp_nb_id
        ,z.lkp_art_id 
        ,z.lkp_posten_id 
        ,z.dat_booking
        ,z.bon_zeile
        ,z.umsatz_brutto
        ,z.menge
        ,z.lkp_mwst
        ,z.lkp_mwst_id
        ,z.lkp_wrg
        ,z.lkp_umrechnungskurs 
        ,COALESCE(promotion_brutto, 0) AS umsatz_promotion_brutto
        ,lkp_wg_id
      FROM DBP_ETL.kmo_artbew_bon z
      
      -- Ermittlung Promotionsbetrag pro Bon Zeile 
      LEFT OUTER JOIN 
      (
        SELECT 
           mandant_id
          ,bon_id
          ,dat_booking
          ,bon_zeile 
          ,SUM(umsatz_brutto) AS promotion_brutto
        FROM DBP_ETL.kmo_artbew_bon_promotion
        
        GROUP BY 1,2,3,4
      ) p
      ON z.mandant_id = p.mandant_id
        AND z.bon_id = p.bon_id
        AND z.dat_booking = p.dat_booking
        AND z.bon_zeile = p.bon_zeile 
    ) z
    GROUP BY 1,2,3,4,5,6,7,8
  ) l
) a
GROUP BY
   mandant_id
  ,wup_id
  ,wg_id
  ,bewart_id
  ,dat
  ,nb_id
  ,arthiertyp_id
  ,umsatz_wrg
  ,kjmo
  ,quelle
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_ETL.kmo_artbew_wg_sum_tmp
FROM DBP_DATA.kurs k

SET umsatz_brutto_konz = CAST(umsatz_brutto * k.umrechnungskurs AS DECIMAL(18,4))
  , umsatz_netto_konz = CAST(umsatz_netto * k.umrechnungskurs AS DECIMAL(18,4))

WHERE DBP_ETL.kmo_artbew_wg_sum_tmp.umsatz_wrg = k.von_wrg_id
  AND DBP_ETL.kmo_artbew_wg_sum_tmp.dat BETWEEN k.dat_von AND k.dat_bis
  AND k.nach_wrg_id = 'EUR'
  AND k.kurstyp_id = 3
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.artbew_wg_sum
WHERE bewart_id = 1001
  AND (mandant_id, wup_id, nb_id, dat) IN
    (
      SELECT
         mandant_id
        ,wup_id
        ,nb_id
        ,dat
      FROM DBP_ETL.kmo_artbew_wg_sum_tmp
    )
  AND quelle = 1 -- Daten in der Zieltabelle stammen aus der Kasse
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.artbew_wg_sum
WHERE bewart_id IN (1001,1009)
  AND (mandant_id, wup_id, nb_id, dat) IN
    (
      SELECT
         mandant_id
        ,wup_id
        ,nb_id
        ,dat
      FROM DBP_ETL.kmo_artbew_wg_sum_tmp
    )
  AND (mandant_id, wup_id, nb_id, dat) IN
    (
      SELECT 
         mandant_id
        ,wup_id
        ,nb_id
        ,dat
      FROM DBP_DATA.wupcal
      WHERE datenlieferung_artbew_wg_sum = 2 
    )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.kmo_artbew_wg_sum_tmp 
WHERE (mandant_id, wup_id, dat, nb_id) IN 
  (
    SELECT  
       t.mandant_id
      ,t.wup_id
      ,t.dat
      ,t.nb_id
    FROM DBP_ETL.kmo_artbew_wg_sum_tmp t
    
    INNER JOIN DBP_DATA.artbew_wg_sum a
    ON t.mandant_id = a.mandant_id
      AND t.wup_id = a.wup_id
      AND t.nb_id = a.nb_id
      AND t.dat = a.dat
      AND a.bewart_id IN (1001,1009)
  )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.artbew_wg_sum
(
   mandant_id
  ,wup_id
  ,wg_id
  ,bewart_id
  ,dat
  ,nb_id
  ,arthiertyp_id
  ,umsatz_brutto
  ,umsatz_netto
  ,umsatz_wrg
  ,umsatz_brutto_konz
  ,umsatz_netto_konz
  ,kjmo
  ,menge
  ,quelle
)
SELECT
   mandant_id
  ,wup_id
  ,wg_id
  ,bewart_id
  ,dat
  ,nb_id
  ,arthiertyp_id
  ,umsatz_brutto
  ,umsatz_netto
  ,umsatz_wrg
  ,umsatz_brutto_konz
  ,umsatz_netto_konz
  ,kjmo
  ,menge
  ,quelle
FROM DBP_ETL.kmo_artbew_wg_sum_tmp
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_DATA.wupcal
SET datenlieferung_artbew_wg_sum = 1

WHERE (mandant_id, wup_id, nb_id, dat) IN
(SELECT mandant_id,wup_id,nb_id,dat
 FROM DBP_ETL.kmo_artbew_wg_sum_tmp
)
;


--translated statement
INSERT INTO DBP_ETL_PROCESS.artbew_wg_sum_agg_wt
(
   mandant_id
  ,wup_id
  ,nb_id
  ,dat
  ,calc_fg
  ,dat_lief
)
SELECT
   mandant_id
  ,wup_id
  ,nb_id
  ,dat
  ,0 AS calc_fg
   -- bartosiewiczadm - cloud migration
   -- ,DATE AS dat_lief
   ,CURRENT_DATE AS dat_lief
FROM DBP_ETL.kmo_artbew_wg_sum_tmp
GROUP BY 1,2,3,4,5,6
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.kmo_artbew_bon;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.kmo_artbew_bon_promotion;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.kmo_artbew_wg_sum_tmp;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.kmo_artbew_bon_dat;

DELETE FROM DBP_ETL_PROCESS.poslog_agg_wt
WHERE mandant_id > 1;
