--==============================================================
-- Table: kmr_l_pruefung_klasse
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_pruefung_klasse
   generated from Powerdesigner on Freitag, 17. Februar 2023 16:16:57
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_l_pruefung_klasse (
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.'),
pruefung_klasse_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Prüfungsklasse / -art-ID. Quellfeld auditing_auditing_class_id.'),
pruefung_klasse_bez STRING(255) DEFAULT ' ' NOT NULL
OPTIONS(description='Prüfungsklasse / -art-Bezeichnung. Quellfeld auditing_auditing_class_name.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (pruefung_klasse_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='KMR - Lookup table for the audit class (Pruefungsklasse/-art). Does not include "Kurzchecks". Source view v_dwh_kl_data_auditing.');