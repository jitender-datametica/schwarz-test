CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_cawnt_2 (
atinn NUMERIC(20) NOT NULL,
atzhl NUMERIC(8) NOT NULL,
spras STRING(2) NOT NULL,
adzhl NUMERIC(8) NOT NULL,
atwtb STRING(140) NOT NULL,
datuv DATE,
techv STRING(24) NOT NULL,
aennr STRING(24) NOT NULL,
lkenz STRING(2) NOT NULL,
datub DATE,
atvaluedescr STRING(180),
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);