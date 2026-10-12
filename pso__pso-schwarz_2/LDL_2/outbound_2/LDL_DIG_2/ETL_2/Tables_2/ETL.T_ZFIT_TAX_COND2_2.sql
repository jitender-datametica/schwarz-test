CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_zfit_tax_cond2_2 (
vatid_2 STRING(18) NOT NULL,
eugrp STRING(3) NOT NULL,
validfrom DATE,
ekorg STRING(4) NOT NULL,
destcntry STRING(3) NOT NULL,
lectaxclass STRING(1) NOT NULL,
suptaxclass STRING(1) NOT NULL,
taxcode STRING(2) NOT NULL,
taxrate NUMERIC(18,3) NOT NULL,
filerowid NUMERIC(8) NOT NULL,
odq_changemode STRING(1) NOT NULL,
odq_entitycntr NUMERIC(20) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);