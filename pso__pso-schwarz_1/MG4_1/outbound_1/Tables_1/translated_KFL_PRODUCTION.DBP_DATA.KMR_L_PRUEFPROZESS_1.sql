CREATE OR REPLACE TABLE kfl_production_dbp_data.kmr_l_pruefprozess_1 (
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.'),
gepr_prozess_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Geprüfter Prozess-ID. Quellfeld audit_universe_audited_process_id_audit_level.'),
gepr_prozess_imp_referenz STRING(255) DEFAULT ' ' NOT NULL
OPTIONS(description='Geprüfter Prozess Importreferenz. Quellfeld audit_universe_audited_process_imp_reference_audit_level.'),
gepr_prozess_bez STRING(255) DEFAULT ' ' NOT NULL
OPTIONS(description='Geprüfter Prozess-Bezeichnung. Quellfeld audit_universe_audited_process_name_audit_level.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (gepr_prozess_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='KMR - Lookup table for the audited process (geprüfter Prozess, vom Fachbereich oft auch\"Prüfprozess\" genannt). Hierarchically comprehensive definition of the audited process.\"What was audited? (Was wurde geprüft?)\" Does not include\"Kurzchecks\". Source view v_dwh_kl_data_auditing.');