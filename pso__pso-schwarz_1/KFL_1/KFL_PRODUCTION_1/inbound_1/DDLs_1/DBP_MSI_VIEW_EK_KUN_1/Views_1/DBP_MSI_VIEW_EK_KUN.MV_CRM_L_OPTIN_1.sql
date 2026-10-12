CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_CRM_L_OPTIN_1
(
	CRM_OPTIN_ID,
	CRM_LOYALTY_FG,
	CRM_OPTIN_KANAL_ID
) 
AS
SELECT
  crm_optin_id
, crm_loyalty_fg
, crm_optin_kanal_cd AS crm_optin_kanal_id

FROM dbp_data.crm_l_optin_1
;