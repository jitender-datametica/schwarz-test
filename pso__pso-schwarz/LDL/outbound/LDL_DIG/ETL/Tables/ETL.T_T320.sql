CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_t320 (
werks STRING(8) NOT NULL,
lgort STRING(8) NOT NULL,
lgnum STRING(6) NOT NULL,
obest STRING(2) NOT NULL,
lgntb STRING(2) NOT NULL,
slgor STRING(2) NOT NULL,
obtyp STRING(6) NOT NULL,
lgref STRING(4) NOT NULL,
censy STRING(2) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);