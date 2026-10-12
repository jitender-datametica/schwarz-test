INSERT INTO DBP_ETL.artbew_konto_tag_work_1
(
       mandant_id                        
      ,wup_id                         
      ,konto_id                       
      ,bewart_id                                     
      ,nb_id                       
      ,arthiertyp_id                   
      ,umsatz_brutto                  
      ,umsatz_netto                      
      ,umsatz_wrg
      ,umsatz_brutto_konz                  
      ,umsatz_netto_konz                
      ,dat                                   
)
SELECT
  1 AS mandant_id
, CAST(SUBSTR(marktnummer,1,4) AS INTEGER) AS wup_id
, CAST(SUBSTR(fi_konto,4,7) AS INTEGER) AS konto_id
, 1006 AS bewart_id
, w.nb_id AS nb_id
, 2 AS arthiertyp_id
, SUM(CAST(replace(brutto_umsatz,',','.') AS DECIMAL (12,2))) AS umsatz_brutto
, SUM(CAST(replace(netto_umsatz,',','.') AS DECIMAL (12,2))) AS umsatz_netto
, 'EUR' AS umsatz_wrg
, SUM(CAST(replace(brutto_umsatz,',','.')  AS DECIMAL (12,2))) AS umsatz_brutto_konz
, SUM(CAST(replace(netto_umsatz,',','.')   AS DECIMAL (12,2))) AS umsatz_netto_konz
, to_date(datum, 'YYYYMMDD') AS dat
FROM DBP_ETL.d_umsnetto_tag_1 a
INNER JOIN DBP_DATA.wup_1 w
ON  CAST(a.marktnummer AS INTEGER) = w.wup_id
AND 1 = w.mandant_id
AND w.nb_id IN (2, 7)

GROUP BY 1,2,3,4,5,6,9,12
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.artbew_konto_tag_1 a
WHERE (dat,wup_id,konto_id) IN 
(SELECT dat,wup_id,konto_id FROM DBP_ETL.artbew_konto_tag_work_1)
;


INSERT INTO DBP_DATA.artbew_konto_tag_1
(
       mandant_id                        
      ,wup_id                         
      ,konto_id                       
      ,bewart_id                                     
      ,nb_id                       
      ,arthiertyp_id                   
      ,umsatz_brutto                  
      ,umsatz_netto                      
      ,umsatz_wrg
      ,umsatz_brutto_konz                  
      ,umsatz_netto_konz                
      ,dat                                   
)
SELECT
  1 AS mandant_id
, CAST(SUBSTR(marktnummer,1,4) AS INTEGER) AS wup_id
, CAST(SUBSTR(fi_konto,4,7) AS INTEGER) as konto_id
, 1006 AS bewart_id
, w.nb_id AS nb_id
, 2 AS arthiertyp_id
, SUM(CAST(replace(brutto_umsatz,',','.') AS DECIMAL (12,2))) AS umsatz_brutto
, SUM(CAST(replace(netto_umsatz,',','.') AS DECIMAL (12,2))) AS umsatz_netto
, 'EUR' AS umsatz_wrg
, SUM(CAST(replace(brutto_umsatz,',','.')  AS DECIMAL (12,2))) AS umsatz_brutto_konz
, SUM(CAST(replace(netto_umsatz,',','.')   AS DECIMAL (12,2))) AS umsatz_netto_konz
, to_date(datum, 'YYYYMMDD') AS dat
FROM DBP_ETL.d_umsnetto_tag_1 a
INNER JOIN DBP_DATA.wup_1 w
ON  CAST(a.marktnummer AS INTEGER) = w.wup_id
AND 1 = w.mandant_id
AND w.nb_id IN (2, 7)

GROUP BY 1,2,3,4,5,6,9,12
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.artbew_wg_sum_1 a
WHERE nb_id = 2
AND bewart_id IN (1003,1001)
AND (dat,wup_id) IN (SELECT dat,wup_id FROM DBP_ETL.artbew_konto_tag_work_1)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.artbew_wg_sum_1
(
       mandant_id
      ,wup_id
      ,wg_id
      ,bewart_id
      ,nb_id
      ,arthiertyp_id
      ,kjmo
      ,umsatz_brutto
      ,umsatz_netto
      ,umsatz_wrg
      ,umsatz_brutto_konz
      ,umsatz_netto_konz
      ,dat
      ,quelle
      ,menge
)
SELECT
  mandant_id
, wup_id
, -2 AS wg_id
, 1003 AS bewart_id
, nb_id
, 2 AS arthiertyp_id
, t.kjmo
, SUM(umsatz_brutto) AS umsatz_brutto
, SUM(umsatz_netto) AS umsatz_netto
, 'EUR' AS umsatz_wrg
, SUM(umsatz_brutto) AS umsatz_brutto_konz
, SUM(umsatz_netto) AS umsatz_netto_konz
, a.dat
, 1
, 0
FROM DBP_ETL.artbew_konto_tag_work_1 a

INNER JOIN DBP_DATA.tag_1 t
ON a.dat = t.dat
WHERE nb_id = 2
GROUP BY 1,2,3,4,5,6,7,10,13,14,15
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE  DBP_DATA.wupcal_1
   SET  datenlieferung_artbew_wg_sum = 1,
        td_update= CURRENT_TIMESTAMP

WHERE (
    mandant_id
  , wup_id
  , dat
  , nb_id
) 
IN
(SELECT 
    mandant_id
   ,wup_id
   ,dat
   ,nb_id
FROM DBP_ETL.artbew_konto_tag_work_1
WHERE nb_id = 2)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.artbew_abt_sum_tag_work_1
  (
       mandant_id
      ,wup_id
      ,nb_id
      ,abt_id
      ,bewart_id
      ,arthiertyp_id
      ,umsatz_brutto
      ,umsatz_netto
      ,umsatz_wrg 
      ,umsatz_brutto_konz
      ,umsatz_netto_konz
      ,dat
    )
SELECT 
       a.mandant_id                        
      ,a.wup_id
      ,a.nb_id 
      ,b.abt_id
      ,a.bewart_id                                
      ,a.arthiertyp_id                   
      ,SUM(a.umsatz_brutto)
      ,SUM(a.umsatz_netto)                      
      ,a.umsatz_wrg
      ,SUM(a.umsatz_brutto_konz)                  
      ,SUM(a.umsatz_netto_konz)                
      ,a.dat
FROM DBP_ETL.artbew_konto_tag_work_1 a

INNER JOIN DBP_DATA.wupcal_1 c
ON
    a.wup_id = c.wup_id
AND a.dat = c.dat
AND a.mandant_id = c.mandant_id
AND c.datenlieferung_artbew_wg_sum = 1

INNER JOIN DBP_DATA.konto_1 b	
ON  a.konto_id =  b.konto_id
AND 1 = b.mandant_id
AND 2 = b.arthiertyp_id
WHERE a.mandant_id = 1
GROUP BY 1,2,3,4,5,6,9,12
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.artbew_abt_sum_tag_work_1
  (
       mandant_id
      ,wup_id
      ,nb_id
      ,abt_id
      ,bewart_id
      ,arthiertyp_id
      ,umsatz_brutto
      ,umsatz_netto
      ,umsatz_wrg 
      ,umsatz_brutto_konz
      ,umsatz_netto_konz
      ,dat
    )
SELECT 
       a.mandant_id                        
      ,a.wup_id
      ,a.nb_id 
      ,abt_id
      ,a.bewart_id 
      ,a.arthiertyp_id                   
      ,SUM(a.umsatz_brutto)
      ,SUM(a.umsatz_netto)                      
      ,a.umsatz_wrg
      ,SUM(a.umsatz_brutto_konz)
      ,SUM(a.umsatz_netto_konz)                
      ,a.dat                                
FROM DBP_DATA.artbew_wg_sum_1 a

INNER JOIN DBP_DATA.wg_per_1	
ON  a.wg_id = DBP_DATA.wg_per.wg_id
AND DBP_DATA.wg_per.mandant_id = 1
AND DBP_DATA.wg_per.arthiertyp_id = 2
AND DBP_DATA.wg_per.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')

WHERE a.mandant_id = 1
AND a.bewart_id = 1001
AND ( a.wup_id,a.dat) IN
(SELECT wup_id, dat FROM DBP_ETL.artbew_abt_sum_tag_work_1)

GROUP BY 1,2,3,4,5,6,9,12
;

