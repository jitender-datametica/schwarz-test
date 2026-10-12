CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_schaedlingsart_spr_zu_2 (
crm_schaedlingsart_id INTEGER NOT NULL OPTIONS(description='Schädlingsart ID'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
crm_schaedlingsart_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Schädlingsart Bezeichnung DWH generiert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_schaedlingsart_id, spr_id) NOT ENFORCED
) OPTIONS(description='KMR - Sprachzuordnungstabelle Schädlingsart - MS Dynamics CRM');