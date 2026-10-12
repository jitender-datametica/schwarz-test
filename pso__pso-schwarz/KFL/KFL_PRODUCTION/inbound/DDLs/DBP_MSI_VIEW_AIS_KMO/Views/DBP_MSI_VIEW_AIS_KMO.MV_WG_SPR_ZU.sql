CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_WG_SPR_ZU
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU / ssch1303 01.02.2022
(
 mandant_id
,wg_id
,arthiertyp_id
,wg_bez
,wg_bez_de
,wg_bez_cz
,wg_bez_sk
,wg_bez_hr
,wg_bez_pl
,wg_bez_ro
,wg_bez_bg
)

AS
SELECT
 v01.mandant_id
,v01.wg_id
,v01.arthiertyp_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.wg_bez END), 'N/A') AS wg_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.wg_bez END), 'N/A') AS wg_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.wg_bez END), wg_bez_de) AS wg_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.wg_bez END), wg_bez_de) AS wg_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.wg_bez END), wg_bez_de) AS wg_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.wg_bez END), wg_bez_de) AS wg_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.wg_bez END), wg_bez_de) AS wg_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.wg_bez END), wg_bez_de) AS wg_bez_bg

FROM dbp_view.v_wg_spr_zu v01

WHERE v01.mandant_id <> 1
AND v01.arthiertyp_id = 2
GROUP BY
 v01.mandant_id
,v01.wg_id
,v01.arthiertyp_id
;