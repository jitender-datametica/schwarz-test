CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_l_handlung_typ_1 (
amx_handlung_typ_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID des Handlungstyps aus dem Quellfeld ID'),
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
amx_handlung_typ_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Handlungstyps aus dem Quellfeld name, z.Bsp. Bewertungsfrage'),
amx_grp_id INTEGER
OPTIONS(description='Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen\n            '),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (amx_handlung_typ_id, amx_system_id) NOT ENFORCED
) OPTIONS(description='VIS audimex - Lookup Tabelle derHandlungs-Typen aus der Quelltabelle checklist_logic');