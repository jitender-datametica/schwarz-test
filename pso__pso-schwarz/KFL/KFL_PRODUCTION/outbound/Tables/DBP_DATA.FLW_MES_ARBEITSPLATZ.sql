--==============================================================
-- Table: flw_mes_arbeitsplatz
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_arbeitsplatz
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:22:05
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_mes_arbeitsplatz (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
flw_arbeitsplatz_id STRING(8) NOT NULL OPTIONS(description='identifier of the working place in production line'),
flw_arbeitsplatztyp_id STRING(10) NOT NULL
OPTIONS(description='identifier of the type of the working place in production line'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, flw_arbeitsplatz_id) NOT ENFORCED
) OPTIONS(description='Table contains data for workingplace in production line');