/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_zfm_warehouses
Description		|	ZFM table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_zfm_warehouses (
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
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, warehouse_id, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='ZFM - Warehouses');