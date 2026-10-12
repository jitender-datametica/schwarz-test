CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_l_kundenprogramm_2 (
crm_kundenprogramm_id STRING(144) NOT NULL
OPTIONS(description='CRM-interne ID des Loyaltypogramms/Kundenkartenprogramms. Ein Konto_2 (crm_l_konto.crm_konto_id) ist stets einem Kundenprogramm zugeordnet.'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
td_insert TIMESTAMP,
td_update TIMESTAMP
) OPTIONS(description='EK-KUN - MSDynamicsCRM - Daten der Entität\"Loyaltyprogram\" (Kundenkartenprogramm)');