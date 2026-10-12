/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedaddressproducttypepallettype
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_reportedaddressproducttypepallettype (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(4) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
address_id STRING(512) NOT NULL OPTIONS(description='Delivery address ID of the shipment leg'),
product_type_id STRING(512) NOT NULL OPTIONS(description='Product type ID of the shipment leg'),
delivery_dt DATE NOT NULL OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start)'),
total_quantity BIGNUMERIC(38,0)
OPTIONS(description='Sum of non-forecast shipment legs which are planned on a non-dummy route'),
total_pre_delivery BIGNUMERIC(38,0) OPTIONS(description='Sum of shipment legs which have IsPredelivery = true'),
total_post_delivery BIGNUMERIC(38,0) OPTIONS(description='Sum of shipment legs which have IsPostDelivery = true'),
pallet_type STRING(512) NOT NULL OPTIONS(description='Pallet type or derived pallet type of the shipment leg'),
package_numbers STRING(512) OPTIONS(description='String of package numbers of the shipment legs'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, address_id, product_type_id, delivery_dt, pallet_type, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='On address product type pallet type there are some KPIs that have to be reported');