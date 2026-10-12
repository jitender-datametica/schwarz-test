CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_de_pruef_kapitel_1 (
pruef_kapitel_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID des Prüfkapitels'),
pruefung_id INTEGER NOT NULL OPTIONS(description='Die Eindeutige Prüfung zu der dieses Prüfkapitel gehört.'),
pruef_kapitel_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Prüfkapitels aus dem Quellfeld name'),
hauptbereich_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Eindeutige ID des Hauptbereichs'),
teilbereich_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Eindeutige ID des Teilbereichs'),
kapitel_ergebnis_wert INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Ergebnisswert aus dem Quellfeld numeric_result'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (pruef_kapitel_id) NOT ENFORCED
) OPTIONS(description='KMR - Audimex. Enthäl Kapitel der Prüfprogramme für Kurzcheck Daten aus DE');