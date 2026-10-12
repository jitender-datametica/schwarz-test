--==============================================================
-- Table: einlager_steuerung_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: einlager_steuerung_spr_zu
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 08:16:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.einlager_steuerung_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagernummer/Lagerkomplex'),
einlager_steuerung_id STRING(4) NOT NULL OPTIONS(description='Einlagerungssteuerung'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
einlager_steuerung_bez STRING(40) OPTIONS(description='Einlagerungssteuerung Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Description of Putaway Strategy (EWM)');