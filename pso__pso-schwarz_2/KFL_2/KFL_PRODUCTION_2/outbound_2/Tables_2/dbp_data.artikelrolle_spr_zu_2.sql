--==============================================================
-- Table: artikelrolle_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artikelrolle_spr_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artikelrolle_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
artikelrolle_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Artikelrolle international ID'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache'),
artikelrolle_bez STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='Artikelrolle Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='Sprachabhängige Bezeichnung der Artikelrolle');