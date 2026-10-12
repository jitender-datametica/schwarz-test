CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_PRODUKTGRUPPE_SPR_ZU_2
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_2 / ssch1303 01.02.2022
(
 mandant_id
,produktgruppe_id
,produktgruppe_bez
,produktgruppe_bez_de
,produktgruppe_bez_cz
,produktgruppe_bez_sk
,produktgruppe_bez_hr
,produktgruppe_bez_pl
,produktgruppe_bez_ro
,produktgruppe_bez_bg
)

AS
SELECT
 v01.mandant_id
,v01.produktgruppe_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.produktgruppe_bez END), 'N/A') AS produktgruppe_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.produktgruppe_bez END), 'N/A') AS produktgruppe_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.produktgruppe_bez END), produktgruppe_bez_de) AS produktgruppe_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.produktgruppe_bez END), produktgruppe_bez_de) AS produktgruppe_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.produktgruppe_bez END), produktgruppe_bez_de) AS produktgruppe_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.produktgruppe_bez END), produktgruppe_bez_de) AS produktgruppe_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.produktgruppe_bez END), produktgruppe_bez_de) AS produktgruppe_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.produktgruppe_bez END), produktgruppe_bez_de) AS produktgruppe_bez_bg

FROM dbp_view.v_produktgruppe_spr_zu_2 v01

WHERE v01.mandant_id  <>1

GROUP BY
 v01.mandant_id
,v01.produktgruppe_id
;