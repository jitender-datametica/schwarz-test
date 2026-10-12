--==============================================================
-- Table: auslager_steuerung_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: auslager_steuerung_spr_zu_2
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 08:20:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.auslager_steuerung_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagernummer/Lagerkomplex'),
auslager_steuerung_id STRING(4) NOT NULL OPTIONS(description='Auslagerungssteuerung'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
auslager_steuerung_bez STRING(40) OPTIONS(description='Auslagerungssteuerung Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Description of Stock Removal Strategy (EWM)');