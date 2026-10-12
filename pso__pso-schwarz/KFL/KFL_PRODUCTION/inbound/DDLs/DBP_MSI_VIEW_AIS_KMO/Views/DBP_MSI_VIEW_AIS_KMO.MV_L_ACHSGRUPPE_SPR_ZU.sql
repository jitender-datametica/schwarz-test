CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_ACHSGRUPPE_SPR_ZU
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU / ssch1303 01.02.2022
(
 mandant_id
,achsgruppe_id
,achsgruppe_bez
,achsgruppe_bez_de
,achsgruppe_bez_cz
,achsgruppe_bez_sk
,achsgruppe_bez_hr
,achsgruppe_bez_pl
,achsgruppe_bez_ro
,achsgruppe_bez_bg
)

AS
SELECT
 v01.mandant_id
,v01.achsgruppe_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.achsgruppe_bez END), 'N/A') AS achsgruppe_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.achsgruppe_bez END), 'N/A') AS achsgruppe_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.achsgruppe_bez END), achsgruppe_bez_de) AS achsgruppe_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.achsgruppe_bez END), achsgruppe_bez_de) AS achsgruppe_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.achsgruppe_bez END), achsgruppe_bez_de) AS achsgruppe_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.achsgruppe_bez END), achsgruppe_bez_de) AS achsgruppe_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.achsgruppe_bez END), achsgruppe_bez_de) AS achsgruppe_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.achsgruppe_bez END), achsgruppe_bez_de) AS achsgruppe_bez_bg

FROM dbp_view.v_achsgruppe_spr_zu v01

WHERE mandant_id <> 1

GROUP BY
 v01.mandant_id
,v01.achsgruppe_id;