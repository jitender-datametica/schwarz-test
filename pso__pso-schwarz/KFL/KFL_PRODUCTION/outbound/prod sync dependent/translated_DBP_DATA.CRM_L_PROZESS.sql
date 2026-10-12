CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_l_prozess (
crm_prozess_id INTEGER NOT NULL OPTIONS(description='Prozess ID (GUID) aus CRM - oberste Stuffe der Hierarchie'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_prozess_id) NOT ENFORCED
) OPTIONS(description='KMR - Oberste Ebene der CRM Hierarchie - MS Dynamics CRM');