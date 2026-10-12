CREATE OR REPLACE TABLE kfl_production_dbp_data.kmr_l_frage_status_1 (
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.'),
frage_status_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Status_1-ID. Quellfeld guideline_state_id.'),
frage_status_bez STRING(255) DEFAULT ' ' NOT NULL
OPTIONS(description='Status_1-Bezeichnung. Quellfeld guideline_state_name.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (frage_status_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='KMR - Lookup table for the status_1 of a question / guideline check during the audit process. Does not contain\"Kurzchecks\". Source view v_dwh_kl_data_guideline.');