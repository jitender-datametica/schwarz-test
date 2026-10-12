CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_abschlussgrund_spr_zu_2 (
abschlussgrund_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID des Abschlussgrunds aus finish_reason_uid'),
spr_id INTEGER NOT NULL OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.'),
abschlussgrund_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Abschlussgrunds, z.Bsp. SPAM'),
quelle_spr_id INTEGER
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (abschlussgrund_id, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Sprachabhängige Bezeichnungen der Abschlussgründe');