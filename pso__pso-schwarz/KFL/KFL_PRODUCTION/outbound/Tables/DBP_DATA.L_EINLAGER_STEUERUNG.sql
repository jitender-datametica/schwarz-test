--==============================================================
-- Table: l_einlager_steuerung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_einlager_steuerung
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 08:13:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_einlager_steuerung (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagernummer/Lagerkomplex'),
einlager_steuerung_id STRING(4) NOT NULL OPTIONS(description='Einlagerungssteuerung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lookup of Putaway Strategy (EWM)');