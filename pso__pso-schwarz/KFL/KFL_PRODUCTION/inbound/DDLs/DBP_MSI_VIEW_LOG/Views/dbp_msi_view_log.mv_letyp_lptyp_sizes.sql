create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.MV_LETYP_LPTYP_SIZES(
	MANDANT_ID,
	LAGERNUMMER_ID,
	DAT,
	LAGERTYP_ID,
	SIZE,
	NEXT_SIZE
) as
--2023-12-20, dknop, AP0201997, SPEC0229692, initial
WITH LETYPs AS 
(
--actually used LETYPs
SELECT 
 t.mandant_id
,t.lagernummer_id
,t.dat
,t.lagertyp_id 
,TRY_CAST(RIGHT(t.lagereinheitentyp_id,2) AS INT) AS size_
,0 AS lp_av_fg
FROM  dbp_view.v_lagerbestand_ewm_tag  t
WHERE  t.lagereinheitentyp_id IS NOT NULL AND (CONTAINS( lagertyp_id, 'R0') OR (CONTAINS( lagertyp_id, 'R1') AND RIGHT(lagertyp_id,2) <> 'R1'))
AND RIGHT(t.lagereinheitentyp_id,1)<>'X'
GROUP BY 1,2,3,4,5

UNION
  
--available/defined LPTYPs
SELECT 
 t.mandant_id
,t.lagernummer_id
,t.dat
,t.lagertyp_id 
,TRY_CAST(RIGHT(t.lagereinheitentyp_id,2) AS INT) AS size_
,1 AS lp_av_fg
FROM  dbp_view.v_lagerbestand_ewm_tag  t
WHERE  t.lagereinheitentyp_id IS NOT NULL AND (CONTAINS( lagertyp_id, 'R0') OR (CONTAINS( lagertyp_id, 'R1') AND RIGHT(lagertyp_id,2) <> 'R1'))
AND RIGHT(t.lagerplatz_typ_id,1)<>'X'
GROUP BY 1,2,3,4,5
) 

SELECT 
 LETYPs.mandant_id
,LETYPs.lagernummer_id
,LETYPs.dat
,LETYPs.lagertyp_id
,LETYPs.size_
,MIN(LETYPs_min.size_) AS next_size
FROM LETYPs LETYPs
  LEFT JOIN LETYPs LETYPs_min
   ON  LETYPs_min.lp_av_fg = 1
   AND LETYPs_min.size_ > LETYPs.size_
   AND LETYPs.mandant_id = LETYPs_min.mandant_id
   AND LETYPs.lagernummer_id = LETYPs_min.lagernummer_id
   AND LETYPs.dat = LETYPs_min.dat
   AND LETYPs.lagertyp_id = LETYPs_min.lagertyp_id
GROUP BY 
 LETYPs.mandant_id
,LETYPs.lagernummer_id
,LETYPs.dat
,LETYPs.lagertyp_id 
,LETYPs.size_;
