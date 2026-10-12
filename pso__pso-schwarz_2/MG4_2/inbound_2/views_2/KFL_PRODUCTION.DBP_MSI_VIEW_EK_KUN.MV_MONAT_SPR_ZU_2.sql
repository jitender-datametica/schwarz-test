create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_MONAT_SPR_ZU_2(
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
	MO_BEZ_BG
) as
SELECT
 v01.kjmo
,v01.gj
,v01.mo_gj
,v01.gjmo
,v01.kj
,v01.mo_kj

,CAST(MAX(CASE WHEN v02.spr_id =  24 THEN v02.mo_bez ELSE NULL END) AS VARCHAR(80)) AS mo_bez_en    --EN
,CAST(COALESCE(MAX(CASE WHEN v02.spr_id =  22 THEN v02.mo_bez ELSE NULL END) , mo_bez_en) AS VARCHAR(80)) AS mo_bez     -- DE (Standard)
,CAST(COALESCE(MAX(CASE WHEN v02.spr_id = 124 THEN v02.mo_bez ELSE NULL END) , mo_bez_en) AS VARCHAR(80)) AS mo_bez_cz  -- CZ
,CAST(COALESCE(MAX(CASE WHEN v02.spr_id =  90 THEN v02.mo_bez ELSE NULL END) , mo_bez_en) AS VARCHAR(80)) AS mo_bez_pl  -- PL
,CAST(COALESCE(MAX(CASE WHEN v02.spr_id = 108 THEN v02.mo_bez ELSE NULL END) , mo_bez_en) AS VARCHAR(80)) AS mo_bez_sk  -- SK
,CAST(COALESCE(MAX(CASE WHEN v02.spr_id =  65 THEN v02.mo_bez ELSE NULL END) , mo_bez_en) AS VARCHAR(80)) AS mo_bez_hr  -- HR
,CAST(COALESCE(MAX(CASE WHEN v02.spr_id =  95 THEN v02.mo_bez ELSE NULL END) , mo_bez_en) AS VARCHAR(80)) AS mo_bez_ro  -- RO
,CAST(COALESCE(MAX(CASE WHEN v02.spr_id =  18 THEN v02.mo_bez ELSE NULL END) , mo_bez_en) AS VARCHAR(80)) AS mo_bez_bg  -- BG
FROM dbp_view.v_monat_2 v01

INNER JOIN  dbp_view.v_monat_spr_zu_2 v02
ON v01.mo_kj = v02.mo_id

GROUP BY 
 v01.kjmo
,v01.gj
,v01.mo_gj
,v01.gjmo
,v01.kj
,v01.mo_kj
;