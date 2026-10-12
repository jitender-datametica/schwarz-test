CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_l_fremdkoerper_1 (
crm_fremdkoerper_id INTEGER NOT NULL OPTIONS(description='Art_1 der Verunreinigung ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_fremdkoerper_id) NOT ENFORCED
) OPTIONS(description='KMR - Lookup für Fremdkörper - MS Dynamics CRM');