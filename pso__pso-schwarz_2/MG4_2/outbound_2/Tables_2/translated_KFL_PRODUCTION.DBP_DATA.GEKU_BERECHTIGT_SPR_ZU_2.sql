CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_berechtigt_spr_zu_2 (
berechtigt_fg INTEGER NOT NULL OPTIONS(description='Berechtigt=1 / Unberechtigt=0, aus answer_qualified'),
spr_id INTEGER NOT NULL OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.'),
berechtigt_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung für berechtigt / unberechtigt'),
quelle_spr_id INTEGER
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (berechtigt_fg, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Sprachabhängige Bezeichnung für das Berechtigt Flag');