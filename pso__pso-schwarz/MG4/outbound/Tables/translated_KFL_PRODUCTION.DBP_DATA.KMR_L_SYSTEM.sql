CREATE OR REPLACE TABLE kfl_production_dbp_data.kmr_l_system (
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.'),
amx_system_bez STRING(20) DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung der unterschiedlichen AMX Systeme. Kein Quellfeld im View. Wird per Hand befüllt.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (amx_system_id) NOT ENFORCED
)
OPTIONS(description='KMR - Lookup table for the different AMX source systems (Core vs. Unternehmenssicherheit). Source view v_dwh_kl_data_auditing.');