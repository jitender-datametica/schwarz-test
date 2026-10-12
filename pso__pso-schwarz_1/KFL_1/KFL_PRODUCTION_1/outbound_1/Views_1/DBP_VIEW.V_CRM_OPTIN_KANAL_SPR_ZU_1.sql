CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_optin_kanal_spr_zu_1 (crm_optin_kanal_cd
OPTIONS(description='CRM-interne Code für den Kanal des Optins.'), spr_id OPTIONS(description='ID der Sprache'),
crm_optin_kanal_bez OPTIONS(description='Bezeichnug für den Kanal des Optins.'))
OPTIONS(DESCRIPTION = `CRM - SPRACHTABELLE FUER DIE OPT-IN KANÄLE AUS COSMOS DB CRM.`) AS SELECT crm_optin_kanal_cd,
 spr_id,
 crm_optin_kanal_bez
FROM kfl_production_dbp_data.crm_optin_kanal_spr_zu_1;