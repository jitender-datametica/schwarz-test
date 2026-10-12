create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_CRM_L_OPTIN_2(
	CRM_OPTIN_ID,
	CRM_OPTIN_TYP_ID,
	CRM_OPTIN_HERKUNFT_ID,
	CRM_OPTIN_KANAL_ID,
	CRM_OPTIN_BEZ_ID
) as
SELECT

  crm_optin_id
, crm_optin_typ_id
, crm_optin_herkunft_id
, crm_optin_kanal_id
, crm_optin_bez_id

FROM dbp_view.v_crm_l_optin_2
;