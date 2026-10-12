CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_l_teilbereich (
teilbereich_id INTEGER NOT NULL
OPTIONS(description='Eindeutige ID eines Teilbereichs aus dem Quellfeld content_area.id'),
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
teilbereich_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Teilbereichs aus dem Quellfeld name, z.Bsp. Werbevermarktung'),
amx_grp_id INTEGER
OPTIONS(description='Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen\n            '),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (teilbereich_id, amx_system_id) NOT ENFORCED
) OPTIONS(description='VIS audimex - Lookup Tabelle der Teilbereiche aus der Quelltabelle audimex.content_area');