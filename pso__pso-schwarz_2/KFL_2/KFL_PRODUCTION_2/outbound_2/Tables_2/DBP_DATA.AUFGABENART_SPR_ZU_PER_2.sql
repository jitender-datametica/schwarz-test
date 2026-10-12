--==============================================================
-- Table: aufgabenart_spr_zu_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aufgabenart_spr_zu_per_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aufgabenart_spr_zu_per_2 (
aufgabenart_id STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der Aufgabenart. In der Regel werden nur 2 Byte benutzt'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr_2 fuer jede DWH Sprache = 1.'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Datensatz gültig ist'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.'),
aufgabenart_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Sprachabhängige Bezeichnung der Aufgabenart'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id, dat_von) NOT ENFORCED
) OPTIONS(description='IOS - Sprachabhängige Bezeichnung der Aufgabenart');