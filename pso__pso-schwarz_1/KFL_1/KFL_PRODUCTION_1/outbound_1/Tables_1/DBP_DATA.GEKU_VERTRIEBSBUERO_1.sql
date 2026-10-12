--==============================================================
-- Table: geku_vertriebsbuero_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_vertriebsbuero_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_vertriebsbuero_1 (
vertriebsbuero_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Vertriebsbüros aus rvl_nr'),
country_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID des Landes aus country_nr'),
vertriebsbuero_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Vertriebsbüros'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (vertriebsbuero_uid) NOT ENFORCED
) OPTIONS(description='GEKU - Lookup Tabelle der Vertriebsbüros aus wmd_rvl_out');