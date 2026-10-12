create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_PROTOKOLL_VERLADUNG_TOUR_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	TOUR_ID,
	ZEITSTEMPEL_SCAN_ERSTE_PALETTE_TOUR,
	ZEITSTEMPEL_SCAN_LETZTE_PALETTE_TOUR,
	ANZ_SORT
) as
-- AP0119377_SPEC0152763, dknop, initial
-- AP0119377_SPEC0152763, dknop, removing lagernummer_id
SELECT 

  pv.mandant_id
 ,pv.wup_id
 ,pv.nb_id
 ,pv.tour_id
-- ,pv.lagernummer_id
 ,pv_agg.zeitstempel_scan_erste_palette_tour
 ,pv_agg.zeitstempel_scan_letzte_palette_tour
 ,pv_agg.anz_sort
 
  FROM dbp_view.v_protokoll_verladung_1 pv
JOIN(
SELECT  
  mandant_id
 ,wup_id
 ,nb_id
 ,tour_id
 ,COUNT(DISTINCT lagernummer_id) AS anz_sort
 ,MIN(TIMESTAMP_NTZ_FROM_PARTS(dat_scan::DATE,zeit_scan::TIME)) AS zeitstempel_scan_erste_palette_tour  
 ,MAX(TIMESTAMP_NTZ_FROM_PARTS(dat_scan::DATE,zeit_scan::TIME)) AS zeitstempel_scan_letzte_palette_tour
 
  FROM dbp_view.v_protokoll_verladung_1
  WHERE pruef_id='334' 
  
  GROUP BY  
  mandant_id
 ,wup_id
 ,nb_id
 ,tour_id) pv_agg
 
 ON  pv.mandant_id=pv_agg.mandant_id
 AND pv.wup_id=pv_agg.wup_id
 AND pv.nb_id=pv_agg.nb_id
 AND pv.tour_id=pv_agg.tour_id

--where pv.tour_id=26400292

  GROUP BY  
 pv.mandant_id
,pv.wup_id
,pv.nb_id
,pv.tour_id
--,pv.lagernummer_id
,pv_agg.zeitstempel_scan_erste_palette_tour  
,pv_agg.zeitstempel_scan_letzte_palette_tour
,pv_agg.anz_sort;