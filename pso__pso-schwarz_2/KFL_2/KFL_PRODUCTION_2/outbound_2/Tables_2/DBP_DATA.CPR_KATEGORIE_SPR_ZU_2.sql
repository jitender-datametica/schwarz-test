--==============================================================
-- Table: cpr_kategorie_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_kategorie_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cpr_kategorie_spr_zu_2 (
cpr_kategorie_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Projektkategorie ID, z.Bsp. 1'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr_2 fuer jede DWH Sprache = 1.'),
cpr_kategorie_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Sprachabhängige Projektkategorie, z.Bsp Entwicklungsprojekt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id) NOT ENFORCED
) OPTIONS(description='IOS - Sprachabhängige Bezeichnung der Projektkategorie');