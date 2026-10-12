--==============================================================
-- Table: geku_austr_gebiet_tag_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_austr_gebiet_tag_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_austr_gebiet_tag_1 (
wmd_austraeger_gebiet_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Austrägergebiets'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_1-TT'),
auflage BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Auflage in Stück'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wmd_austraeger_gebiet_uid, dat) NOT ENFORCED
) OPTIONS(description='GEKU - hier werden die Auflagen aus der Tabelle geku_austr_gebiet_1 historisiert abgelegt');