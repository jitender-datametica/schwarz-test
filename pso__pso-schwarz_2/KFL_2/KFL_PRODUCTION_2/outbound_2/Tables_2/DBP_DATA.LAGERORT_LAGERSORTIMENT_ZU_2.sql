--==============================================================
-- Table: lagerort_lagersortiment_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagerort_lagersortiment_zu_2
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:53:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagerort_lagersortiment_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
lagerort_id STRING(4) NOT NULL OPTIONS(description='Lagernummer'),
lagersortiment_id STRING(1) NOT NULL OPTIONS(description='Lagersortiment ID'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Betrieb'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetrieb'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Zuordnung Lagernummer / Lagersortiment');