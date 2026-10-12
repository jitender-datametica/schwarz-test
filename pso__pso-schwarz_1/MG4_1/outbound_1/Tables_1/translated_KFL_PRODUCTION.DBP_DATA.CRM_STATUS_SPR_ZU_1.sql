CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_status_spr_zu_1 (
crm_status_id INTEGER NOT NULL OPTIONS(description='Ticket Status_1 ID z. B. Abgeschlossen'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
crm_status_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Status_1 Bezeichnung DWH generiert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_status_id, spr_id) NOT ENFORCED
) OPTIONS(description='KMR - Sprachzuordnungstabelle Statuscode - MS Dynamics CRM');