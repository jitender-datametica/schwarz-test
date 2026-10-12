CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_l_eingangskanal (
crm_eingangskanal_id INTEGER NOT NULL OPTIONS(description='Eingangskanal ID - z.B. Telefon, Email, etc.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_eingangskanal_id) NOT ENFORCED
) OPTIONS(description='KMR - Lookup für Eingangskanal - MS Dynamics CRM');