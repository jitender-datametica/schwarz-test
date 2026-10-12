CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_CRM_OPTIN_KANAL_SPR_ZU_1
--AP0146745/SPEC0173850 Umbennenung optin_kanal_bez 709250006 / sschuecke 24.10.2022
(
 crm_optin_kanal_id
,crm_optin_kanal_bez_en
,crm_optin_kanal_bez
,crm_optin_kanal_bez_cz
,crm_optin_kanal_bez_sk
,crm_optin_kanal_bez_hr
,crm_optin_kanal_bez_pl
,crm_optin_kanal_bez_ro
,crm_optin_kanal_bez_bg
)
AS
SELECT
  crm_optin_kanal_cd AS crm_optin_kanal_id
, MAX(CASE WHEN spr_id =  24            THEN crm_optin_kanal_bez END) AS crm_optin_kanal_bez_en      --EN
, COALESCE(MAX(CASE WHEN spr_id = 22    THEN crm_optin_kanal_bez END), crm_optin_kanal_bez_en) AS crm_optin_kanal_bez        --DE (Standard)
, COALESCE(MAX(CASE WHEN spr_id = 124   THEN crm_optin_kanal_bez END), crm_optin_kanal_bez_en) AS crm_optin_kanal_bez_cz    -- CZ
, COALESCE(MAX(CASE WHEN spr_id = 108   THEN crm_optin_kanal_bez END), crm_optin_kanal_bez_en) AS crm_optin_kanal_bez_sk    -- SK
, COALESCE(MAX(CASE WHEN spr_id = 65    THEN crm_optin_kanal_bez END), crm_optin_kanal_bez_en) AS crm_optin_kanal_bez_hr    -- HR
, COALESCE(MAX(CASE WHEN spr_id = 90    THEN crm_optin_kanal_bez END), crm_optin_kanal_bez_en) AS crm_optin_kanal_bez_pl    -- PL
, COALESCE(MAX(CASE WHEN spr_id = 95    THEN crm_optin_kanal_bez END), crm_optin_kanal_bez_en) AS crm_optin_kanal_bez_ro    -- RO
, COALESCE(MAX(CASE WHEN spr_id = 18    THEN crm_optin_kanal_bez END), crm_optin_kanal_bez_en) AS crm_optin_kanal_bez_bg    -- BG
FROM dbp_data.crm_optin_kanal_spr_zu_1
GROUP BY
 crm_optin_kanal_cd
 ;