CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_WUG_SPR_ZU_1
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_1 / ssch1303 01.02.2022
(
 mandant_id
,wg_id
,wug_id
,arthiertyp_id
,wug_bez
,wug_bez_de
,wug_bez_cz
,wug_bez_sk
,wug_bez_hr
,wug_bez_pl
,wug_bez_ro
,wug_bez_bg
)

AS
SELECT
 v01.mandant_id
,v01.wg_id
,v01.wug_id
,v01.arthiertyp_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.wug_bez END), 'N/A') AS wug_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.wug_bez END), 'N/A') AS wug_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.wug_bez END), wug_bez_de) AS wug_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.wug_bez END), wug_bez_de) AS wug_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.wug_bez END), wug_bez_de) AS wug_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.wug_bez END), wug_bez_de) AS wug_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.wug_bez END), wug_bez_de) AS wug_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.wug_bez END), wug_bez_de) AS wug_bez_bg
FROM dbp_view.v_wug_spr_zu_1 v01
WHERE v01.mandant_id <> 1
AND v01.arthiertyp_id = 2
GROUP BY
 v01.mandant_id
,v01.wg_id
,v01.wug_id
,v01.arthiertyp_id
;