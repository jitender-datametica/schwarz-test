CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_csku_1 (
spras STRING(2) NOT NULL,
ktopl STRING(8) NOT NULL,
kstar STRING(20) NOT NULL,
ktext STRING(40) NOT NULL,
ltext STRING(80) NOT NULL,
mctxt STRING(40) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);