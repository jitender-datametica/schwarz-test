CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_grund_spr_zu_1 (
geku_grund_uid INTEGER NOT NULL OPTIONS(description='Eindeutiger Schlüssel der Geku-Gründe aus workflow_level2_uid'),
spr_id INTEGER NOT NULL OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.'),
geku_grund_bez STRING(250) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des GeKu-Grundes aus code_name'),
quelle_spr_id INTEGER
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_grund_uid, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Bezeichnung der GeKu-Gründe aus s1_dhw_workflow_level2_out');