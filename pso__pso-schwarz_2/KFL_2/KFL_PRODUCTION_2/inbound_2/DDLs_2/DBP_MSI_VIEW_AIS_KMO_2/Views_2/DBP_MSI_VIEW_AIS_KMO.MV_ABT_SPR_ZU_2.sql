CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ABT_SPR_ZU_2
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_2 / ssch1303 01.02.2022
(
 mandant_id
,abt_id
,arthiertyp_id
,abt_bez
,abt_bez_de
,abt_bez_cz
,abt_bez_sk
,abt_bez_hr
,abt_bez_pl
,abt_bez_ro
,abt_bez_bg
)

AS 
SELECT 
 v01.mandant_id
,v01.abt_id
,v01.arthiertyp_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.abt_bez END), 'N/A') AS abt_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.abt_bez END), 'N/A') AS abt_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.abt_bez END), abt_bez_de) AS abt_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.abt_bez END), abt_bez_de) AS abt_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.abt_bez END), abt_bez_de) AS abt_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.abt_bez END), abt_bez_de) AS abt_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.abt_bez END), abt_bez_de) AS abt_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.abt_bez END), abt_bez_de) AS abt_bez_bg
FROM DBP_VIEW.V_ABT_SPR_ZU_2 v01
WHERE mandant_id <> 1
AND v01.arthiertyp_id =2
GROUP BY
 v01.mandant_id
,v01.abt_id
,v01.arthiertyp_id
;