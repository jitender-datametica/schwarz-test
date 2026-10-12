CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_EK_KUN.MV_CRM_KUNDE_OPTIN_ZU

TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_EK_KUN

AS
SELECT
 crm_kunde_id
,crm_optin_id
,zeit_erstellung
,CAST(zeit_erstellung AS DATE) dat_erstellung
,zeit_aenderung
,CAST(zeit_aenderung AS DATE) dat_aenderung
,bonuspunkte_fg
,optin_versions_url
,crm_optin_statusgrund_cd AS optin_statusgrund_id
,aktiv_fg
,(CASE WHEN crm_optin_statusgrund_cd = 'granted' THEN 1 
       WHEN crm_optin_statusgrund_cd IN ('inquired','notGranted','inactive') THEN 2 
       ELSE 0 
    END) AS optin_statusgrund_sort
    
FROM dbp_data.crm_kunde_optin_zu;