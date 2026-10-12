--==============================================================
-- Table: filialart_altersstruktur_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: filialart_altersstruktur_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.filialart_altersstruktur_zu_1 (
altersstruktur_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Altersstruktur, z.B. 1 = Stammfiliale, 2 = Durchsetzungsfiliale, 3 = Expansionsbereinigt'),
filialart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Filialart, z.B. 1 = Stammfiliale, 2 = Durchsetzungsfiliale'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (altersstruktur_id, filialart_id) NOT ENFORCED
) OPTIONS(description='VIS - Filialart-Altersstruktur-Zuordnung');