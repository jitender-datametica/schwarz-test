/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_zfm_registrations_stage
Description		|	ZFM - stage table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_zfm_registrations_stage (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(4) NOT NULL OPTIONS(description='Country code.'),
registration_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description=''),
warehouse STRING(450) OPTIONS(description=''),
country STRING(100) OPTIONS(description=''),
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
modified_tmsp DATETIME NOT NULL OPTIONS(description='')
) OPTIONS(description='ZFM - Registrations');