--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.artbew_wg_sum_1
WHERE (mandant_id, wup_id, nb_id, dat)
IN (
SELECT 
mandant_id
, wup_id
, nb_id
, dat
FROM DBP_ETL.artbew_abt_sum_tag_work_1
)
AND bewart_id = 1006
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
, t.kjmo
, '' AS menge
, 8 AS quelle
FROM DBP_ETL.artbew_abt_sum_tag_work_1 k
INNER JOIN DBP_ETL.artbew_abt_sum_tag_work_1 a
ON k.mandant_id = a.mandant_id 
AND k.wup_id = a.wup_id
AND k.abt_id = a.abt_id
AND k.dat = a.dat

INNER JOIN DBP_DATA.tag_1 t
ON
k.dat = t.dat

INNER JOIN DBP_DATA.wg_per_1 g
ON g.mandant_id = k.mandant_id
AND g.abt_id = k.abt_id

WHERE
k.bewart_id = 1006
AND a.bewart_id = 1001
AND g.wg_id IN (-200,-100,-10,-20,-30,-40,-50,-60,-70,-80)
AND g.arthiertyp_id=2
AND g.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.artbew_wg_sum_1
WHERE
bewart_id = 1006
AND umsatz_brutto BETWEEN -1 AND 1
AND umsatz_netto BETWEEN -1 AND 1
AND dat BETWEEN CURRENT_DATE-10 AND CURRENT_DATE
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_PROCESS}.artbew_wg_sum_agg_wt_1
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
--	${DWH_COMMON_DBX_LOAD}.artbew_abt_sum_tag_work_1 t1_1
--GROUP BY 
--	 t1.mandant_id
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
	DBP_ETL.artbew_abt_sum_tag_work_1 t1_1
GROUP BY 
	 t1.mandant_id
	,t1.wup_id
	,t1.nb_id
	,t1.dat
;

