CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_optin_bez_spr_zu_1 (
crm_optin_bez_id INTEGER DEFAULT - 9999 NOT NULL
OPTIONS(description='ID zur Bezeichnung des Optins. Bezeichnungen sind generisch, bspw. SMS, Terms and Conditions etc.'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
crm_optin_bez STRING(240)
OPTIONS(description='Bezeichnung des Optins. Bezeichnungen sind generisch, bspw. SMS, Terms and Conditions etc.'),
td_insert TIMESTAMP,
td_update TIMESTAMP
)
OPTIONS(description='CRM - Sprachtabelle für das Attribut\"Arvato_name\" (Entität\"Arvato_optin\", generische Optinbezeichnung) aus MS Dynamics CRM');