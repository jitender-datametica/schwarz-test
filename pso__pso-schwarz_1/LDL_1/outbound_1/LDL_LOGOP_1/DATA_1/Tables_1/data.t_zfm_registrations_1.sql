/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_zfm_registrations_1
Description		|	ZFM table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_zfm_registrations_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(4) NOT NULL OPTIONS(description='Country_1 code.'),
registration_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description=''),
warehouse STRING(450) OPTIONS(description=''),
country_1 STRING(100) OPTIONS(description=''),
created DATETIME OPTIONS(description=''),
supplier_name STRING(100) OPTIONS(description=''),
carrier_name STRING(100) OPTIONS(description=''),
pallet_count_ep BIGNUMERIC(38,0) OPTIONS(description=''),
pallet_count_dd BIGNUMERIC(38,0) OPTIONS(description=''),
pallet_count_ip BIGNUMERIC(38,0) OPTIONS(description=''),
reference_number STRING(100) OPTIONS(description=''),
book_date DATETIME OPTIONS(description=''),
pager_number STRING(50) OPTIONS(description=''),
full_name STRING(100) OPTIONS(description=''),
license_plate STRING(20) OPTIONS(description=''),
registration_state STRING(50) OPTIONS(description=''),
confirmed BOOL OPTIONS(description=''),
canceled BOOL OPTIONS(description=''),
warehouse_id BIGNUMERIC(38,0) OPTIONS(description=''),
country_id BIGNUMERIC(38,0) OPTIONS(description=''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, registration_id, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='ZFM - Registrations');