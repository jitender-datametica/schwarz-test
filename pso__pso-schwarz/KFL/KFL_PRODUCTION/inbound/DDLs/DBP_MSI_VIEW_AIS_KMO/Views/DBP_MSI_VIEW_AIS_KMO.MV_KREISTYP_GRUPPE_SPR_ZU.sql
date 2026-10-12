CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_KREISTYP_GRUPPE_SPR_ZU
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU / ssch1303 01.02.2022
(
 mandant_id
,kreistyp_gruppe_id
,kreistyp_gruppe_bez
,kreistyp_gruppe_bez_de
,kreistyp_gruppe_bez_cz
,kreistyp_gruppe_bez_sk
,kreistyp_gruppe_bez_hr
,kreistyp_gruppe_bez_pl
,kreistyp_gruppe_bez_ro
,kreistyp_gruppe_bez_bg
)

AS
SELECT
 v01.mandant_id
,v01.kreistyp_gruppe_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.kreistyp_gruppe_bez END), 'N/A') AS kreistyp_gruppe_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.kreistyp_gruppe_bez END), 'N/A') AS kreistyp_gruppe_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.kreistyp_gruppe_bez END), kreistyp_gruppe_bez_de) AS kreistyp_gruppe_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.kreistyp_gruppe_bez END), kreistyp_gruppe_bez_de) AS kreistyp_gruppe_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.kreistyp_gruppe_bez END), kreistyp_gruppe_bez_de) AS kreistyp_gruppe_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.kreistyp_gruppe_bez END), kreistyp_gruppe_bez_de) AS kreistyp_gruppe_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.kreistyp_gruppe_bez END), kreistyp_gruppe_bez_de) AS kreistyp_gruppe_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.kreistyp_gruppe_bez END), kreistyp_gruppe_bez_de) AS kreistyp_gruppe_bez_bg
FROM dbp_view.v_kreistyp_gruppe_spr_zu v01

WHERE
v01.mandant_id <> 1

GROUP BY
 v01.mandant_id
,v01.kreistyp_gruppe_id
;