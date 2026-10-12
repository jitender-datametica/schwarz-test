--==============================================================
-- Table: l_av_herkunft_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_av_herkunft_1
   generated from Powerdesigner on Monday, March 28, 2022 2:27:58 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_av_herkunft_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
av_herkunft_id STRING(10) NOT NULL OPTIONS(description='Herkunft Arbeitsvorrat'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, av_herkunft_id) NOT ENFORCED
) OPTIONS(description='Lookup: Arbeitsvorrat Herkunft');