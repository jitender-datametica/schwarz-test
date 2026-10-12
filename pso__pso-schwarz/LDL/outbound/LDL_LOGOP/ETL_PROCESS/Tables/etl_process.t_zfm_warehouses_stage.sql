/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_zfm_warehouses_stage
Description		|	ZFM - stage table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_zfm_warehouses_stage (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(4) NOT NULL OPTIONS(description='Country code.'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number.'),
warehouse_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description=''),
name STRING(450) OPTIONS(description=''),
short_name STRING(50) OPTIONS(description=''),
warehouse_number STRING(10) OPTIONS(description=''),
address STRING(200) OPTIONS(description=''),
post_code STRING(50) OPTIONS(description=''),
city STRING(50) OPTIONS(description=''),
country STRING(100) OPTIONS(description=''),
close_expired_bookings STRING(5) OPTIONS(description=''),
dsci_only BOOL OPTIONS(description=''),
country_id BIGNUMERIC(38,0) OPTIONS(description=''),
modified_tmsp DATETIME NOT NULL OPTIONS(description='')
) OPTIONS(description='ZFM - Warehouses');