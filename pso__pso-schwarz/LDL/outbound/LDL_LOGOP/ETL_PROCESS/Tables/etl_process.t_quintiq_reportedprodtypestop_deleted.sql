/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table/view	|	t_quintiq_reportedprodtypestop_deleted
Description		|	QUINTIQ - Temporary table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_quintiq_reportedprodtypestop_deleted (
client_id BIGNUMERIC(38,0) NOT NULL,
lidl_country STRING(40) NOT NULL,
source_system STRING(30) NOT NULL,
wh_id STRING(5) NOT NULL,
address_id STRING(512) NOT NULL,
delivery_dt DATE NOT NULL,
temp_fg BOOL,
product_type_id STRING(512) NOT NULL,
stop_state_qty BIGNUMERIC(38,10),
start_tmsp DATETIME,
stop_state_type STRING(512),
addresscomment STRING(512),
addressiddelivery STRING(512),
addressidpickup STRING(512),
reportedtourgid STRING(512) NOT NULL,
reportedtourid STRING(512),
transfercomment STRING(512),
transferreason STRING(512),
deleted_fg BIGNUMERIC(38,0) NOT NULL,
update_mode STRING(2),
extraction_dt DATE NOT NULL,
extraction_ts DATETIME NOT NULL,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER NOT NULL,
record_id INTEGER NOT NULL,
filename STRING(1000) NOT NULL
) OPTIONS(description='QUINTIQ - Temporary table');