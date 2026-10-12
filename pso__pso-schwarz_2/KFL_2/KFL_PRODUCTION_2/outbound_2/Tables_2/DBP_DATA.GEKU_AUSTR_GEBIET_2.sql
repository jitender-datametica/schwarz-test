--==============================================================
-- Table: geku_austr_gebiet_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_austr_gebiet_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_austr_gebiet_2 (
wmd_austraeger_gebiet_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Austrägergebiets'),
gebiets_bereich_uid INTEGER OPTIONS(description='Eindeutige ID eines Gebietsbereichs aus gbb_uid'),
auflage BIGNUMERIC(38,0) OPTIONS(description='Auflage in Stück'),
solo_fg BIGNUMERIC(38,0) OPTIONS(description='Solo-Gebiet ja=1, nein=0'),
wmd_austr_gebiet_bez STRING(250) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Austrägergebiets'),
austr_gebiet_lfd_nr BIGNUMERIC(38,0)
OPTIONS(description='Mehrere Austrägergebiete können dieselbe Bezeichnung haben und unterscheiden sich durch eine_2 laufende Nummer - vielleicht aber auch durch eine_2 PLZ'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wmd_austraeger_gebiet_uid) NOT ENFORCED
) OPTIONS(description='GEKU - Lookup-Tabelle der Austrägergebiete aus wmd_at_out - MULTISET');