CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_kunde_optin_zu_2 (crm_kunde_id, crm_optin_id, zeit_erstellung,
zeit_aenderung, bonuspunkte_fg, optin_versions_url, optin_statusgrund_id, aktiv_fg, td_insert, td_update) AS SELECT
 crm_kunde_id,
 crm_optin_id,
 zeit_erstellung,
 zeit_aenderung,
 bonuspunkte_fg,
 optin_versions_url,
 optin_statusgrund_id,
 aktiv_fg,
 td_insert,
 td_update
FROM kfl_production_dbp_data.crm_kunde_optin_zu_2;