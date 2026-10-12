CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_eigenmarke_spr_zu (
crm_eigenmarke_id INTEGER NOT NULL OPTIONS(description='Eigenmarke ID'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
crm_eigenmarke_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Eigenmarke Bezeichnung DWH generiert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_eigenmarke_id, spr_id) NOT ENFORCED
) OPTIONS(description='KMR - Sprachzuordnungstabelle Eigenmarke - MS Dynamics CRM');