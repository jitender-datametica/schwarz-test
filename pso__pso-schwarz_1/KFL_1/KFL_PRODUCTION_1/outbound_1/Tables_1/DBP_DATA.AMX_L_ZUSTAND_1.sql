--==============================================================
-- Table: amx_l_zustand_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_l_zustand_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_l_zustand_1 (
zustand_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID eines Zustands aus dem Quellfeld wal_state.nr'),
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
zustand_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Zustandes aus dem Quellfeld name'),
amx_grp_id BIGNUMERIC(38,0)
OPTIONS(description='Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen            '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (zustand_id, amx_system_id) NOT ENFORCED
) OPTIONS(description='VIS audimex - Lookup Tabelle der Zustände aus der Quelltabelle audimex.wal_state');