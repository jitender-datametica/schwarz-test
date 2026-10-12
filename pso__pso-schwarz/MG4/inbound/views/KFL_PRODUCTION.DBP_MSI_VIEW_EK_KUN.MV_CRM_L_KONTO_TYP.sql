create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_CRM_L_KONTO_TYP(
	CRM_KONTO_TYP_ID
) as
SELECT
crm_konto_typ_id
FROM dbp_view.v_crm_l_konto_typ
;