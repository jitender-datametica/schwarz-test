--==============================================================
-- Table: cpr_aufgabe_spr_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_aufgabe_spr_zu_per
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cpr_aufgabe_spr_zu_per (
cpr_aufgabe_id STRING(32) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige ID der Aufgabe aus xlctask'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.'),
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