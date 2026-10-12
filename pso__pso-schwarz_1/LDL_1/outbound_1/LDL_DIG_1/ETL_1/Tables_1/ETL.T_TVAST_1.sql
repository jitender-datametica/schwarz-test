CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_tvast_1 (
spras STRING(2) NOT NULL,
sap_sys_name STRING(20),
sap_client_id STRING(20),
tmsp_insert DATETIME,
tmsp_update DATETIME,
aufsp STRING(4) NOT NULL,
vtext STRING(40) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38,0) NOT NULL
);