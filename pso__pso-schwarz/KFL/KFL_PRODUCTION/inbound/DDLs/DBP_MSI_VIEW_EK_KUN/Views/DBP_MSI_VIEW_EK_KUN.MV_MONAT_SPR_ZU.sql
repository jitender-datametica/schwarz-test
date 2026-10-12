create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_MONAT_SPR_ZU(
	KJMO,
	GJ,
	MO_GJ,
	GJMO,
	KJ,
	MO_KJ,
	MO_BEZ_EN,
	MO_BEZ,
	MO_BEZ_CZ,
	MO_BEZ_PL,
	MO_BEZ_SK,
	MO_BEZ_HR,
	MO_BEZ_RO,
	MO_BEZ_BG,
	MO_BEZ_LANG,
	MO_BEZ_LANG_CZ,
	MO_BEZ_LANG_PL,
	MO_BEZ_LANG_SK,
	MO_BEZ_LANG_HR,
	MO_BEZ_LANG_RO,
	MO_BEZ_LANG_BG
) as
SELECT
 v01.kjmo
,v01.gj
,v01.mo_gj
,v01.gjmo
,v01.kj
,v01.mo_kj

,CAST(MAX(CASE WHEN v02.spr_id =  24 THEN v02.mo_bez ELSE NULL END) AS VARCHAR(80)) AS mo_bez_en    
,CAST(COALESCE(MAX(CASE WHEN v02.spr_id =  22 THEN v02.mo_bez ELSE NULL END) , mo_bez_en) AS VARCHAR(80)) AS mo_bez     
,CAST(COALESCE(MAX(CASE WHEN v02.spr_id = 124 THEN v02.mo_bez ELSE NULL END) , mo_bez_en) AS VARCHAR(80)) AS mo_bez_cz  
,CAST(COALESCE(MAX(CASE WHEN v02.spr_id =  90 THEN v02.mo_bez ELSE NULL END) , mo_bez_en) AS VARCHAR(80)) AS mo_bez_pl  
,CAST(COALESCE(MAX(CASE WHEN v02.spr_id = 108 THEN v02.mo_bez ELSE NULL END) , mo_bez_en) AS VARCHAR(80)) AS mo_bez_sk  
,CAST(COALESCE(MAX(CASE WHEN v02.spr_id =  65 THEN v02.mo_bez ELSE NULL END) , mo_bez_en) AS VARCHAR(80)) AS mo_bez_hr  
,CAST(COALESCE(MAX(CASE WHEN v02.spr_id =  95 THEN v02.mo_bez ELSE NULL END) , mo_bez_en) AS VARCHAR(80)) AS mo_bez_ro  
,CAST(COALESCE(MAX(CASE WHEN v02.spr_id =  18 THEN v02.mo_bez ELSE NULL END) , mo_bez_en) AS VARCHAR(80)) AS mo_bez_bg  


,MAX(CASE WHEN v02.spr_id =  22 THEN (TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_bez_lang  
,MAX(CASE WHEN v02.spr_id = 124 THEN (TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_bez_lang_cz
,MAX(CASE WHEN v02.spr_id =  90 THEN (TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_bez_lang_pl
,MAX(CASE WHEN v02.spr_id = 108 THEN (TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_bez_lang_sk
,MAX(CASE WHEN v02.spr_id =  65 THEN (TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_bez_lang_hr
,MAX(CASE WHEN v02.spr_id =  95 THEN (TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_bez_lang_ro
,MAX(CASE WHEN v02.spr_id =  18 THEN (TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_bez_lang_bg
FROM DBP_DATA.MONAT v01

INNER JOIN  DBP_DATA.MONAT_SPR_ZU v02
ON v01.mo_kj = v02.mo_id

GROUP BY 
 v01.kjmo
,v01.gj
,v01.mo_gj
,v01.gjmo
,v01.kj
,v01.mo_kj
;
