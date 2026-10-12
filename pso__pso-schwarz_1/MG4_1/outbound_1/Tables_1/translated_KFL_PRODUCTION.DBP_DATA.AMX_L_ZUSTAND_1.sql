CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_l_zustand_1 (
zustand_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Zustands aus dem Quellfeld wal_state.nr'),
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
zustand_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Zustandes aus dem Quellfeld name'),
amx_grp_id INTEGER
OPTIONS(description='Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen\n            '),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (zustand_id, amx_system_id) NOT ENFORCED
) OPTIONS(description='VIS audimex - Lookup Tabelle der Zustände aus der Quelltabelle audimex.wal_state');