--==============================================================
-- Table: temperatur_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: temperatur_spr_zu_1
   generated from Powerdesigner on Donnerstag, 13. Februar 2025 16:55:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.temperatur_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
temperatur_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kennzeichen für den Temperaturbereich, z.Bsp. 3'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
temperatur_bez STRING(200) OPTIONS(description='Bezeichnung für den Temperaturbereich, z.Bsp. Gefrierware'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Sprachabhängige Bezeichnungen der Temperaturkennzeichen');