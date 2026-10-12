CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_prioritaet_spr_zu_2 (
geku_prioritaet_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID der Priorität., z.Bsp. 1148722 aus priority_uid'),
spr_id INTEGER NOT NULL OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.'),
geku_prioritaet_bez STRING(255) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung der Priorität, z.Bsp. Personenschaden aus text_out'),
quelle_spr_id INTEGER
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_prioritaet_id, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Sprachabhängige Bezeichnungen der GEKU Priorität');