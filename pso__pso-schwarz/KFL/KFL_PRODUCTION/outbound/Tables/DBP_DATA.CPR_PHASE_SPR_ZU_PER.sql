--==============================================================
-- Table: cpr_phase_spr_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_phase_spr_zu_per
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cpr_phase_spr_zu_per (
projekt_phase_id STRING(32) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige ID einer Projektphase aus xlcphase'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Datensatz gültig ist'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.'),
cpr_phase_bez STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='Sprachabhängige Beschreibung der Projektphase'),
cpr_phase_langtext STRING(320) COLLATE 'und:ci' OPTIONS(description='Sprachabhängiger Langtext zur Projektphase'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (dat_von, spr_id) NOT ENFORCED
) OPTIONS(description='IOS - Sprachabhängige Bezeichnung der Projektphasen');