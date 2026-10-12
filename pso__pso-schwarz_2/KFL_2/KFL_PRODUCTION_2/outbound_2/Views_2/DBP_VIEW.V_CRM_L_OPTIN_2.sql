CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_l_optin_2 (crm_optin_id
OPTIONS(description='CRM-interne ID für ein Optin '), crm_loyalty_fg
OPTIONS(description='Sagt ob die Herkunft/ der Uprsung ist die Loyalty App.'), crm_optin_kanal_cd
OPTIONS(description='CRM-interne Code für den Kanal des Optins.'))
OPTIONS(DESCRIPTION = `CRM - ENTHAELT OPTIN DATEN AUS COSMOS DB CRM.`) AS SELECT crm_optin_id,
 crm_loyalty_fg,
 crm_optin_kanal_cd
FROM kfl_production_dbp_data.crm_l_optin_2;