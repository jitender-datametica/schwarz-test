CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_optin_kanal_spr_zu_2 (
crm_optin_kanal_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='CRM-interne ID für den Kanal des Optins'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
crm_optin_kanal_bez STRING(120) OPTIONS(description='Bezeichnug für den Kanal des Optins'),
td_insert TIMESTAMP,
td_update TIMESTAMP
)
OPTIONS(description='CRM - Sprachtabelle für das Attribut\"Arvato_Optintypecode\" (Entität\"Arvato_optin\", Optin-Herkunft) aus MS Dynamics CRM');