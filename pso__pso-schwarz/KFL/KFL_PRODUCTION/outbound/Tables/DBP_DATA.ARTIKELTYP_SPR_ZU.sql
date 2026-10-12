--==============================================================
-- Table: artikeltyp_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artikeltyp_spr_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artikeltyp_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
artikeltyp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Klassifizierung des Artikels, z.Bsp. Displayartikel'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
artikeltyp_bez STRING(20) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Artikeltyps, z.Bsp. Displayartikel'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, artikeltyp_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Sprachabhängige Bezeichnungen des Artikeltyps');