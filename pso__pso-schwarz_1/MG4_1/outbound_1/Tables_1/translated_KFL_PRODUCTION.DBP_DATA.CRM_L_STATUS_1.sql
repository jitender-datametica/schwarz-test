CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_l_status_1 (
crm_status_id INTEGER NOT NULL OPTIONS(description='Ticket Status_1 ID z. B. Abgeschlossen'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_status_id) NOT ENFORCED
) OPTIONS(description='KMR - Lookup für den Vorgangsstatus - MS Dynamics CRM');