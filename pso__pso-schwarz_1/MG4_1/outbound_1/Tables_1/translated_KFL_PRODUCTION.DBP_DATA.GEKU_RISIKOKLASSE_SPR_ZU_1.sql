CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_risikoklasse_spr_zu_1 (
geku_risikoklasse_id INTEGER NOT NULL OPTIONS(description='ID der Risikoklasse'),
spr_id INTEGER NOT NULL OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.'),
geku_risikoklasse_bez STRING(255) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung der Risikoklasse (z.Bsp. Risikoklasse 1)'),
quelle_spr_id INTEGER
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_risikoklasse_id, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Sprachabhängige Bezeichnungen der GEKU Risikoklasse');