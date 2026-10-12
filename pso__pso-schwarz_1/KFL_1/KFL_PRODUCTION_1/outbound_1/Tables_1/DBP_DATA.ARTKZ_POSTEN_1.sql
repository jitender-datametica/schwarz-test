--==============================================================
-- Table: artkz_posten_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_posten_1
   generated from Powerdesigner on Sonntag, 4. Februar 2024 11:45:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artkz_posten_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
posten_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennzeichnung des Postenartikels, z.Bsp. PN'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache.'),
posten_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Sprachabhaengige Bezeichnung des Postenkennzeichens.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookuptabelle fuer das Artikelkennzeichen Postenartikel');