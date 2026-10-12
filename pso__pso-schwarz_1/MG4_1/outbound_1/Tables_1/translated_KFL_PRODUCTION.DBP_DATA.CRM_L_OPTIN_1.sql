CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_l_optin_1 (
crm_optin_id STRING(144) NOT NULL OPTIONS(description='CRM-interne ID für ein Optin '),
crm_optin_typ_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='CRM-interne ID für den Typ des Optins (bspw. Email, Mobile Phone, Telephone...)'),
crm_optin_herkunft_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='CRM-interne ID für die Herkunft/den Ursprung des Optins (fast alle Optins sollten den Ursrung in der Loyalty App haben)'),
crm_optin_kanal_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='CRM-interne ID für den Kanal des Optins'),
crm_optin_bez_id INTEGER DEFAULT - 9999 NOT NULL
OPTIONS(description='ID zur Bezeichnung des Optins. Bezeichnungen sind generisch, bspw. SMS, Terms and Conditions etc.'),
td_insert TIMESTAMP,
td_update TIMESTAMP
) OPTIONS(description='CRM - Enthält Daten der Entität\"Arvato_optin\" (Optin) aus MS Dynamics CRM');