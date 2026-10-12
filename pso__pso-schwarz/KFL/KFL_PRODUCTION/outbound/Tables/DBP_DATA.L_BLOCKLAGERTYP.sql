--==============================================================
-- Table: l_blocklagertyp
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_blocklagertyp
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 08:22:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_blocklagertyp (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagernummer/Lagerkomplex'),
blocklagertyp_id STRING(4) NOT NULL OPTIONS(description='Blocklager'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Bulk Storage Indicators  (EWM)');