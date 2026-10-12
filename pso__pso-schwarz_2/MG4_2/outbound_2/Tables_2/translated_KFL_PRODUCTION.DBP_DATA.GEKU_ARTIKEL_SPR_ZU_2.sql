CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_artikel_spr_zu_2 (
geku_artikel_uid INTEGER NOT NULL
OPTIONS(description='Eindeutige ID eines GEKU-Artikels aus workflow_uid. Der GEKU-Artikel_2 besitzt keine Referenz zum Kaufland-Artikel_2'),
spr_id INTEGER NOT NULL OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.'),
geku_artikel_bez STRING(250) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des GeKu-Artikels aus code_name, z.Bsp. Einkaufswagen'),
quelle_spr_id INTEGER
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_artikel_uid, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Sprachabhängige Bezeichnung der GeKu-Artikel_2 aus s1_dwh_workflow_out');