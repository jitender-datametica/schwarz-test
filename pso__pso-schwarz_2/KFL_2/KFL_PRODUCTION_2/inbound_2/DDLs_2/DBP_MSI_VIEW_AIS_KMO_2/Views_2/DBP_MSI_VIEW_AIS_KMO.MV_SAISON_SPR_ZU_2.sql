CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_SAISON_SPR_ZU_2
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_2 / ssch1303 01.02.2022
(
 mandant_id
,saison_id
,saison_bez
,saison_bez_de
,saison_bez_cz
,saison_bez_sk
,saison_bez_hr
,saison_bez_pl
,saison_bez_ro
,saison_bez_bg
)
AS

SELECT
 v01.mandant_id
,v01.saison_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.saison_bez END), 'N/A') AS saison_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.saison_bez END), 'N/A') AS saison_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.saison_bez END), saison_bez_de) AS saison_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.saison_bez END), saison_bez_de) AS saison_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.saison_bez END), saison_bez_de) AS saison_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.saison_bez END), saison_bez_de) AS saison_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.saison_bez END), saison_bez_de) AS saison_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.saison_bez END), saison_bez_de) AS saison_bez_bg
FROM dbp_view.v_saison_spr_zu_2 v01

WHERE v01.mandant_id <> 1
GROUP BY
 v01.mandant_id
,v01.saison_id
;