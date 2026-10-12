--==============================================================
-- Table: artkz_display_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_display_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artkz_display_1 (
display_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Schlüssel des Artikelkennzeichens Display (0 = kein Displayartikel'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
display_bez STRING(80) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Artikelkennzeichens Display'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (display_id, mandant_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookup Artikelkennzeichen Display');