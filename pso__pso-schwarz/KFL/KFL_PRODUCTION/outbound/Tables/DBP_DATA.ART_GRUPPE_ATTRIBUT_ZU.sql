--==============================================================
-- Table: art_gruppe_attribut_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gruppe_attribut_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_gruppe_attribut_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelnummer'),
art_gruppe_id STRING(5) COLLATE 'und:ci' NOT NULL OPTIONS(description='Artikelgruppe'),
art_attribut_id STRING(5) COLLATE 'und:ci' DEFAULT '     ' NOT NULL OPTIONS(description='Artikelattribut'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id) NOT ENFORCED
) OPTIONS(description='Artikelattributzuordnung');