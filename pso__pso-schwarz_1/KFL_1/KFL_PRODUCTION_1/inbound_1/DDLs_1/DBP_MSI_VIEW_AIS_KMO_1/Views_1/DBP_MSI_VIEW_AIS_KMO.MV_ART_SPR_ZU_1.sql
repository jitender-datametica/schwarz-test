create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_AIS_KMO.MV_ART_SPR_ZU_1(
	MANDANT_ID,
	ART_ID,
	KL_ART_ID,
	INT_ART_ID,
	ART_BEZ,
	ART_BEZ_DE,
	ART_BEZ_CZ,
	ART_BEZ_SK,
	ART_BEZ_HR,
	ART_BEZ_PL,
	ART_BEZ_RO,
	ART_BEZ_BG,
	INT_ART_BEZ,
	INT_ART_BEZ_DE,
	INT_ART_BEZ_CZ,
	INT_ART_BEZ_SK,
	INT_ART_BEZ_HR,
	INT_ART_BEZ_PL,
	INT_ART_BEZ_RO,
	INT_ART_BEZ_BG
) as
SELECT
 v01.mandant_id
,v01.art_id
,v02.kl_art_id
,v02.int_art_id

,COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.art_bez END),'N/A') AS art_bez                                                             
,COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.art_bez END),'N/A') AS art_bez_de                                                     
,COALESCE(MAX(CASE WHEN v01.spr_id = 124  THEN v01.art_bez END), art_bez_de) AS art_bez_cz  
,COALESCE(MAX(CASE WHEN v01.spr_id = 108  THEN v01.art_bez END), art_bez_de) AS art_bez_sk 
,COALESCE(MAX(CASE WHEN v01.spr_id =  65  THEN v01.art_bez END), art_bez_de) AS art_bez_hr    
,COALESCE(MAX(CASE WHEN v01.spr_id =  90  THEN v01.art_bez END), art_bez_de) AS art_bez_pl    
,COALESCE(MAX(CASE WHEN v01.spr_id =  95  THEN v01.art_bez END), art_bez_de) AS art_bez_ro   
,COALESCE(MAX(CASE WHEN v01.spr_id =  18  THEN v01.art_bez END), art_bez_de) AS art_bez_bg  


 ,COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.int_art_bez END),'N/A') AS int_art_bez                                                             
 ,COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.int_art_bez END),'N/A') AS int_art_bez_de                                                     
 ,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.int_art_bez END), int_art_bez_de) AS int_art_bez_cz  
 ,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.int_art_bez END), int_art_bez_de) AS int_art_bez_sk 
 ,COALESCE(MAX(CASE WHEN v01.spr_id =  65  THEN v01.int_art_bez END), int_art_bez_de) AS int_art_bez_hr    
 ,COALESCE(MAX(CASE WHEN v01.spr_id =  90  THEN v01.int_art_bez END), int_art_bez_de) AS int_art_bez_pl    
 ,COALESCE(MAX(CASE WHEN v01.spr_id =  95  THEN v01.int_art_bez END), int_art_bez_de) AS int_art_bez_ro   
 ,COALESCE(MAX(CASE WHEN v01.spr_id =  18  THEN v01.int_art_bez END), int_art_bez_de) AS int_art_bez_bg  

FROM dbp_data.art_spr_zu_1 v01

JOIN dbp_data.art_1 v02
ON (v01.art_id = v02.art_id
AND v01.mandant_id = v02.mandant_id)

WHERE v01.mandant_id <> 1

GROUP BY
 v01.mandant_id
,v01.art_id
,v02.kl_art_id
,v02.int_art_id
;
