CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_PLATZIERUNGSWG_SPR_ZU_2
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_2 / ssch1303 01.02.2022
(
 mandant_id
,platzierungswg_id
,platzierungswg_nr
,platzierungswg_bez
,platzierungswg_bez_de
,platzierungswg_bez_cz
,platzierungswg_bez_sk
,platzierungswg_bez_hr
,platzierungswg_bez_pl
,platzierungswg_bez_ro
,platzierungswg_bez_bg
)

AS
SELECT
 v01.mandant_id
,v01.platzierungswg_id
,v03.platzierungswg_nr
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.platzierungswg_bez END), 'N/A') AS platzierungswg_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.platzierungswg_bez END), 'N/A') AS platzierungswg_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.platzierungswg_bez END), platzierungswg_bez_de) AS platzierungswg_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.platzierungswg_bez END), platzierungswg_bez_de) AS platzierungswg_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.platzierungswg_bez END), platzierungswg_bez_de) AS platzierungswg_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.platzierungswg_bez END), platzierungswg_bez_de) AS platzierungswg_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.platzierungswg_bez END), platzierungswg_bez_de) AS platzierungswg_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.platzierungswg_bez END), platzierungswg_bez_de) AS platzierungswg_bez_bg

FROM dbp_view.v_platzierungswg_spr_zu_2 v01

JOIN dbp_view.v_l_platzierungswg_2 v03
ON v01.mandant_id = v03.mandant_id
AND v01.platzierungswg_id = v03.platzierungswg_id

WHERE v01.mandant_id <>1

GROUP BY
 v01.mandant_id
,v01.platzierungswg_id
,v03.platzierungswg_nr
;