--==============================================================
-- Table: artkz_eigenmarke
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_eigenmarke
   generated from Powerdesigner on Sonntag, 4. Februar 2024 11:58:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artkz_eigenmarke (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
eigenmarke_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eigenmarken-Kennzeichen (z.Bsp. C für Kaufland Klassikartikel)'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
eigenmarke_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Eigenmarkenkennzeichens'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookuptabelle fuer Artikelkennzeichen  Eigenmarke');