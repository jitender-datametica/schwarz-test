create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_CRM_L_KUNDENPROGRAMM(
	CRM_KUNDENPROGRAMM_ID,
	MANDANT_ID,
	MANDANT_KBEZ
) as 
SELECT
v01.crm_kundenprogramm_id
,v01.mandant_id
,v02.mandant_kbez

FROM dbp_view.v_crm_l_kundenprogramm v01

JOIN dbp_view.v_mandant v02
ON (v01.mandant_id=v02.mandant_id)
;