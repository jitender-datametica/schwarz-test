create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_CRM_L_KONTO_2(
	CRM_KONTO_ID,
	CRM_KUNDE_ID,
	CRM_KONTO_TYP_ID,
	CRM_KUNDENPROGRAMM_ID,
	ZEIT_VON,
	ZEIT_BIS,
	DAT_BIS,
	GELOESCHT_FG_KONTO
) as
SELECT 
 crm_konto_id
,crm_kunde_id
,crm_konto_typ_id
,crm_kundenprogramm_id
,zeit_von
,zeit_bis 
,CAST(zeit_bis AS DATE) AS dat_bis
,geloescht_fg AS geloescht_fg_konto
FROM dbp_view.v_crm_l_konto_2
;