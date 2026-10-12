--==============================================================
-- Table: artkz_aldi
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_aldi
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artkz_aldi (
aldi_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichnet, in welcher/ welchen Vertriebsschiene(n) ein Artikel das Aldi Kennzeichen besitzt, kann sich auf eine oder mehrere Vertriebsschienen beziehen'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
aldi_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Artikelkennzeichens Aldi (z.Bsp, Nord, Nord und West, ...)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (aldi_id, mandant_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookup Tabelle fuer Artikelkennzeichen Aldi');