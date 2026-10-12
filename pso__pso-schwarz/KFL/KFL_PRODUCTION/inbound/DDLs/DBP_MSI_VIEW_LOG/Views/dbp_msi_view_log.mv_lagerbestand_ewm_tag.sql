create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.MV_LAGERBESTAND_EWM_TAG(
	MANDANT_ID,
	LAGERNUMMER_ID,
	DAT,
	LAGERTYP_ID,
	LAGERBEREICH_ID,
	LAGERPLATZ_ID,
	HANDLING_UNIT_ID_TOP,
	HANDLING_UNIT_ID,
	CHARGE_ID,
	LAGERBESTAND_TYP_ID,
	LAGERPLATZ_TYP_ID,
	GANG_ID,
	SAEULE_ID,
	EBENE_ID,
	LAGEREINHEITENTYP_ID,
	IDEAL_SIZE,
	ACTUAL_SIZE,
	SIZE_IS_AV_FG,
	NEXT_SIZE,
	LETYP_LPTYP_DIFF_ID
) as


WITH LETYPs AS 
(

SELECT 
 t.mandant_id
,t.lagernummer_id
,t.dat
,t.lagertyp_id 
,TRY_CAST(RIGHT(t.lagereinheitentyp_id_top,2) AS INT) AS size_
,0 AS lp_av_fg
FROM  dbp_view.v_lagerbestand_ewm_tag  t
WHERE  t.lagereinheitentyp_id_top IS NOT NULL AND (CONTAINS( lagertyp_id, 'R0') OR (CONTAINS( lagertyp_id, 'R1') AND RIGHT(lagertyp_id,2) <> 'R1'))

GROUP BY 1,2,3,4,5

UNION
  

SELECT 
 t.mandant_id
,t.lagernummer_id
,t.dat
,t.lagertyp_id 
,TRY_CAST(RIGHT(t.lagerplatz_typ_id,2) AS INT) AS size_
,1 AS lp_av_fg
FROM  dbp_view.v_lagerbestand_ewm_tag  t
WHERE  t.lagereinheitentyp_id_top IS NOT NULL AND (CONTAINS( lagertyp_id, 'R0') OR (CONTAINS( lagertyp_id, 'R1') AND RIGHT(lagertyp_id,2) <> 'R1'))
AND RIGHT(t.lagerplatz_typ_id,1)<>'X'
GROUP BY 1,2,3,4,5
) 

SELECT 
 l_ewm_t.mandant_id
,l_ewm_t.lagernummer_id
,l_ewm_t.dat
,l_ewm_t.lagertyp_id
,l_ewm_t.lagerbereich_id
,l_ewm_t.lagerplatz_id
,l_ewm_t.handling_unit_id_top
,l_ewm_t.handling_unit_id
,l_ewm_t.charge_id
,l_ewm_t.lagerbestand_typ_id
,l_ewm_t.lagerplatz_typ_id
,l_ewm_t.gang_id
,l_ewm_t.saeule_id
,l_ewm_t.ebene_id
,l_ewm_t.lagereinheitentyp_id_top
,LETYPs.size_ AS ideal_size
,TRY_CAST(LEFT(l_ewm_t.lagerplatz_typ_id,2) AS INT) AS actual_size
,COALESCE(MAX(LETYPs.lp_av_fg),-1) AS size_is_av_fg
,MIN(LETYPs_min.size_) AS next_size
,CASE WHEN ideal_size = actual_size  THEN 0 
      WHEN next_size = actual_size  THEN 1 
 ELSE 2 END  AS letyp_lptyp_diff_id
FROM dbp_view.v_lagerbestand_ewm_tag l_ewm_t
LEFT JOIN  LETYPs LETYPs
 ON  l_ewm_t.dat = LETYPs.dat  
 AND l_ewm_t.lagernummer_id = LETYPs.lagernummer_id  
 AND l_ewm_t.lagertyp_id = LETYPs.lagertyp_id  
 AND l_ewm_t.mandant_id = LETYPs.mandant_id  
 AND TRY_CAST(RIGHT(lagereinheitentyp_id,2) AS INT) = LETYPs.size_  
    
LEFT JOIN LETYPs LETYPs_min
 ON  LETYPs_min.lp_av_fg = 1
 AND LETYPs_min.size_ > LETYPs.size_
 AND LETYPs.mandant_id = LETYPs_min.mandant_id
 AND LETYPs.lagernummer_id = LETYPs_min.lagernummer_id
 AND LETYPs.dat = LETYPs_min.dat
 AND LETYPs.lagertyp_id = LETYPs_min.lagertyp_id
 
 WHERE RIGHT(l_ewm_t.lagereinheitentyp_id,1)<>'X'


 
         
GROUP BY 
 l_ewm_t.mandant_id
,l_ewm_t.lagernummer_id
,l_ewm_t.dat
,l_ewm_t.lagertyp_id
,LETYPs.size_
,l_ewm_t.lagerbereich_id
,l_ewm_t.lagerplatz_id
,l_ewm_t.handling_unit_id_top
,l_ewm_t.handling_unit_id
,l_ewm_t.charge_id
,l_ewm_t.lagerbestand_typ_id
,l_ewm_t.lagerplatz_typ_id
,l_ewm_t.gang_id
,l_ewm_t.saeule_id
,l_ewm_t.ebene_id
,l_ewm_t.lagereinheitentyp_id_top
;
