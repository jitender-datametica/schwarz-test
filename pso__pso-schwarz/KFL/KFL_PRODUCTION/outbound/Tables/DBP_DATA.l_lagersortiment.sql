--==============================================================
-- Table: l_lagersortiment
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_lagersortiment
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:11:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lagersortiment (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
lagernummer_id STRING(4) NOT NULL OPTIONS(description='Lagernummer'),
lagersortiment_id STRING(1) NOT NULL OPTIONS(description='Lagersortiment ID'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Betrieb'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetrieb'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lagersortimente');