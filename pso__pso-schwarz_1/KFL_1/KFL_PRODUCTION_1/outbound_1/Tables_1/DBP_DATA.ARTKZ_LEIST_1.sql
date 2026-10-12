--==============================================================
-- Table: artkz_leist_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_leist_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artkz_leist_1 (
leist_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Artikelkennzeichen Leistungsstark Food'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
leist_bez STRING(40) COLLATE 'und:ci' DEFAULT ' ' NOT NULL OPTIONS(description='Leistungsstärke Food Bezeichnung.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookuptabelle des Artikelkennzeichens leistungsstark');