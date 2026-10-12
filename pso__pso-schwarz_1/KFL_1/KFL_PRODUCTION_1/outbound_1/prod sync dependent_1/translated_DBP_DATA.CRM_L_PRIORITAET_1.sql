CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_l_prioritaet_1 (
crm_prioritaet_id INTEGER NOT NULL OPTIONS(description='ID der Priorität, niedrig, mittel, hoch'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_prioritaet_id) NOT ENFORCED
) OPTIONS(description='KMR - Lookup für die Vorgangsprioritäten - MS Dynamics CRM');