CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_l_kundenprogramm (
crm_kundenprogramm_id STRING(144) NOT NULL
OPTIONS(description='CRM-interne ID des Loyaltypogramms/Kundenkartenprogramms. Ein Konto (crm_l_konto.crm_konto_id) ist stets einem Kundenprogramm zugeordnet.'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
td_insert TIMESTAMP,
td_update TIMESTAMP
) OPTIONS(description='EK-KUN - MSDynamicsCRM - Daten der Entität\"Loyaltyprogram\" (Kundenkartenprogramm)');