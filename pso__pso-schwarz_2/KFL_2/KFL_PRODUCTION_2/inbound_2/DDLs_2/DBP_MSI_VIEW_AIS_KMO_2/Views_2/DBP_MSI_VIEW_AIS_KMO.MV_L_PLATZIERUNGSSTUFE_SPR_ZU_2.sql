CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_PLATZIERUNGSSTUFE_SPR_ZU_2
-- Anfo #597332 Ausschluss der Unter PST, damit in Aggregat nicht gelöscht werden muss / 09.07.2014 sschuecke
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_2 / ssch1303 01.02.2022
(
 mandant_id
,platzierungsstufe_id
,platzierungsstufe_bez
,platzierungsstufe_bez_de
,platzierungsstufe_bez_cz
,platzierungsstufe_bez_sk
,platzierungsstufe_bez_hr
,platzierungsstufe_bez_pl
,platzierungsstufe_bez_ro
,platzierungsstufe_bez_bg
)

AS
SELECT
 v01.mandant_id
,v01.platzierungsstufe_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.platzierungsstufe_bez END), 'N/A') AS platzierungsstufe_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.platzierungsstufe_bez END), 'N/A') AS platzierungsstufe_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.platzierungsstufe_bez END), platzierungsstufe_bez_de) AS platzierungsstufe_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.platzierungsstufe_bez END), platzierungsstufe_bez_de) AS platzierungsstufe_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.platzierungsstufe_bez END), platzierungsstufe_bez_de) AS platzierungsstufe_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.platzierungsstufe_bez END), platzierungsstufe_bez_de) AS platzierungsstufe_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.platzierungsstufe_bez END), platzierungsstufe_bez_de) AS platzierungsstufe_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.platzierungsstufe_bez END), platzierungsstufe_bez_de) AS platzierungsstufe_bez_bg

FROM dbp_view.v_platzierungsstufe_spr_zu_2 v01

WHERE mandant_id <>1 
AND (SUBSTRING(platzierungsstufe_id, 1, 1) IN ('X', 'Y', 'Z')
OR (SUBSTRING(platzierungsstufe_id, 1, 1) NOT IN ('X', 'Y', 'Z') AND SUBSTRING(platzierungsstufe_id, 3, 1) = 0))

GROUP BY
 v01.mandant_id
,v01.platzierungsstufe_id
;