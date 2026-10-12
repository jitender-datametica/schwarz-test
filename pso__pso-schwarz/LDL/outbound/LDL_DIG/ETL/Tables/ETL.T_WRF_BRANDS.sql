CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_wrf_brands (
brandid STRING(8) NOT NULL,
brandtype STRING(2) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);