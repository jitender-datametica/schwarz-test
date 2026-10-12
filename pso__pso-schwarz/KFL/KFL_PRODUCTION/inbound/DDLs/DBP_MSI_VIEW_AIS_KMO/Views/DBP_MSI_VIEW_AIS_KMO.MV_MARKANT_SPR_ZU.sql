CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_MARKANT_SPR_ZU
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU / ssch1303 01.02.2022
(
 mandant_id
,markant_id
,markant_bez
,markant_bez_de
,markant_bez_cz
,markant_bez_sk
,markant_bez_hr
,markant_bez_pl
,markant_bez_ro
,markant_bez_bg
)
AS 

SELECT 
 v01.mandant_id
,v01.markant_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.markant_bez END), 'N/A') AS markant_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.markant_bez END), 'N/A') AS markant_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.markant_bez END), markant_bez_de) AS markant_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.markant_bez END), markant_bez_de) AS markant_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.markant_bez END), markant_bez_de) AS markant_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.markant_bez END), markant_bez_de) AS markant_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.markant_bez END), markant_bez_de) AS markant_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.markant_bez END), markant_bez_de) AS markant_bez_bg

FROM dbp_view.v_markant_spr_zu v01
WHERE mandant_id <> 1
GROUP BY
 v01.mandant_id
,v01.markant_id
;