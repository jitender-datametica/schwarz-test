/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedprodtypestop_2
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_reportedprodtypestop_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
address_id STRING(512) NOT NULL OPTIONS(description='ID of the address_2 of the stop state'),
delivery_dt DATE NOT NULL OPTIONS(description='Delivery date of the dataset'),
temp_fg BOOL OPTIONS(description='Indicates if this is a temporary reported product type stop'),
product_type_id STRING(512) NOT NULL OPTIONS(description='ID of the product type'),
stop_state_qty BIGNUMERIC(38,10) OPTIONS(description='Quantity 1 of the product type stop state'),
start_tmsp DATETIME OPTIONS(description='Start time of the stop state'),
stop_state_type STRING(512) OPTIONS(description='Type of the stop state'),
addresscomment STRING(512) OPTIONS(description='Comment for the Address.'),
addressiddelivery STRING(512) OPTIONS(description='Delivery addresses ID for the stop'),
addressidpickup STRING(512) OPTIONS(description='Pickup Addresses ID for the Stop.'),
reportedtourgid STRING(512) NOT NULL OPTIONS(description='GID of the reported tour_2'),
reportedtourid STRING(512) OPTIONS(description='ID of the reported tour_2'),
transfercomment STRING(512) OPTIONS(description='Comment for the Stock Transfer.'),
transferreason STRING(512) OPTIONS(description='Reason for the Stock Transfer'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, address_id, product_type_id, reportedtourgid, delivery_dt, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='QUINTIQ - Object type in quintiq is reported product type stop');