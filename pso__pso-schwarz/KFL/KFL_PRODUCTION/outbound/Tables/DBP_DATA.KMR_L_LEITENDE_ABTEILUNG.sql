--==============================================================
-- Table: kmr_l_leitende_abteilung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_leitende_abteilung
   generated from Powerdesigner on Freitag, 17. Februar 2023 16:13:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_l_leitende_abteilung (
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.'),
leit_abteilung_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Leitende Abteilung-ID. Quellfeld auditing_leading_dep_id.'),
leit_abteilung_bez STRING(255) DEFAULT ' ' NOT NULL
OPTIONS(description='Leitende Abteilung-Bezeichnung. Quellfeld auditing_leading_dep_name.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (leit_abteilung_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='KMR - Lookup table for the leading department (leitende Abteilung). Department that initiates the audit, i.e. Revision Kaufland International, Bulgaria, etc. Does not include "Kurzchecks". Source view v_dwh_kl_data_auditing.');