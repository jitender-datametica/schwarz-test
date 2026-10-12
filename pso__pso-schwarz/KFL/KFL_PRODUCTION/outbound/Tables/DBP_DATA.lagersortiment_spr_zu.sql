--==============================================================
-- Table: lagersortiment_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagersortiment_spr_zu
   generated from Powerdesigner on Mittwoch, 21. April 2021 14:24:07
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagersortiment_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagernummer'),
lagersortiment_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagersortiment ID'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprachschlüssel'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Betrieb'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetrieb'),
lagersortiment_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Lagersortiment Name'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lagersortiment Bezeichnung');