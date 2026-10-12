CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_l_eigenmarke (
crm_eigenmarke_id INTEGER NOT NULL OPTIONS(description='Eigenmarke ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_eigenmarke_id) NOT ENFORCED
) OPTIONS(description='KMR - Lookup für die Kaufland Eigenmarken - MS Dynamics CRM');