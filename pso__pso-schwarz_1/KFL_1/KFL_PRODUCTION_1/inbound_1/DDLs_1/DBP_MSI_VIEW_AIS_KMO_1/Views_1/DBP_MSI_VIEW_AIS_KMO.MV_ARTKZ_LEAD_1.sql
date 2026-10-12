CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ARTKZ_LEAD_1
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_1 / ssch1303 02.02.2022
(
 mandant_id
,lead_id
,lead_bez
,lead_bez_de
,lead_bez_cz
,lead_bez_sk
,lead_bez_hr
,lead_bez_pl
,lead_bez_ro
,lead_bez_bg
)

AS
SELECT
 v01.mandant_id
,v01.lead_id
,COALESCE(MAX(CASE WHEN v01.spr_id = 22  THEN v01.lead_bez END), 'N/A')  AS lead_bez
,COALESCE(MAX(CASE WHEN v01.spr_id = 22  THEN v01.lead_bez END), 'N/A')  AS lead_bez_de
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.lead_bez END), lead_bez_de)  AS lead_bez_cz
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.lead_bez END), lead_bez_de)  AS lead_bez_sk
,COALESCE(MAX(CASE WHEN v01.spr_id = 65  THEN v01.lead_bez END), lead_bez_de)  AS lead_bez_hr
,COALESCE(MAX(CASE WHEN v01.spr_id = 90  THEN v01.lead_bez END), lead_bez_de)  AS lead_bez_pl
,COALESCE(MAX(CASE WHEN v01.spr_id = 95  THEN v01.lead_bez END), lead_bez_de)  AS lead_bez_ro
,COALESCE(MAX(CASE WHEN v01.spr_id = 18  THEN v01.lead_bez END), lead_bez_de)  AS lead_bez_bg

FROM dbp_view.v_artkz_lead_1 v01

WHERE v01.mandant_id <> 1
GROUP BY
 v01.mandant_id
,v01.lead_id
;