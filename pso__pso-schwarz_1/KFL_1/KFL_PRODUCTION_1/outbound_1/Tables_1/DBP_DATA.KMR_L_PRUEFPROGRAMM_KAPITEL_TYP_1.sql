--==============================================================
-- Table: kmr_l_pruefprogramm_kapitel_typ_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_pruefprogramm_kapitel_typ_1
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:51:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_l_pruefprogramm_kapitel_typ_1 (
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-Quellsystem-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.'),
kapitel_typ_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Kapiteltyp-ID. Quellfeld audit_universe_audited_process_id_current_level. Eindeutige ID des Pruefprogrammtyps.'),
kapitel_typ_bez STRING(255) DEFAULT ' '
OPTIONS(description='Kapiteltyp-Bezeichnung. Quellfeld activity_audit_concept_type_name_current_level. Bezeichnung des Pruefprogrammtyps.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (kapitel_typ_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='KMR - Lookup table for the activity type (Kapiteltyp). Does not include "Kurzchecks". Source view v_dwh_kl_data_audit_program.');