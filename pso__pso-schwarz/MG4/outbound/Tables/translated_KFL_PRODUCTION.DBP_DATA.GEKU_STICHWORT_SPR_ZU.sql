CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_stichwort_spr_zu (
geku_stichwort_uid INTEGER NOT NULL OPTIONS(description='eindeutige ID des Stichworts aus dem GEKU-System'),
spr_id INTEGER NOT NULL OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
geku_stichwort_bez STRING(255) COLLATE 'und:ci' OPTIONS(description='Sprachabhängige Bezeichnung des MZK-Stichworts'),
quelle_spr_id INTEGER
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_stichwort_uid, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU -Sprachabhängiger Text  des GEKU - MZK-Stichworts');