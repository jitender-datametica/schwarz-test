--==============================================================
-- Table: fremd_lagerort_artikelsortiment_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fremd_lagerort_artikelsortiment_zu
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:57:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fremd_lagerort_artikelsortiment_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
fremd_lagerort_id STRING(4) NOT NULL OPTIONS(description='Fremdlagerort'),
artikelsortiment_id STRING(1) NOT NULL OPTIONS(description='Artikelsortiment ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='fremd_lagerort_artikelsortiment_zu');