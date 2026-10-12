--==============================================================
-- Table: flw_l_fehlgrund
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_fehlgrund
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_fehlgrund (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Mandanten im DWH; Deutschland entspricht Mandant_ID = 1'),
fehlgrund_id STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung des Fehl- / Verspätungsgrundes aus txt  - wird aus Modellierungsgründen zur ID erklärt'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
fehlgrund_bez STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Attribut  des Fehl- / Verspätungsgrundes aus art - scheint sich um den Verursacher zu handeln'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Lookuptabelle zur Verwaltung von Fehl/Verspätungsgründen aus zfw_mympfgrund             ');