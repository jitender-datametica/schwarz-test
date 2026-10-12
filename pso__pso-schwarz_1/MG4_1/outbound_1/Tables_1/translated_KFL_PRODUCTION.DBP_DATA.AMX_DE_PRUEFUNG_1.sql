CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_de_pruefung_1 (
pruefung_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID der Prüfung'),
pruefung_nr STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL OPTIONS(description='Prüfungsnummer'),
zustand_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Eindeutige ID des Zustanddes'),
pruefung_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL OPTIONS(description='Bezeichnung der Prüfung'),
dat_start DATE OPTIONS(description='Startdatum der Prüfung'),
dat_ende DATE OPTIONS(description='Enddatum der Prüfung'),
revisor_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='ID des Revisors, wird aus datenschutzrechtlichen Gründen nicht verwendet'),
pruefung_typ_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Eindeutige ID des Prüfungstypes'),
pruefung_klasse_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Eindeutige ID der Prüfungsklasse'),
pruefung_ergebnis_wert INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Ergebnisswert'),
business_unit_id INTEGER OPTIONS(description='ID der Organisationseinheit'),
mandant_id INTEGER OPTIONS(description='ID des Mandanten'),
wup_id INTEGER OPTIONS(description='ID der Filiale'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (pruefung_id) NOT ENFORCED
) OPTIONS(description='KMR - Audimex. Enthält Prüfungsdaten Kurzcheck aus DE');