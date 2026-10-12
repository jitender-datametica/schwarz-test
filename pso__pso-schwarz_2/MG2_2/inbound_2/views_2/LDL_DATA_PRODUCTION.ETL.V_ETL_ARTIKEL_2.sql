create or replace view LDL_DATA_PRODUCTION.ETL.V_ETL_ARTIKEL_2(
	CNTRY,
	ARTIKELNR,
	DT,
	PR_DT
) as 
select left( CTRCODE, 2) as CNTRY,
       ARTIKELNR,
       CAST( EXTRACTION_TMSP as DATE) as DT,
       DATEADD( day, -1, DT) as PR_DT
  from etl.artikel_2
 group by 1,2,3 
  ;