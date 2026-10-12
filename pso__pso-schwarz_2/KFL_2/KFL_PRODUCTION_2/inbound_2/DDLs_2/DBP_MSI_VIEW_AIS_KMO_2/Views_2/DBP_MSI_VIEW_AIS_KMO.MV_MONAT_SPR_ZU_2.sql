CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_MONAT_SPR_ZU_2
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_2 / ssch1303 02.02.2022
(
 mo_kj
,mo_bez
,mo_bez_de
,mo_bez_cz
,mo_bez_sk
,mo_bez_hr
,mo_bez_pl
,mo_bez_ro
,mo_bez_bg
,kjmo
,kj
,mo_bez_lang
,mo_bez_lang_de
,mo_bez_lang_cz
,mo_bez_lang_sk
,mo_bez_lang_hr
,mo_bez_lang_pl
,mo_bez_lang_ro
,mo_bez_lang_bg
)

AS
SELECT
 v01.mo_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN CAST(v01.mo_bez AS VARCHAR(40)) END), 'N/A') AS mo_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN CAST(v01.mo_bez AS VARCHAR(40)) END), 'N/A') AS mo_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN CAST(v01.mo_bez AS VARCHAR(40)) END), mo_bez_de) AS mo_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN CAST(v01.mo_bez AS VARCHAR(40)) END), mo_bez_de) AS mo_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN CAST(v01.mo_bez AS VARCHAR(40)) END), mo_bez_de) AS mo_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN CAST(v01.mo_bez AS VARCHAR(40)) END), mo_bez_de) AS mo_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN CAST(v01.mo_bez AS VARCHAR(40)) END), mo_bez_de) AS mo_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN CAST(v01.mo_bez AS VARCHAR(40)) END), mo_bez_de) AS mo_bez_bg
,v02.kjmo
,v02.kj
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN CAST (TRIM(v01.mo_bez)|| ' ' ||TRIM(v02.kj) AS VARCHAR(25)) END), 'N/A') AS mo_bez_lang
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN CAST (TRIM(v01.mo_bez)|| ' ' ||TRIM(v02.kj) AS VARCHAR(25)) END), 'N/A') AS mo_bez_lang_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN CAST (TRIM(v01.mo_bez)|| ' ' ||TRIM(v02.kj) AS VARCHAR(25)) END), mo_bez_lang_de) AS mo_bez_lang_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN CAST (TRIM(v01.mo_bez)|| ' ' ||TRIM(v02.kj) AS VARCHAR(25)) END), mo_bez_lang_de) AS mo_bez_lang_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN CAST (TRIM(v01.mo_bez)|| ' ' ||TRIM(v02.kj) AS VARCHAR(25)) END), mo_bez_lang_de) AS mo_bez_lang_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN CAST (TRIM(v01.mo_bez)|| ' ' ||TRIM(v02.kj) AS VARCHAR(25)) END), mo_bez_lang_de) AS mo_bez_lang_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN CAST (TRIM(v01.mo_bez)|| ' ' ||TRIM(v02.kj) AS VARCHAR(25)) END), mo_bez_lang_de) AS mo_bez_lang_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN CAST (TRIM(v01.mo_bez)|| ' ' ||TRIM(v02.kj) AS VARCHAR(25)) END), mo_bez_lang_de) AS mo_bez_lang_bg

FROM dbp_view.v_monat_spr_zu_2 v01

JOIN dbp_view.v_monat_2 v02
ON v01.mo_id = v02.mo_kj

GROUP BY
 v01.mo_id
,v02.kjmo
,v02.kj
;