CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_t024_1 (
ekgrp STRING(6) NOT NULL,
eknam STRING(36) NOT NULL,
ektel STRING(24) NOT NULL,
ldest STRING(8) NOT NULL,
telfx STRING(62) NOT NULL,
telnumber STRING(60) NOT NULL,
telextens STRING(20) NOT NULL,
smtpaddr STRING(482) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);