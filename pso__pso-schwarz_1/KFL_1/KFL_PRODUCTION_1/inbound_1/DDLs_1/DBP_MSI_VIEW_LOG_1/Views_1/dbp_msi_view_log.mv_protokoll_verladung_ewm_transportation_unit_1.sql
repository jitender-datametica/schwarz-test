CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_PROTOKOLL_VERLADUNG_EWM_TRANSPORTATION_UNIT_1(
	MANDANT_ID,
	TRANSPORTATION_UNIT_ID,
    KJ_TRANSPORTATION_UNIT,
	ZEITSTEMPEL_SCAN_ERSTE_PALETTE_TOUR,
	ZEITSTEMPEL_SCAN_LETZTE_PALETTE_TOUR,
	LAGERNUMMER_ID,
	ANZ_SORT
) AS
-- AP0137779,SPEC0164467 dknop, initial
-- AP0137779,SPEC0164467 dknop, adding CASE for lagersortiment_id=5 and lagersortiment_id=7
-- 2024-01-15, dknop, adding lagernummer_id
-- 2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT
-- 2025-10-25, INC11854616, dknop, changing data typ for lagersortiment to varchar
SELECT  
 pv_ewm.mandant_id
,pv_ewm.transportation_unit_id
,pv_ewm.KJ_TRANSPORTATION_UNIT
,MIN(TIMESTAMP_FROM_PARTS(pv_ewm.dat_scan, pv_ewm.zeit_scan)) AS zeitstempel_scan_erste_palette_tour  
,MAX(TIMESTAMP_FROM_PARTS(pv_ewm.dat_scan, pv_ewm.zeit_scan)) AS zeitstempel_scan_letzte_palette_tour
,pv_ewm.lagernummer_id
,COUNT(DISTINCT CASE WHEN pv_ewm.lagersortiment_id='5' THEN '1' 
                     WHEN pv_ewm.lagersortiment_id='7' THEN '2'
                     ELSE pv_ewm.lagersortiment_id END) AS anz_sort
 
  FROM dbp_view.v_protokoll_verladung_ewm_1 pv_ewm
  WHERE pruef_id='133' 
  
  GROUP BY  
 pv_ewm.mandant_id
,pv_ewm.transportation_unit_id
,pv_ewm.KJ_TRANSPORTATION_UNIT
,pv_ewm.lagernummer_id
 ;