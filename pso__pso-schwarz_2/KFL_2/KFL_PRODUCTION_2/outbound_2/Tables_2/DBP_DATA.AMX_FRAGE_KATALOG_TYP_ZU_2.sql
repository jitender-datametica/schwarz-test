--==============================================================
-- Table: amx_frage_katalog_typ_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_frage_katalog_typ_zu_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_frage_katalog_typ_zu_2 (
amx_system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
amx_frage_katalog_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID einer Frage aus dem Fragenkatalog aus der Quelle abstract_guideline.id'),
frage_typ_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID eines Fragentyps aus dem Quellfeld guideline_type.id'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (amx_system_id, amx_frage_katalog_id, frage_typ_id) NOT ENFORCED
) OPTIONS(description='VIS audimex - Zuordnungs-Tabelle der Fragen-Typen zum Fragenkatalog');