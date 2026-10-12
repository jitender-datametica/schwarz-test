CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_gutschein_grund_spr_zu_1 (
crm_gutschein_grund_id INTEGER NOT NULL OPTIONS(description='Grund der Gutscheinausgabe ID'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
crm_gutschein_grund_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Grund für Gutschein_1 Bezeichnung DWH generiert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_gutschein_grund_id, spr_id) NOT ENFORCED
) OPTIONS(description='KMR - Sprachzuordnungstabelle Grund für Gutscheine aus CRM - MS Dynamics CRM');