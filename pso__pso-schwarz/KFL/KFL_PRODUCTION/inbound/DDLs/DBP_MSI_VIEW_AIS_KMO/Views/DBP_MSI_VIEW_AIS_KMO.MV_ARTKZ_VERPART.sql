CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ARTKZ_VERPART
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU / ssch1303 02.02.2022
(
 mandant_id
,verpart_id
,verpart_bez
,verpart_bez_de
,verpart_bez_cz
,verpart_bez_sk
,verpart_bez_hr
,verpart_bez_pl
,verpart_bez_ro
,verpart_bez_bg
)

AS
SELECT
 v01.mandant_id
,v01.verpart_id
,COALESCE(MAX(CASE WHEN v01.spr_id = 22  THEN v01.verpart_bez END), 'N/A')  AS verpart_bez
,COALESCE(MAX(CASE WHEN v01.spr_id = 22  THEN v01.verpart_bez END), 'N/A')  AS verpart_bez_de
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.verpart_bez END), verpart_bez_de)  AS verpart_bez_cz
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.verpart_bez END), verpart_bez_de)  AS verpart_bez_sk
,COALESCE(MAX(CASE WHEN v01.spr_id = 65  THEN v01.verpart_bez END), verpart_bez_de)  AS verpart_bez_hr
,COALESCE(MAX(CASE WHEN v01.spr_id = 90  THEN v01.verpart_bez END), verpart_bez_de)  AS verpart_bez_pl
,COALESCE(MAX(CASE WHEN v01.spr_id = 95  THEN v01.verpart_bez END), verpart_bez_de)  AS verpart_bez_ro
,COALESCE(MAX(CASE WHEN v01.spr_id = 18  THEN v01.verpart_bez END), verpart_bez_de)  AS verpart_bez_bg

FROM dbp_view.v_artkz_verpart v01

WHERE v01.mandant_id <> 1
GROUP BY
 v01.mandant_id
,v01.verpart_id
;