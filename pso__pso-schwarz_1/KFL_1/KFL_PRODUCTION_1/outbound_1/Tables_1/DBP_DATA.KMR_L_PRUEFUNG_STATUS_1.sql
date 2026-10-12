--==============================================================
-- Table: kmr_l_pruefung_status_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_pruefung_status_1
   generated from Powerdesigner on Freitag, 17. Februar 2023 16:14:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_l_pruefung_status_1 (
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.'),
pruefung_status_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Prüfungsstatus-ID. Quellfeld auditing_state.'),
pruefung_status_bez STRING(255) DEFAULT ' ' NOT NULL
OPTIONS(description='Prüfungsstatus-Bezeichnung. Quellfeld auditing_state_name.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (pruefung_status_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='KMR - Lookup table for the auditing state (Pruefungsstatus). Does not include "Kurzchecks". Source view v_dwh_kl_data_auditing.');