--==============================================================
-- Table: ean
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ean
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ean (
ean_id NUMERIC(26,0) NOT NULL OPTIONS(description='Europäische Artikelnummer'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ean_id) NOT ENFORCED
) OPTIONS(description='Europäische Artikelnummern. Wird zu KW46_15 gelöscht');