CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_pruef_kapitel_2 (
pruef_kapitel_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Pruef-Kapitels. Aus dem Quellfeld id'),
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
pruefung_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Die Prüfung, zu der dieses Kapitel im Prüfprogramm gehört aus dem Quellfeld auditing.id'),
pruef_kapitel_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Prüfkapitels aus der Quellspalte name'),
hauptbereich_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID eines Hauptbereichs aus dem Quellfeld topic.id'),
teilbereich_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID eines Teilbereichs aus dem Quellfeld content_area.id'),
kapitel_ergebnis_wert INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Ergebniswert aus Quellfeld numeric_result'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (pruef_kapitel_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='VIS audimex - Die Tabelle amx_pruef_kapitel_2 enthält die Kapitel der Prüfprogramme. Aus der Quelle audimex.activity');