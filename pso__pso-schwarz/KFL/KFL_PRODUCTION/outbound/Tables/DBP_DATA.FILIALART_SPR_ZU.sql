--==============================================================
-- Table: filialart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: filialart_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.filialart_spr_zu (
filialart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Filialart, z.B. 1 = Stammfiliale, 2 = Durchsetzungsfiliale'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
filialart_bez STRING(50) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Filialart'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (filialart_id, spr_id) NOT ENFORCED
) OPTIONS(description='VIS - Filialart Sprachzuordnung');