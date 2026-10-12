--==============================================================
-- Table: artkz_verpart_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_verpart_2
   generated from Powerdesigner on Sonntag, 4. Februar 2024 12:03:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artkz_verpart_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
verpart_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Verpackungsart, z.Bsp DS'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache.'),
verpart_bez STRING(40) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Sprachabhaengige Bezeichnung der Verpackungsart, z.Bsp. Dose'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookuptabelle des Artikelkennzeichens Verpackungsart');