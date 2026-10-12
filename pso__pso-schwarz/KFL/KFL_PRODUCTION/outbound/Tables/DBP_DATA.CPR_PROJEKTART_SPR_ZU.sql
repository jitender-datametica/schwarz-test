--==============================================================
-- Table: cpr_projektart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_projektart_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cpr_projektart_spr_zu (
projektart_id STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Projektart, z.Bsp. EX'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.'),
projektart_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Sprachabhängige Beschreibung der Projektart, z.Bsp. Expansionsprojekt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id) NOT ENFORCED
) OPTIONS(description='IOS - Sprachabhängige Bezeichnung der Projektarten');