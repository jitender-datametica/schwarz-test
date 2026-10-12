

DELETE FROM DBP_DATA.artbew_wg_sum_2
WHERE mandant_id = 2 
AND wg_id = -99
AND bewart_id = 1005
AND dat IN
(
SELECT DISTINCT to_date(DOC_DATE , 'YYYYMMDD')
FROM DBP_ETL.mis_heler_2
WHERE loc_currcy = 'CZK'
)
;


--translated statement
INSERT INTO DBP_DATA.artbew_wg_sum_2
(
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
, umrechnungskurs_hist
)
 SELECT 
  2 AS mandant_id
 --,COALESCE(m.bus_area, substring(m.alloc_nmbr, 1, 4), '0') AS wup_id
 ,COALESCE(nullif(m.bus_area,''), substring(m.alloc_nmbr, 1, 4),'0') AS wup_id --EVT2342668
 ,-99 AS wg_id
 ,1005 AS bewart_id
 ,to_date(m.DOC_DATE, 'YYYYMMDD') AS doc_date2
 ,0 AS nb_id
 ,2 AS arthiertyp_id
 ,sum( case when dcindic = 'H' then m.DEB_CRE_LC else m.DEB_CRE_LC * -1 end) AS umsatz_brutto
 ,sum( case when dcindic = 'H' then m.DEB_CRE_LC else m.DEB_CRE_LC * -1 end) AS umsatz_netto
 ,m.LOC_CURRCY AS umsatz_wrg
 ,sum( case when dcindic = 'H' then (m.DEB_CRE_LC * k.umrechnungskurs) else (m.DEB_CRE_LC * k.umrechnungskurs * -1) end) AS umsatz_brutto_konz
 ,sum( case when dcindic = 'H' then (m.DEB_CRE_LC * k.umrechnungskurs) else (m.DEB_CRE_LC * k.umrechnungskurs * -1) end) AS umsatz_netto_konz
 ,t.kjmo AS kjmo
 ,0 AS menge
 ,1 AS quelle
 ,max(x.umrechnungskurs)
FROM DBP_ETL.mis_heler_2 m

JOIN DBP_DATA.kurs_2 k
  ON k.von_wrg_id = m.loc_currcy 
 AND k.nach_wrg_id = 'EUR'
 AND k.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
 AND k.kurstyp_id = 3

JOIN DBP_DATA.kurs_2 x
  ON x.von_wrg_id = m.loc_currcy 
 AND x.nach_wrg_id = 'EUR'
 AND to_date(m.DOC_DATE, 'YYYYMMDD') between x.dat_von and x.dat_bis
 AND x.kurstyp_id = 3
			
JOIN DBP_DATA.tag_2 t
ON to_date(m.DOC_DATE, 'YYYYMMDD') = t.dat	

GROUP BY 1,2,3,4,5,6,7,10,13,14,15	
HAVING m.LOC_CURRCY = 'CZK'
AND ABS(umsatz_brutto) < 10000			
;


INSERT INTO DBP_ETL_PROCESS.artbew_wg_sum_agg_wt_2
(
	mandant_id
	,wup_id
	,nb_id
	,dat
	,calc_fg
	,dat_lief
)
SELECT
	2 AS mandant_id
	--,COALESCE(mis_heler.bus_area, substring(mis_heler.alloc_nmbr, 1, 4), '0') AS wup_id
	,COALESCE(nullif(m.bus_area,''), substring(m.alloc_nmbr, 1, 4),'0') AS wup_id --EVT2342668
        ,0 as nb_id
	,to_date (m.doc_date, 'YYYYMMDD') AS dat
	,2 as calc_fg --- 2 für Helerrundung
	,current_date AS dat_lief
FROM	DBP_ETL.mis_heler_2 m
	
WHERE m.LOC_CURRCY = 'CZK'	
GROUP BY 	1,2,3,4,5,6
;
