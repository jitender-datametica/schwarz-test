/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_zfm_bookingorders
Description		|	ZFM table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_zfm_bookingorders (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(4) NOT NULL OPTIONS(description='Country code.'),
booking_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description=''),
booking_order_guid STRING(100) NOT NULL OPTIONS(description=''),
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
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, booking_id, booking_order_guid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='ZFM - Booking Orders');