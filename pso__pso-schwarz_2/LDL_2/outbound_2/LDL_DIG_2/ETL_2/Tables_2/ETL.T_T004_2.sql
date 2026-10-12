CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_t004_2 (
ktopl STRING(8) NOT NULL,
sakln NUMERIC(4) NOT NULL,
dspra STRING(2) NOT NULL,
aspra STRING(20) NOT NULL,
kktpl STRING(8) NOT NULL,
xsper STRING(2) NOT NULL,
novbund STRING(2) NOT NULL,
integco STRING(2) NOT NULL,
layout0 STRING(8) NOT NULL,
layoutp STRING(8) NOT NULL,
layouts STRING(8) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);