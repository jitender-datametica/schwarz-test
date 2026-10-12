CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_fremdkoerper_spr_zu_2 (
crm_fremdkoerper_id INTEGER NOT NULL OPTIONS(description='Art_2 der Verunreinigung ID'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
crm_fremdkoerper_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Fremdkörper Bezeichnung DWH generiert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_fremdkoerper_id, spr_id) NOT ENFORCED
) OPTIONS(description='KMR - Sprachzuordnungstabelle Fremdkörper - MS Dynamics CRM');