--==============================================================
-- Table: altersstruktur_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: altersstruktur_spr_zu
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.altersstruktur_spr_zu (
altersstruktur_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Altersstruktur, z.B. 1 = Stammfiliale, 2 = Durchsetzungsfiliale, 3 = Expansionsbereinigt'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
altersstruktur_bez STRING(50) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Altersstruktur'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (altersstruktur_id, spr_id) NOT ENFORCED
) OPTIONS(description='VIS - Altersstruktur Sprachzuordnung');