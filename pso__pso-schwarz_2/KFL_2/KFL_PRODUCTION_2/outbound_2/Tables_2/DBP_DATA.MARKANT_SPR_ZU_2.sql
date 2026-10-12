--==============================================================
-- Table: markant_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: markant_spr_zu_2
   generated from Powerdesigner on Donnerstag, 16. September 2021 11:42:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.markant_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
markant_id STRING(2) NOT NULL OPTIONS(description='ID Markantabrechnung'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
markant_bez STRING(40) OPTIONS(description='Bezeichnung Markantabrechnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='AIS - Sprachabhängige Bezeichnungen der Markantabrechnungen - manuelle Beladung');