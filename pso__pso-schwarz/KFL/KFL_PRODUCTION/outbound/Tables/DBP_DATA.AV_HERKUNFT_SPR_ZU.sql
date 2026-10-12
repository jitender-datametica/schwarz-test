--==============================================================
-- Table: av_herkunft_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: av_herkunft_spr_zu
   generated from Powerdesigner on Monday, March 28, 2022 2:29:15 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.av_herkunft_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
spr_id STRING(10) NOT NULL OPTIONS(description='Sprache'),
av_herkunft_id STRING(10) NOT NULL OPTIONS(description='Herkunft Arbeitsvorrat'),
av_herkunft_bez STRING(60) OPTIONS(description='Herkunft Arbeitsvorrat Bez.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, av_herkunft_id) NOT ENFORCED
) OPTIONS(description='Bezeichnung: Arbeitsvorrat Herkunft');