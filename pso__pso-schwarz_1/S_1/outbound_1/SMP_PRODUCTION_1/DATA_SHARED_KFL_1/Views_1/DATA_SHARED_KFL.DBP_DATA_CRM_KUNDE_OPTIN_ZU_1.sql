CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_crm_kunde_optin_zu_1 (crm_kunde_id, crm_optin_id,
zeit_erstellung, zeit_aenderung, bonuspunkte_fg, optin_versions_url, crm_optin_statusgrund_cd, aktiv_fg, td_update,
td_insert) AS SELECT crm_kunde_id,
 crm_optin_id,
 zeit_erstellung,
 zeit_aenderung,
 bonuspunkte_fg,
 optin_versions_url,
 crm_optin_statusgrund_cd,
 aktiv_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.crm_kunde_optin_zu_1;