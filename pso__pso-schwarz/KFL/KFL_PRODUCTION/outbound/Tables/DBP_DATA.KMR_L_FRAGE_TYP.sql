--==============================================================
-- Table: kmr_l_frage_typ
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_frage_typ
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:28:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_l_frage_typ (
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.'),
frage_typ_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Fragetyp-ID. Quellfeld guideline_checklist_logic_id.'),
frage_typ_bez STRING(255) DEFAULT ' ' NOT NULL
OPTIONS(description='Fragetyp-Bezeichnung. Quellfeld guideline_checklist_logic_name.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (frage_typ_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='KMR - Lookup table for the type of question / guideline. Does not contain "Kurzchecks". Source view v_dwh_kl_data_guideline.');