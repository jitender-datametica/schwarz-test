CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_dwh_artikel_spr_zu_2 (
geku_dwh_artikel_id INTEGER NOT NULL
OPTIONS(description='Eine_2 weitere ID, die Vergleichbarkeit der Artikel_2 über alle Länder ermöglichen soll'),
spr_id INTEGER NOT NULL OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.'),
geku_artikel_uid INTEGER
OPTIONS(description='Eindeutige ID eines GEKU-Artikels aus workflow_uid. Der GEKU-Artikel_2 besitzt keine Referenz zum Kaufland-Artikel_2'),
geku_dwh_artikel_bez STRING(250) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des GEKU-DWH-Artikels'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_dwh_artikel_id, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Sprachabhängige Bezeichnungen der GEKU-DWH-Artikel_2');