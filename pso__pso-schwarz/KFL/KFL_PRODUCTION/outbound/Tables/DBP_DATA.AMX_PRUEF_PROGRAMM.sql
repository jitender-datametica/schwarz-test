--==============================================================
-- Table: amx_pruef_programm
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_pruef_programm
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_pruef_programm (
pruef_programm_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID des Prüfprogramms aus dem Quellfeld ID'),
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
pruef_programm_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Prüfprogramms aus der Quellspalte name'),
zustand_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID eines Zustands aus dem Quellfeld state. Referenz zu wal_state.nr'),
kapitel_typ_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID des Prüfprogrammtyps aus dem Quellfeld id'),
pruef_programm_mutter_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='übergeordnetes Kapitel aus dem Quellfeld father_id. Referenz zu pruef_programm_id'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (pruef_programm_id, amx_system_id) NOT ENFORCED
) OPTIONS(description='VIS audimex - Prüfprogramm - Aus der Quelle audimex.audit_concept');