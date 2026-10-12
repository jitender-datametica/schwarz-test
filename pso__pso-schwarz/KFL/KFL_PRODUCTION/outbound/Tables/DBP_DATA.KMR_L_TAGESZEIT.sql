--==============================================================
-- Table: kmr_l_tageszeit
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_tageszeit
   generated from Powerdesigner on Freitag, 17. Februar 2023 16:12:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_l_tageszeit (
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.'),
tageszeit_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Tageszeit-ID. Beinhaltet früh, mittel, oder spät. Quellfeld auditing_reserve_sel_auditing_00_id.'),
tageszeit_bez STRING(80) DEFAULT ' ' NOT NULL
OPTIONS(description='Tageszeit-Bezeichnung. Beinhaltet früh, mittel, oder spät. Quellfeld auditing_reserve_sel_auditing_00_name.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (tageszeit_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='KMR - Lookup table for the time of the day during which an audit is performed (Tageszeit). Does not include "Kurzchecks". Source view v_dwh_kl_data_auditing.');