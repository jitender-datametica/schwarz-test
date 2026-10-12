CREATE OR REPLACE TABLE kfl_production_dbp_data.cpr_checkliste_spr_zu_per (
cpr_checkliste_id STRING(32) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige ID einer Projekt-Checkliste aus xlccheckl'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Datensatz gültig ist'),
spr_id INTEGER NOT NULL OPTIONS(description='Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.'),
cpr_checkliste_bez STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Sprachabhängige Bezeichnung der Checkliste'),
cpr_checkliste_langtext STRING(320) COLLATE 'und:ci' OPTIONS(description='Sprachabhängiger Langtext zur Checkliste'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (dat_von, spr_id) NOT ENFORCED
) OPTIONS(description='IOS - Sprachabhängige Beschreibung der Checkliste');