--==============================================================
-- Table: l_ladungstraeger_status
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_ladungstraeger_status
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 07:41:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ladungstraeger_status (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
ladungstraeger_status_id STRING(2) NOT NULL OPTIONS(description='Ladungsträger Status ID     '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Ladungsträger Status Lookup');