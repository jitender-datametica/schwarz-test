CREATE OR REPLACE TABLE kfl_production_dbp_data.cpr_aufgabe_spr_zu_per_1 (
cpr_aufgabe_id STRING(32) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige ID der Aufgabe aus xlctask'),
spr_id INTEGER NOT NULL OPTIONS(description='Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Datensatz gültig ist'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.'),
aufgabe_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Sprachabhängige Bezeichnung der Aufgabe aus txtmd'),
aufgabe_langtext STRING(320) COLLATE 'und:ci' OPTIONS(description='Sprachabhängiger Langtext einer Aufgabe'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id, dat_von) NOT ENFORCED
) OPTIONS(description='IOS - Bezeichnung der Aufgabe');