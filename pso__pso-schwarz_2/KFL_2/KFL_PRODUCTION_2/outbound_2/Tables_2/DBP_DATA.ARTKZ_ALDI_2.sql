--==============================================================
-- Table: artkz_aldi_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_aldi_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artkz_aldi_2 (
aldi_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichnet, in welcher/ welchen Vertriebsschiene(n) ein Artikel_2 das Aldi Kennzeichen besitzt, kann sich auf eine_2 oder mehrere Vertriebsschienen beziehen'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
aldi_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Artikelkennzeichens Aldi (z.Bsp, Nord, Nord und West, ...)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (aldi_id, mandant_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookup Tabelle fuer Artikelkennzeichen Aldi');