--==============================================================
-- Table: artikelsortiment_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artikelsortiment_spr_zu_1
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:57:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artikelsortiment_spr_zu_1 (
artikelsortiment_id STRING(1) NOT NULL OPTIONS(description='ARTIKELSORTIMENT ID'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID DER SPRACHE SPRACHSCHLÜSSEL'),
artikelsortiment_bez STRING(40) OPTIONS(description='Lagersortiment Name'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Artikelsortiment Bezeichnung');