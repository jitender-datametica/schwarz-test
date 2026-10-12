CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_setheadert_2 (
setclass STRING(8) NOT NULL,
subclass STRING(24) NOT NULL,
setname STRING(48) NOT NULL,
langu STRING(2) NOT NULL,
descript STRING(80) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);