CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_optin_statusgrund_spr_zu_2 (crm_optin_statusgrund_cd
OPTIONS(description='Statusgrund-Code des Optins (liefert Information darüber, ob Erlaubnis erteilt, Erlaubnis nicht erteilt).'),
spr_id OPTIONS(description='ID der Sprache'), crm_optin_statusgrund_bez
OPTIONS(description='Statusgrund-Bezeichnung des Optins.'))
OPTIONS(DESCRIPTION = `CRM - SPRACHTABELLE FUER OPTIN-STATUSGRUND AUS COSMOS DB CRM.`) AS SELECT
 crm_optin_statusgrund_cd,
 spr_id,
 crm_optin_statusgrund_bez
FROM kfl_production_dbp_data.crm_optin_statusgrund_spr_zu_2;