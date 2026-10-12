--==============================================================
-- Table: ts_mercareon_mapping_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_mercareon_mapping_1
   generated from Powerdesigner on Tuesday, March 22, 2022 8:57:57 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_mercareon_mapping_1 (
mercareon_standort STRING(255) NOT NULL OPTIONS(description='Standortbezeichnung Mercareon'),
mercareon_entladestelle STRING(255) NOT NULL OPTIONS(description='Entladestellenbezeichnung Mercareon'),
mandant_id BIGNUMERIC(38,0) OPTIONS(description='Mandant_1 DWH'),
wup_id BIGNUMERIC(38,0) OPTIONS(description='Verteilzentrum'),
nb_id BIGNUMERIC(38,0) OPTIONS(description='Nebenbetrieb'),
lagernummer_ewm_id STRING(4) OPTIONS(description='Lagernummer EWM'),
lagernummer_les_id STRING(4) OPTIONS(description='Lagernummer LES'),
entladestelle_id BIGNUMERIC(38,0) OPTIONS(description='Entladestelle'),
artikelsortiment_id STRING(1) OPTIONS(description='Artikelsortiment'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mercareon_standort, mercareon_entladestelle) NOT ENFORCED
) OPTIONS(description='Mapping Mercareon Standort + Entladestelle auf VZ/Lagernummer/Entladestelle etc.');