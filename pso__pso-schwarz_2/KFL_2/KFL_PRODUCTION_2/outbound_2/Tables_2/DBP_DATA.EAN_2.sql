--==============================================================
-- Table: ean_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ean_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ean_2 (
ean_id NUMERIC(26,0) NOT NULL OPTIONS(description='Europäische Artikelnummer'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ean_id) NOT ENFORCED
) OPTIONS(description='Europäische Artikelnummern. Wird zu KW46_15 gelöscht');