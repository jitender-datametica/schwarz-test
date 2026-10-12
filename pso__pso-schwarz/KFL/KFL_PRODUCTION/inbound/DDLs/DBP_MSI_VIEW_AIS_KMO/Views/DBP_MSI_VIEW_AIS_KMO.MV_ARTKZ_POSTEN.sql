CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ARTKZ_POSTEN
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU / ssch1303 02.02.2022
(
 mandant_id
,posten_id
,posten_bez
,posten_bez_de
,posten_bez_cz
,posten_bez_sk
,posten_bez_hr
,posten_bez_pl
,posten_bez_ro
,posten_bez_bg
)

AS
SELECT
 v01.mandant_id
,v01.posten_id
,COALESCE(MAX(CASE WHEN v01.spr_id = 22  THEN v01.posten_bez END), 'N/A')  AS posten_bez
,COALESCE(MAX(CASE WHEN v01.spr_id = 22  THEN v01.posten_bez END), 'N/A')  AS posten_bez_de
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.posten_bez END), posten_bez_de)  AS posten_bez_cz
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.posten_bez END), posten_bez_de)  AS posten_bez_sk
,COALESCE(MAX(CASE WHEN v01.spr_id = 65  THEN v01.posten_bez END), posten_bez_de)  AS posten_bez_hr
,COALESCE(MAX(CASE WHEN v01.spr_id = 90  THEN v01.posten_bez END), posten_bez_de)  AS posten_bez_pl
,COALESCE(MAX(CASE WHEN v01.spr_id = 95  THEN v01.posten_bez END), posten_bez_de)  AS posten_bez_ro
,COALESCE(MAX(CASE WHEN v01.spr_id = 18  THEN v01.posten_bez END), posten_bez_de)  AS posten_bez_bg

FROM dbp_view.v_artkz_posten v01

WHERE v01.mandant_id <> 1
GROUP BY
 v01.mandant_id
,v01.posten_id
;