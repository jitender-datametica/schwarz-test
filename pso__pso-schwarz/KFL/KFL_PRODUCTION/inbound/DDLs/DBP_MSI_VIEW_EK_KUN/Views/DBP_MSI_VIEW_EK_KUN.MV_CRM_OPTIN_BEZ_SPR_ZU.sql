CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_CRM_OPTIN_BEZ_SPR_ZU

AS 
SELECT 
  crm_optin_bez_id
, MAX(CASE WHEN spr_id =  24 THEN crm_optin_bez END) AS crm_optin_bez_en --EN
, COALESCE(MAX(CASE WHEN spr_id = 22   THEN crm_optin_bez END), crm_optin_bez_en) AS crm_optin_bez --DE (standard)
, COALESCE(MAX(CASE WHEN spr_id = 124 THEN crm_optin_bez END), crm_optin_bez_en) AS crm_optin_bez_cz -- CZ
, COALESCE(MAX(CASE WHEN spr_id = 108 THEN crm_optin_bez END), crm_optin_bez_en) AS crm_optin_bez_sk -- SK
, COALESCE(MAX(CASE WHEN spr_id = 65   THEN crm_optin_bez END), crm_optin_bez_en) AS crm_optin_bez_hr -- HR
, COALESCE(MAX(CASE WHEN spr_id = 90   THEN crm_optin_bez END), crm_optin_bez_en) AS crm_optin_bez_pl -- PL
, COALESCE(MAX(CASE WHEN spr_id = 95   THEN crm_optin_bez END), crm_optin_bez_en) AS crm_optin_bez_ro -- RO
, COALESCE(MAX(CASE WHEN spr_id = 18   THEN crm_optin_bez END), crm_optin_bez_en) AS crm_optin_bez_bg -- BG
FROM dbp_view.v_crm_optin_bez_spr_zu
GROUP BY
  crm_optin_bez_id
  ;