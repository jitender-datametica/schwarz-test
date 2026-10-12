--==============================================================
-- Table: blocklagertyp_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: blocklagertyp_spr_zu
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 08:26:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.blocklagertyp_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagernummer/Lagerkomplex'),
blocklagertyp_id STRING(4) NOT NULL OPTIONS(description='Blocklager'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
blocklagertyp_bez STRING(40) OPTIONS(description='Auslagerungssteuerung Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Description of Bulk Storage Indicators (EWM)');