CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_PREIS_AENDERUNG_SPR_ZU_2
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_2 / ssch1303 01.02.2022
(
 mandant_id
,preis_aend_grund_id
,preis_aend_grund_bez
,preis_aend_grund_bez_de
,preis_aend_grund_bez_cz
,preis_aend_grund_bez_sk
,preis_aend_grund_bez_hr
,preis_aend_grund_bez_pl
,preis_aend_grund_bez_ro
,preis_aend_grund_bez_bg
)

AS
SELECT
 v01.mandant_id
,v01.preis_aend_grund_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.preis_aend_grund_bez END), 'N/A') AS preis_aend_grund_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.preis_aend_grund_bez END), 'N/A') AS preis_aend_grund_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.preis_aend_grund_bez END), preis_aend_grund_bez_de) AS preis_aend_grund_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.preis_aend_grund_bez END), preis_aend_grund_bez_de) AS preis_aend_grund_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.preis_aend_grund_bez END), preis_aend_grund_bez_de) AS preis_aend_grund_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.preis_aend_grund_bez END), preis_aend_grund_bez_de) AS preis_aend_grund_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.preis_aend_grund_bez END), preis_aend_grund_bez_de) AS preis_aend_grund_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.preis_aend_grund_bez END), preis_aend_grund_bez_de) AS preis_aend_grund_bez_bg

FROM dbp_view.v_preis_aenderung_spr_zu_2 v01

WHERE v01.mandant_id <> 1
AND NOT (v01.preis_aend_grund_id = 7
AND v01.mandant_id  IN (3,6) )
GROUP BY
 v01.mandant_id
,v01.preis_aend_grund_id;