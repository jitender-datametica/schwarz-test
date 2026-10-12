/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_zfm_bookings_stage
Description		|	ZFM - stage table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_zfm_bookings_stage (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(4) NOT NULL OPTIONS(description='Country code.'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number.'),
booking_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description=''),
created_by STRING(100) OPTIONS(description=''),
haulier_id BIGNUMERIC(38,0) OPTIONS(description=''),
haulier STRING(200) OPTIONS(description=''),
booking_date DATE OPTIONS(description=''),
type_of_goods STRING(200) OPTIONS(description=''),
booking_state STRING(25) OPTIONS(description=''),
booking_start_time TIME OPTIONS(description=''),
reference_number STRING(100) OPTIONS(description=''),
order_number STRING(250) OPTIONS(description=''),
order_numbers STRING(2500) OPTIONS(description=''),
timestamp_signed_in DATETIME OPTIONS(description=''),
timestamp_at_gate DATETIME OPTIONS(description=''),
timestamp_signed_out DATETIME OPTIONS(description=''),
timestamp_not_arrived DATETIME OPTIONS(description=''),
timestamp_deleted DATETIME OPTIONS(description=''),
supplier STRING(700) OPTIONS(description=''),
ep_count BIGNUMERIC(38,0) OPTIONS(description=''),
dd_count BIGNUMERIC(38,0) OPTIONS(description=''),
lpr_count BIGNUMERIC(38,0) OPTIONS(description=''),
chep_count BIGNUMERIC(38,0) OPTIONS(description=''),
attachments BOOL OPTIONS(description=''),
article_description STRING(700) OPTIONS(description=''),
articles STRING(2500) OPTIONS(description=''),
pallet_exchange STRING(50) OPTIONS(description=''),
swap_body BOOL OPTIONS(description=''),
type_of_process STRING(20) OPTIONS(description=''),
country STRING(100) OPTIONS(description=''),
warehouse STRING(450) OPTIONS(description=''),
warehouse_short_name STRING(50) OPTIONS(description=''),
warehouse_number STRING(10) OPTIONS(description=''),
gate STRING(20) OPTIONS(description=''),
not_arrived BOOL OPTIONS(description=''),
deleted BOOL OPTIONS(description=''),
reason_deleted STRING(250) OPTIONS(description=''),
comment_txt STRING(250) OPTIONS(description=''),
type_of_goods_id BIGNUMERIC(38,0) OPTIONS(description=''),
country_id BIGNUMERIC(38,0) OPTIONS(description=''),
warehouse_id BIGNUMERIC(38,0) OPTIONS(description=''),
booking_datetime DATETIME OPTIONS(description='Combination of booking_date + booking_start_time'),
modified_tmsp DATETIME NOT NULL OPTIONS(description='')
) OPTIONS(description='ZFM - Booking Details (time slot information)');