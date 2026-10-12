CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_pruefung_2 (
pruefung_id INTEGER NOT NULL OPTIONS(description='Die eindeutige ID einer Pruefung aus dem Quellfeld auditing.id'),
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
pruefung_nr STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Nummer der Pruefung, z.Bsp. 2014-00001 aus dem Quellfeld a_number'),
zustand_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID eines Zustands aus dem Quellfeld  state. Referenz zu wal_state.nr'),
pruefung_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung der Pruefung aus dem Quellfeld name'),
dat_start DATE OPTIONS(description='Das Startdatum der Pruefung. Aus der Quellspalte start_date'),
dat_ende DATE OPTIONS(description='Das Endedatum der Pruefung aus dem Quellfeld end_date'),
revisor_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Revisor wurde aus Datenschutzgruenden ausgebaut und darf nicht ohne Ruecksprache mit SBIT wieder eingebaut werden. Default-Wert -1. Eindeutige ID des Pruefers aus dem Quellfeld leading_autitor_id. Referenz zur Tabelle amx_revisor_2'),
pruefung_typ_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID des Pruefungstyps aus dem Quellfeld auditing_type_id'),
pruefung_klasse_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID der Pruefungsklasse aus dem Quellfeld auditing_class_id'),
pruefung_ergebnis_wert INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Ergebniswert aus Quellfeld numeric_result'),
business_unit_id INTEGER
OPTIONS(description='ID der organisatorischen Einheit.Verweis auf ein Prueffeld mit dem Typ Stelle.  Aus dem Quellfeld business_unit_id bzw. audit_universe.id'),
mandant_id INTEGER OPTIONS(description='Mandant_2 im DWH'),
wup_id INTEGER OPTIONS(description='Marktnummer aus t001w.werks'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
zeitspanne STRING(80) DEFAULT '?' OPTIONS(description='Tageszeit bspw. frueh bis 12 Uhr')
)
OPTIONS(description='VIS audimex - Die Tabelle amx_pruefung_2 enthaelt die  Pruefungen. Aus der Quelle audimex.auditing');