create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_CRM_OPTIN_KANAL_SPR_ZU_2(
	CRM_OPTIN_KANAL_ID,
	CRM_OPTIN_KANAL_BEZ_EN,
	CRM_OPTIN_KANAL_BEZ,
	CRM_OPTIN_KANAL_BEZ_CZ,
	CRM_OPTIN_KANAL_BEZ_SK,
	CRM_OPTIN_KANAL_BEZ_HR,
	CRM_OPTIN_KANAL_BEZ_PL,
	CRM_OPTIN_KANAL_BEZ_RO,
	CRM_OPTIN_KANAL_BEZ_BG
) as
SELECT
  crm_optin_kanal_id
, MAX(CASE WHEN spr_id =  24 AND crm_optin_kanal_id = '709250006' THEN 'Strong Alcohol_PL' ELSE crm_optin_kanal_bez END) AS crm_optin_kanal_bez_en --EN
, COALESCE(MAX(CASE WHEN spr_id = 22  AND crm_optin_kanal_id = '709250006' THEN 'Strong Alcohol_PL' ELSE crm_optin_kanal_bez END), crm_optin_kanal_bez_en) AS crm_optin_kanal_bez --DE (standard)
, COALESCE(MAX(CASE WHEN spr_id = 124 AND crm_optin_kanal_id = '709250006' THEN 'Strong Alcohol_PL' ELSE crm_optin_kanal_bez END), crm_optin_kanal_bez_en) AS crm_optin_kanal_bez_cz -- CZ
, COALESCE(MAX(CASE WHEN spr_id = 108 AND crm_optin_kanal_id = '709250006' THEN 'Strong Alcohol_PL' ELSE crm_optin_kanal_bez END), crm_optin_kanal_bez_en) AS crm_optin_kanal_bez_sk -- SK
, COALESCE(MAX(CASE WHEN spr_id = 65  AND crm_optin_kanal_id = '709250006' THEN 'Strong Alcohol_PL' ELSE crm_optin_kanal_bez END), crm_optin_kanal_bez_en) AS crm_optin_kanal_bez_hr -- HR
, COALESCE(MAX(CASE WHEN spr_id = 90  AND crm_optin_kanal_id = '709250006' THEN 'Strong Alcohol_PL' ELSE crm_optin_kanal_bez END), crm_optin_kanal_bez_en) AS crm_optin_kanal_bez_pl -- PL
, COALESCE(MAX(CASE WHEN spr_id = 95  AND crm_optin_kanal_id = '709250006' THEN 'Strong Alcohol_PL' ELSE crm_optin_kanal_bez END), crm_optin_kanal_bez_en) AS crm_optin_kanal_bez_ro -- RO
, COALESCE(MAX(CASE WHEN spr_id = 18  AND crm_optin_kanal_id = '709250006' THEN 'Strong Alcohol_PL' ELSE crm_optin_kanal_bez END), crm_optin_kanal_bez_en) AS crm_optin_kanal_bez_bg -- BG
FROM dbp_view.v_crm_optin_kanal_spr_zu_2
GROUP BY
 crm_optin_kanal_id
 ;