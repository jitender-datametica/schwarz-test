CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_constant_i_2 (
conkey NUMERIC(20,0) NOT NULL,
counter INTEGER NOT NULL,
fieldname STRING(60) NOT NULL,
zsign STRING(2) NOT NULL,
zoption STRING(4) NOT NULL,
zlow STRING(80) NOT NULL,
zhigh STRING(80) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38,0) NOT NULL,
sap_sys_name STRING(16777216),
sap_client_id STRING(16777216),
tmsp_insert DATETIME,
tmsp_update DATETIME
);