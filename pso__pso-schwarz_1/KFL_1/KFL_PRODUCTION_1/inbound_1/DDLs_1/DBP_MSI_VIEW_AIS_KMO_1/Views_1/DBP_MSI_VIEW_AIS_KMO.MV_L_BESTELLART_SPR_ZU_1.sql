CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_BESTELLART_SPR_ZU_1
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_1 / ssch1303 01.02.2022
(
 mandant_id
,bestellart_id
,bestellart_bez
,bestellart_bez_de
,bestellart_bez_cz
,bestellart_bez_sk
,bestellart_bez_hr
,bestellart_bez_pl
,bestellart_bez_ro
,bestellart_bez_bg
)

AS
SELECT
 v01.mandant_id
,v01.bestellart_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.bestellart_bez END), 'N/A') AS bestellart_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.bestellart_bez END), 'N/A') AS bestellart_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.bestellart_bez END), bestellart_bez_de) AS bestellart_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.bestellart_bez END), bestellart_bez_de) AS bestellart_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.bestellart_bez END), bestellart_bez_de) AS bestellart_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.bestellart_bez END), bestellart_bez_de) AS bestellart_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.bestellart_bez END), bestellart_bez_de) AS bestellart_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.bestellart_bez END), bestellart_bez_de) AS bestellart_bez_bg
FROM dbp_view.v_bestellart_spr_zu_1 v01

WHERE v01.mandant_id <>1

GROUP BY
 v01.mandant_id
,v01.bestellart_id;