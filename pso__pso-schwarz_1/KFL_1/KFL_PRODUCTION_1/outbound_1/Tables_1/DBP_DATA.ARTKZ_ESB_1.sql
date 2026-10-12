--==============================================================
-- Table: artkz_esb_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_esb_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artkz_esb_1 (
esb_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des esb_Kennzeichens, z.Bsp. B'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
esb_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des esb_Kennzeichens, z.Bsp. Blickpunktartikel'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookuptabelle des Kalkulationskennzeichens Nonfood');