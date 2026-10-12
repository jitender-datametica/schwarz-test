--==============================================================
-- Table: flw_l_route_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_route_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_route_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk aus Feld WERK'),
route_id STRING(6) COLLATE 'und:ci' NOT NULL OPTIONS(description='Route aus Feld ROUTE'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, werk_id) NOT ENFORCED
) OPTIONS(description='FLW - Ergänzende Informationen zur Route - SAP FLW (P21) - ZFW_ROUTE');