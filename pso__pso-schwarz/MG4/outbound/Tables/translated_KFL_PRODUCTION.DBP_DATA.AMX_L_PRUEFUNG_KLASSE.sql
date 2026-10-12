CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_l_pruefung_klasse (
pruefung_klasse_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID der Prüfungsklasse aus dem Quellfeld ID'),
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
pruefung_klasse_bez STRING(50) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung der Prüfungsklasse aus dem Quellfeld name, z.Bsp. Revision Vertrieb'),
amx_grp_id INTEGER
OPTIONS(description='Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen\n            '),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (pruefung_klasse_id, amx_system_id) NOT ENFORCED
) OPTIONS(description='VIS audimex - Lookup Tabelle der Prüfungs-Klassen aus der Quelltabelle audimex.auditing_class');