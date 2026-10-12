CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_pruef_programm_2 (
pruef_programm_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID des Prüfprogramms aus dem Quellfeld ID'),
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
pruef_programm_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Prüfprogramms aus der Quellspalte name'),
zustand_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID eines Zustands aus dem Quellfeld state. Referenz zu wal_state.nr'),
kapitel_typ_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID des Prüfprogrammtyps aus dem Quellfeld id'),
pruef_programm_mutter_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='übergeordnetes Kapitel aus dem Quellfeld father_id. Referenz zu pruef_programm_id'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (pruef_programm_id, amx_system_id) NOT ENFORCED
) OPTIONS(description='VIS audimex - Prüfprogramm - Aus der Quelle audimex.audit_concept');