CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_kunde_optin_zu
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  crm_kunde_id,
  crm_optin_id,
  zeit_erstellung,
  DATE(zeit_erstellung) AS dat_erstellung,
  zeit_aenderung,
  DATE(zeit_aenderung) AS dat_aenderung,
  bonuspunkte_fg,
  optin_versions_url,
  crm_optin_statusgrund_cd AS optin_statusgrund_id,
  aktiv_fg,
  CASE
    WHEN crm_optin_statusgrund_cd = 'granted'
    THEN 1
    WHEN crm_optin_statusgrund_cd IN ('inquired', 'notGranted', 'inactive')
    THEN 2
    ELSE 0
  END AS optin_statusgrund_sort
FROM kfl_production_dbp_data.crm_kunde_optin_zu;