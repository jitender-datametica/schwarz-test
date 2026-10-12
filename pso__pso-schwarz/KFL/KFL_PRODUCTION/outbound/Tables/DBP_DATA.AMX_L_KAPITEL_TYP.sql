--==============================================================
-- Table: amx_l_kapitel_typ
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_l_kapitel_typ
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_l_kapitel_typ (
kapitel_typ_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID des Prüfprogrammtyps aus dem Quellfeld id'),
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
kapitel_typ_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des prüfprogrammtyps aus dem Quellfeld name'),
amx_grp_id BIGNUMERIC(38,0)
OPTIONS(description='Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen            '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (kapitel_typ_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='VIS audimex - Lookup Tabelle der Prüf-Programm-Typen aus der Quelltabelle audimex.audit_concept_type');