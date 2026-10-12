CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_t001r_1 (
bukrs STRING(8) NOT NULL,
waers STRING(10) NOT NULL,
reinh NUMERIC(8) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);