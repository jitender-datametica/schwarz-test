--==============================================================
-- Table: kmr_l_feststellung_gewichtung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_feststellung_gewichtung_2
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:30:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_l_feststellung_gewichtung_2 (
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.'),
feststellung_gewichtung_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Gewichtung-ID. Quellfeld issue_weight_id.'),
feststellung_gewichtung_bez STRING(255) DEFAULT ' ' NOT NULL
OPTIONS(description='Gewichtung-Bezeichnung. Quellfeld issue_weight_name.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (feststellung_gewichtung_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='KMR - Lookup table for the weight / importance of the issue (light, medium, heavy). Does not contain "Kurzchecks". Source view v_dwh_kl_data_issue.');