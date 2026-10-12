CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_l_pruefung_typ_2 (
pruefung_typ_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID des Prüfungstyps aus dem Quellfeld ID'),
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
pruefung_typ_bez STRING(50) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Prüfungstyps aus dem Quellfeld name, z.Bsp. Standard'),
ad_hoc_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag legt fest, ob es sich um einen ad_hoc - Prüfungstyp handelt.Aus dem Quellfeld is_ad_hoc'),
amx_grp_id INTEGER
OPTIONS(description='Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen\n            '),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (pruefung_typ_id, amx_system_id) NOT ENFORCED
) OPTIONS(description='VIS audimex - Lookup Tabelle der Prüfungs-Typen aus der Quelltabelle audimex.auditing_type');