CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_KOMPONENTE_ART_SPR_ZU
--- 03.01.2012 AL Erstellt analog mv_art_spr_zu Artikel mit einer Eingeschränkung auf die Komponenten
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU / ssch1303 01.02.2022
(
 mandant_id
,komponente_art_id
,komponente_kl_art_id
,komponente_art_bez
,komponente_art_bez_de
,komponente_art_bez_cz
,komponente_art_bez_sk
,komponente_art_bez_hr
,komponente_art_bez_pl
,komponente_art_bez_ro
,komponente_art_bez_bg
)

AS
SELECT
 v01.mandant_id
,v01.art_id AS komponente_art_id
,v02.kl_art_id AS komponente_kl_art_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.art_bez END), 'N/A') AS komponente_art_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.art_bez END), 'N/A') AS komponente_art_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.art_bez END), komponente_art_bez_de) AS komponente_art_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.art_bez END), komponente_art_bez_de) AS komponente_art_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.art_bez END), komponente_art_bez_de) AS komponente_art_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.art_bez END), komponente_art_bez_de) AS komponente_art_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.art_bez END), komponente_art_bez_de) AS komponente_art_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.art_bez END), komponente_art_bez_de) AS komponente_art_bez_bg

FROM dbp_view.v_art_spr_zu v01

JOIN dbp_view.v_art v02
ON (v01.art_id = v02.art_id
AND v01.mandant_id = v02.mandant_id)

WHERE v01.mandant_id <> 1 
AND(v01.mandant_id, v01.art_id) IN 
(SELECT 
 mandant_id
,art_id 
FROM dbp_view.v_stueckliste_det)

GROUP BY
 v01.mandant_id
,v01.art_id
,v02.kl_art_id
;