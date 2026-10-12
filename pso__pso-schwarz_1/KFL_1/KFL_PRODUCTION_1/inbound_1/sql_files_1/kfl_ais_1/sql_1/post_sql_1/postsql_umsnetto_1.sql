--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.artbew_konto_work_1
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
      ,kjmo                                      
)
SELECT
  1 AS mandant_id
, CAST(SUBSTR(marktnummer,1,4) AS INTEGER) AS wup_id
, CAST(SUBSTR(fi_konto,4,7) AS INTEGER) as konto_id
, 1004 AS bewart_id
--, CAST(SUBSTR(marktnummer,4,1) AS SMALLINT) AS nb_id
, w.nb_id AS nb_id
, 2 AS arthiertyp_id
, CAST(brutto_umsatz AS DECIMAL (12,2)) / 100 AS umsatz_brutto
, CAST(netto_umsatz AS DECIMAL (12,2)) /100 AS umsatz_netto
, 'EUR' AS umsatz_wrg
, CAST(brutto_umsatz  AS DECIMAL (12,2)) / 100 AS umsatz_brutto_konz
, CAST(netto_umsatz   AS DECIMAL (12,2)) / 100 AS umsatz_netto_konz
, b.kjmo AS kjmo
FROM DBP_ETL.umsnetto_1 a
INNER JOIN DBP_DATA.monat_1 b	
ON  a.gjmo =  b.gjmo
INNER JOIN DBP_DATA.wup_1 w
ON  CAST(a.marktnummer AS INTEGER) = w.wup_id
AND 1 = w.mandant_id
AND w.nb_id IN (2, 7)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.artbew_konto_1
WHERE kjmo IN ( SELECT DISTINCT mo.kjmo 
                FROM DBP_ETL.umsnetto_1 ums
                INNER JOIN DBP_DATA.monat_1 mo
                   ON  ums.gjmo = mo.gjmo
                INNER JOIN DBP_DATA.wup_1 w
                   ON  CAST(ums.marktnummer AS INTEGER) = w.wup_id
                  AND 1 = w.mandant_id
                  AND w.nb_id IN (2, 7))
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.artbew_konto_1
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
      ,kjmo
)
SELECT
  1 AS mandant_id
, CAST(SUBSTR(marktnummer,1,4) AS INTEGER) AS wup_id
, CAST(SUBSTR(fi_konto,4,7) AS INTEGER) as konto_id
, 1004 AS bewart_id
--, CAST(SUBSTR(marktnummer,4,1) AS SMALLINT) AS nb_id
, w.nb_id AS nb_id
, 2 AS arthiertyp_id
, CAST(brutto_umsatz AS DECIMAL (12,2)) / 100 AS umsatz_brutto
, CAST(netto_umsatz AS DECIMAL (12,2)) /100 AS umsatz_netto
, 'EUR' AS umsatz_wrg
, CAST(brutto_umsatz  AS DECIMAL (12,2)) / 100 AS umsatz_brutto_konz
, CAST(netto_umsatz   AS DECIMAL (12,2)) / 100 AS umsatz_netto_konz
, b.kjmo AS kjmo
FROM DBP_ETL.umsnetto_1 a
INNER JOIN DBP_DATA.monat_1 b	
ON  a.gjmo =  b.gjmo
INNER JOIN DBP_DATA.wup_1 w
ON  CAST(a.marktnummer AS INTEGER) = w.wup_id
AND 1 = w.mandant_id
AND w.nb_id IN (2, 7)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--INSERT INTO DBX_LOAD.artbew_abt_sum_work_1
--  (
--       mandant_id
--      ,wup_id
--      ,nb_id
--      ,abt_id
--      ,bewart_id
--      ,dat
--      ,arthiertyp_id
--      ,umsatz_brutto
--      ,umsatz_netto
--      ,umsatz_wrg 
--      ,umsatz_brutto_konz
--      ,umsatz_netto_konz
--      ,kjmo
--    )
--SELECT 
--       a.mandant_id                        
--      ,a.wup_id
--      ,a.nb_id 
--      ,b.abt_id
--      ,a.bewart_id                                
--      ,CASE 
--         WHEN t.wtag_id = 7 
--            THEN add_months(cast(a.kjmo !! '01' as date format 'YYYYMMDD'),1)-1 -1
--        ELSE
--            add_months(cast(a.kjmo !! '01' as date format 'YYYYMMDD'),1)-1
--       END AS dat     
--       ,a.arthiertyp_id                   
--      ,SUM(a.umsatz_brutto)
--      ,SUM(a.umsatz_netto)                      
--      ,a.umsatz_wrg
--      ,SUM(a.umsatz_brutto_konz)                  
--      ,SUM(a.umsatz_netto_konz)                
--      ,a.kjmo
--FROM DBX_LOAD.artbew_konto_work_1 a
--
--INNER JOIN DBX_DATA.tag_1 t
--on add_months(cast(a.kjmo !! '01' as date format 'YYYYMMDD'),1)-1 = t.dat
--
--INNER JOIN DBX_DATA.konto_1 b	
--ON  a.konto_id =  b.konto_id
--AND 1 = b.mandant_id
--AND 2 = b.arthiertyp_id
--WHERE a.mandant_id = 1
--GROUP BY 1,2,3,4,5,6,7,10,13
--;
--
--Comment from validation checker
--error line 25 at position 41 unexpected '!'.
--            THEN add_months(cast(a.kjmo ! ^^^> ! '01' as date format 'YYYYMMDD'),1)-1 -1
--syntax error line 25 at position 56 unexpected 'format'.
--            THEN add_months(cast(a.kjmo !! '01' as date  ^^^> format 'YYYYMMDD'),1)-1 -1
--translated statement
INSERT INTO DBP_ETL.artbew_abt_sum_work_1
  (
       mandant_id
      ,wup_id
      ,nb_id
      ,abt_id
      ,bewart_id
      ,dat
      ,arthiertyp_id
      ,umsatz_brutto
      ,umsatz_netto
      ,umsatz_wrg 
      ,umsatz_brutto_konz
      ,umsatz_netto_konz
      ,kjmo
    )
SELECT 
       a.mandant_id                        
      ,a.wup_id
      ,a.nb_id 
      ,b.abt_id
      ,a.bewart_id                                
      ,CASE 
         WHEN t.wtag_id = 7 
            THEN add_months(to_date(CONCAT(a.kjmo , '01' ), 'YYYYMMDD'),1)-1 -1
        ELSE
            add_months(to_date(CONCAT(a.kjmo , '01' ), 'YYYYMMDD'),1)-1
       END AS dat     
       ,a.arthiertyp_id                   
      ,SUM(a.umsatz_brutto)
      ,SUM(a.umsatz_netto)                      
      ,a.umsatz_wrg
      ,SUM(a.umsatz_brutto_konz)                  
      ,SUM(a.umsatz_netto_konz)                
      ,a.kjmo
FROM DBP_ETL.artbew_konto_work_1 a

INNER JOIN DBP_DATA.tag_1 t
on add_months(to_date(CONCAT(a.kjmo ,'01' ), 'YYYYMMDD'),1)-1 = t.dat

INNER JOIN DBP_DATA.konto_1 b	
ON  a.konto_id =  b.konto_id
AND 1 = b.mandant_id
AND 2 = b.arthiertyp_id
WHERE a.mandant_id = 1
GROUP BY 1,2,3,4,5,6,7,10,13
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--INSERT INTO DBX_LOAD.artbew_abt_sum_work_1
--  (
--       mandant_id
--      ,wup_id
--      ,nb_id
--      ,abt_id
--      ,bewart_id
--      ,dat
--      ,arthiertyp_id
--      ,umsatz_brutto
--      ,umsatz_netto
--      ,umsatz_wrg 
--      ,umsatz_brutto_konz
--      ,umsatz_netto_konz
--      ,kjmo
--    )
--SELECT 
--       a.mandant_id                        
--      ,a.wup_id
--      ,a.nb_id 
--      ,abt_id
--      ,1001 AS bewart_id 
--      ,CASE 
--         WHEN t.wtag_id = 7 
--            THEN add_months(cast(a.kjmo !! '01' as date format 'YYYYMMDD'),1)-1 -1
--        ELSE
--            add_months(cast(a.kjmo !! '01' as date format 'YYYYMMDD'),1)-1
--       END AS dat             
--      ,a.arthiertyp_id                   
--      ,SUM(a.umsatz_brutto)
--      ,SUM(a.umsatz_netto)                      
--      ,a.umsatz_wrg
--      ,SUM(a.umsatz_brutto_konz)
--      ,SUM(a.umsatz_netto_konz)                
--      ,a.kjmo                                
--FROM DBX_DATA.artbew_wg_sum_1 a
--
--
--INNER JOIN DBX_DATA.wg_per_1	
--ON  a.wg_id = DBX_DATA.wg_per.wg_id
--AND DBX_DATA.wg_per.mandant_id = 1
--AND DBX_DATA.wg_per.arthiertyp_id = 2
--and DBX_DATA.wg_per.dat_bis = 80991231
--
--INNER JOIN DBX_DATA.tag_1 t
--on add_months(cast(a.kjmo !! '01' as date format 'YYYYMMDD'),1)-1 = t.dat
--
--
--WHERE a.mandant_id = 1
--AND a.bewart_id IN (1001,1006)
--AND ( a.wup_id
--     ,a.kjmo)
--  IN
--(
--SELECT   wup_id
--    , kjmo
--FROM DBX_LOAD.artbew_konto_work_1)
--
--GROUP BY 1,2,3,4,5,6,7,10,13
--;
--
--Comment from validation checker
--error line 25 at position 41 unexpected '!'.
--            THEN add_months(cast(a.kjmo ! ^^^> ! '01' as date format 'YYYYMMDD'),1)-1 -1
--syntax error line 25 at position 56 unexpected 'format'.
--            THEN add_months(cast(a.kjmo !! '01' as date  ^^^> format 'YYYYMMDD'),1)-1 -1
--translated statement
INSERT INTO DBP_ETL.artbew_abt_sum_work_1
  (
       mandant_id
      ,wup_id
      ,nb_id
      ,abt_id
      ,bewart_id
      ,dat
      ,arthiertyp_id
      ,umsatz_brutto
      ,umsatz_netto
      ,umsatz_wrg 
      ,umsatz_brutto_konz
      ,umsatz_netto_konz
      ,kjmo
    )
SELECT 
       a.mandant_id                        
      ,a.wup_id
      ,a.nb_id 
      ,abt_id
      ,1001 AS bewart_id 
      ,CASE 
         WHEN t.wtag_id = 7 
            THEN add_months(to_date(CONCAT(a.kjmo , '01') , 'YYYYMMDD'),1)-1 -1
        ELSE
            add_months(to_date(CONCAT(a.kjmo , '01'), 'YYYYMMDD'),1)-1
       END AS dat             
      ,a.arthiertyp_id                   
      ,SUM(a.umsatz_brutto)
      ,SUM(a.umsatz_netto)                      
      ,a.umsatz_wrg
      ,SUM(a.umsatz_brutto_konz)
      ,SUM(a.umsatz_netto_konz)                
      ,a.kjmo                                
FROM DBP_DATA.artbew_wg_sum_1 a


INNER JOIN DBP_DATA.wg_per_1	
ON  a.wg_id = DBP_DATA.wg_per.wg_id
AND DBP_DATA.wg_per.mandant_id = 1
AND DBP_DATA.wg_per.arthiertyp_id = 2
and DBP_DATA.wg_per.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')

INNER JOIN DBP_DATA.tag_1 t
on add_months(to_date(CONCAT(a.kjmo , '01' ), 'YYYYMMDD'),1)-1 = t.dat


WHERE a.mandant_id = 1
AND a.bewart_id IN (1001,1006)
AND ( a.wup_id
     ,a.kjmo)
  IN
(
SELECT   wup_id
    , kjmo
FROM DBP_ETL.artbew_konto_work_1)

GROUP BY 1,2,3,4,5,6,7,10,13
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.artbew_wg_sum_1
WHERE (mandant_id, wup_id, nb_id, dat)
IN (SELECT mandant_id, wup_id, nb_id, dat
    FROM DBP_ETL.artbew_abt_sum_work_1
)
AND bewart_id = 1004
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.artbew_wg_sum_1 (
  mandant_id
, wup_id
, wg_id        
, bewart_id    
, dat          
, nb_id
, arthiertyp_id      
, umsatz_brutto
, umsatz_netto 
, umsatz_wrg   
, umsatz_brutto_konz
, umsatz_netto_konz 
, kjmo
, menge
, quelle               
)

SELECT
  a.mandant_id
, k.wup_id
, g.wg_id  AS wg_id
, k.bewart_id 
, k.dat
, k.nb_id
, k.arthiertyp_id
, k.umsatz_brutto - a.umsatz_brutto AS umsatz_brutto
, k.umsatz_netto - a.umsatz_netto AS umsatz_netto
, k.umsatz_wrg   
, k.umsatz_brutto_konz - a.umsatz_brutto_konz AS umsatz_brutto_konz
, k.umsatz_netto_konz - a.umsatz_netto_konz AS umsatz_netto_konz
, k.kjmo
, '' AS menge
, 8 AS quelle
FROM DBP_ETL.artbew_abt_sum_work_1 k
INNER JOIN DBP_ETL.artbew_abt_sum_work_1 a
ON k.mandant_id = a.mandant_id 
AND k.wup_id = a.wup_id
AND k.abt_id = a.abt_id
AND k.dat = a.dat

INNER JOIN DBP_DATA.wg_per_1 g
ON g.mandant_id = k.mandant_id
AND g.abt_id = k.abt_id

WHERE
k.bewart_id = 1004
AND a.bewart_id IN (1001)
AND g.wg_id IN (-200,-100,-10,-20,-30,-40,-50,-60,-70,-80)
AND g.arthiertyp_id=2
and g.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_PROCESS.artbew_wg_sum_agg_wt_1
--(
--	mandant_id
--	,wup_id
--	,nb_id
--	,dat
--	,calc_fg
--	,dat_lief
--)
--SELECT
--	t1.mandant_id
--	,t1.wup_id
--	,t1.nb_id
--	,t1.dat
--	,3 as calc_fg -- 2 für Umsatzkorrektur
--	,date dat_lief
--FROM
--	DBX_LOAD.artbew_abt_sum_work_1 t1_1
--GROUP BY 
--	t1.mandant_id
--	,t1.wup_id
--	,t1.nb_id
--	,t1.dat
--;
--
--Comment from validation checker
--error line 16 at position 2
--	, ^^^> date dat_lief
--invalid identifier 'DATE'
--translated statement
INSERT INTO DBP_ETL_PROCESS.artbew_wg_sum_agg_wt_1
(
	mandant_id
	,wup_id
	,nb_id
	,dat
	,calc_fg
	,dat_lief
)
SELECT
	t1.mandant_id
	,t1.wup_id
	,t1.nb_id
	,t1.dat
	,3 as calc_fg -- 2 für Umsatzkorrektur
	,current_date dat_lief
FROM
	DBP_ETL.artbew_abt_sum_work_1 t1_1
GROUP BY 
	t1.mandant_id
	,t1.wup_id
	,t1.nb_id
	,t1.dat
;

