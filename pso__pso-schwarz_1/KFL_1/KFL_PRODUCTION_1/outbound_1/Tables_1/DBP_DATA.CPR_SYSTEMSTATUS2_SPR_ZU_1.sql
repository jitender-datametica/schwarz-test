--==============================================================
-- Table: cpr_systemstatus2_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_systemstatus2_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cpr_systemstatus2_spr_zu_1 (
cpr_systemstatus2_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Schluessel für den Systemstatus2.  Enthält numerische Werte von 1 aufsteigend'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.'),
cpr_systemstatus2_bez STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Sprachabhängige Bezeichnung des Systemstatus2'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (cpr_systemstatus2_id, spr_id) NOT ENFORCED
) OPTIONS(description='IOS - Sprachabhängige Bezeichnungen zum Systemstatus2');