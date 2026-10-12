/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table/view	|	t_quintiq_reportedaddressstate_deleted
Description		|	QUINTIQ - Temporary table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_quintiq_reportedaddressstate_deleted (
client_id BIGNUMERIC(38,0) NOT NULL,
lidl_country STRING(40) NOT NULL,
source_system STRING(30) NOT NULL,
wh_id STRING(5) NOT NULL,
pallet_pos_additional_dist BIGNUMERIC(38,10),
address_id STRING(512) NOT NULL,
calendar_week BIGNUMERIC(38,0),
delivery_dt DATE NOT NULL,
oneway_fg BOOL,
temp_fg BOOL,
pallet_pos_dlv_cnt BIGNUMERIC(38,10),
tour_dist_without_addr BIGNUMERIC(38,10),
reportedtourgid STRING(512) NOT NULL,
reportedtourid STRING(512),
arrivalactualtelematics DATETIME,
arrivalestimatedtelematics DATETIME,
departureactualtelematics DATETIME,
deleted_fg BIGNUMERIC(38,0) NOT NULL,
update_mode STRING(2),
extraction_dt DATE NOT NULL,
extraction_ts DATETIME NOT NULL,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER NOT NULL,
record_id INTEGER NOT NULL,
filename STRING(1000) NOT NULL
) OPTIONS(description='QUINTIQ - Temporary table');