--==============================================================
-- Table: l_artikelsortiment
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_artikelsortiment
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_artikelsortiment (
artikelsortiment_id STRING(1) NOT NULL OPTIONS(description='Artikelsortiment ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Artikelsortiment Lookup');