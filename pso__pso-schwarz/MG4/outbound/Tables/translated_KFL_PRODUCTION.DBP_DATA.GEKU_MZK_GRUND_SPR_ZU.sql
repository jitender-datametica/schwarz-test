CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_mzk_grund_spr_zu (
geku_mzk_grund_uid INTEGER NOT NULL OPTIONS(description='Eindeutige Id für den Meldezettel-Grund'),
spr_id INTEGER NOT NULL OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
geku_mzk_grund_bez STRING(255) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des MZK-Grundes'),
quelle_spr_id INTEGER
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_mzk_grund_uid, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Sprachabhängige Bezeichnungen der MZK - Gründe');