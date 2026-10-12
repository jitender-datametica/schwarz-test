CREATE OR REPLACE TABLE kfl_production_dbp_data.kmr_l_pruefung_standort (
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.'),
standort_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Standort-ID. Quellfeld auditing_location_id.'),
standort_bez STRING(255) DEFAULT ' ' NOT NULL
OPTIONS(description='Standort-Bezeichnung. Quellfeld auditing_location_name.'),
standort_typ_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Standorttyp-ID. Quellfeld auditing_location_type_id.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (standort_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='KMR - Lookup table for the location (Standort), Does not include\"Kurzchecks\". Source view v_dwh_kl_data_auditing.');