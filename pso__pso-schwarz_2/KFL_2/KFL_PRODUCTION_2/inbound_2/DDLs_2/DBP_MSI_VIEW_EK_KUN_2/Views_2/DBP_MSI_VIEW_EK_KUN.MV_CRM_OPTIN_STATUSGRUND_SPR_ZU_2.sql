CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_CRM_OPTIN_STATUSGRUND_SPR_ZU_2
(
	OPTIN_STATUSGRUND_ID,
	OPTIN_STATUSGRUND_BEZ,
	OPTIN_STATUSGRUND_BEZ_DE,
	OPTIN_STATUSGRUND_BEZ_EN,
	OPTIN_STATUSGRUND_BEZ_CZ,
	OPTIN_STATUSGRUND_BEZ_SK,
	OPTIN_STATUSGRUND_BEZ_HR,
	OPTIN_STATUSGRUND_BEZ_PL,
	OPTIN_STATUSGRUND_BEZ_RO,
	OPTIN_STATUSGRUND_BEZ_BG
) 
AS
SELECT 
 crm_optin_statusgrund_cd AS optin_statusgrund_id
, MAX(CASE WHEN spr_id = 22   THEN crm_optin_statusgrund_bez END) AS optin_statusgrund_bez --standard
, MAX(CASE WHEN spr_id = 22   THEN crm_optin_statusgrund_bez END) AS optin_statusgrund_bez_de --DE (for coalesce only)
, COALESCE(MAX(CASE WHEN spr_id =  24 THEN crm_optin_statusgrund_bez END), optin_statusgrund_bez_de) AS optin_statusgrund_bez_en --EN
, COALESCE(COALESCE(MAX(CASE WHEN spr_id = 124 THEN crm_optin_statusgrund_bez END), optin_statusgrund_bez_en), optin_statusgrund_bez_de) AS optin_statusgrund_bez_cz -- CZ
, COALESCE(COALESCE(MAX(CASE WHEN spr_id = 108 THEN crm_optin_statusgrund_bez END), optin_statusgrund_bez_en), optin_statusgrund_bez_de) AS optin_statusgrund_bez_sk -- SK
, COALESCE(COALESCE(MAX(CASE WHEN spr_id = 65   THEN crm_optin_statusgrund_bez END), optin_statusgrund_bez_en), optin_statusgrund_bez_de) AS optin_statusgrund_bez_hr -- HR
, COALESCE(COALESCE(MAX(CASE WHEN spr_id = 90   THEN crm_optin_statusgrund_bez END), optin_statusgrund_bez_en), optin_statusgrund_bez_de) AS optin_statusgrund_bez_pl -- PL
, COALESCE(COALESCE(MAX(CASE WHEN spr_id = 95   THEN crm_optin_statusgrund_bez END), optin_statusgrund_bez_en), optin_statusgrund_bez_de) AS optin_statusgrund_bez_ro -- RO
, COALESCE(COALESCE(MAX(CASE WHEN spr_id = 18   THEN crm_optin_statusgrund_bez END), optin_statusgrund_bez_en), optin_statusgrund_bez_de) AS optin_statusgrund_bez_bg -- BG
FROM DBP_DATA.CRM_OPTIN_STATUSGRUND_SPR_ZU_2
GROUP BY
 crm_optin_statusgrund_cd
 ;