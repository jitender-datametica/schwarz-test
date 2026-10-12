--==============================================================
-- Table: l_verrechfall_kostentyp_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_verrechfall_kostentyp_1
   generated from Powerdesigner on Donnerstag, 22. April 2021 10:54:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_verrechfall_kostentyp_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_im DWH'),
verrechfall_kostentyp_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Typ: (F)ix oder (V)ariabel'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lookup Kostentyp');