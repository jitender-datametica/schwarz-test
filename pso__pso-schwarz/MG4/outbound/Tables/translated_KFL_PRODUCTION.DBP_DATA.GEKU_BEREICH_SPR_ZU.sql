CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_bereich_spr_zu (
geku_bereich_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID des GeKu-Bereichs aus workflow_level1_uid'),
spr_id INTEGER NOT NULL OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
geku_bereich_bez STRING(250) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des GeKu-Bereichs aus code_name'),
quelle_spr_id INTEGER
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_bereich_uid, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Bezeichnung der GeKu-Gründe aus s1_dhw_workflow_level1_out');