/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_zfm_bookingorders_stage_2
Description		|	ZFM - stage table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_zfm_bookingorders_stage_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(4) NOT NULL OPTIONS(description='Country_2 code.'),
booking_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description=''),
booking_order_guid STRING(100) OPTIONS(description=''),
order_number STRING(100) OPTIONS(description=''),
collection_number STRING(100) OPTIONS(description=''),
supplier_name STRING(100) OPTIONS(description=''),
supplier_number STRING(100) OPTIONS(description=''),
article_description STRING(110) OPTIONS(description=''),
ep_count BIGNUMERIC(38,0) OPTIONS(description=''),
dd_count BIGNUMERIC(38,0) OPTIONS(description=''),
lpr_count BIGNUMERIC(38,0) OPTIONS(description=''),
chep_count BIGNUMERIC(38,0) OPTIONS(description=''),
ep_count_out BIGNUMERIC(38,0) OPTIONS(description=''),
dd_count_out BIGNUMERIC(38,0) OPTIONS(description=''),
lpr_count_out BIGNUMERIC(38,0) OPTIONS(description=''),
chep_count_out BIGNUMERIC(38,0) OPTIONS(description=''),
modified_tmsp DATETIME NOT NULL OPTIONS(description='')
) OPTIONS(description='ZFM - Booking Orders');