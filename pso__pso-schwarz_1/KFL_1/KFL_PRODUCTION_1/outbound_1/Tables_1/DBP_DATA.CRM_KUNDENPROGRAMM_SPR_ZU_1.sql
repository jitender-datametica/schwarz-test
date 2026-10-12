CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_kundenprogramm_spr_zu_1 (
crm_kundenprogramm_id STRING(144) NOT NULL
OPTIONS(description='CRM-interne ID des Loyaltypogramms/Kundenkartenprogramms. Ein Konto_1 (crm_l_konto.crm_konto_id) ist stets einem Kundenprogramm zugeordnet.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
crm_kundenprogramm_bez STRING(120) OPTIONS(description='Bezeichnung des Loyaltypogramms/Kundenkartenprogramms'),
td_insert TIMESTAMP,
td_update TIMESTAMP
) OPTIONS(description='CRM - Sprachtabelle für die Entität\"Arvato_Loyaltyaccount_1\" (Konto_1) aus MS Dynamics CRM');