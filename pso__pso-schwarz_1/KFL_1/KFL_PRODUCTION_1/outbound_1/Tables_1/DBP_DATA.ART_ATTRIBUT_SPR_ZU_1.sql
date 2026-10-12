--==============================================================
-- Table: art_attribut_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_attribut_spr_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_attribut_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_attribut_id STRING(5) COLLATE 'und:ci' DEFAULT '     ' NOT NULL OPTIONS(description='Artikelattribut'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache'),
art_attribut_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Artikelattribut Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='Artikelattributtexte');