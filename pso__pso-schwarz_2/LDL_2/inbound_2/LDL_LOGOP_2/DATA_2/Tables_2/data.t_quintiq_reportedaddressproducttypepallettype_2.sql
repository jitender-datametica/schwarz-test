/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedaddressproducttypepallettype_2
Description		|	QUINTIQ table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_quintiq_reportedaddressproducttypepallettype_2 (
client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code',
lidl_country 			VARCHAR(4) 		NOT NULL 	COMMENT 'Country_2 code. Original field name bic_zmlila',
wh_id 		   			VARCHAR(5)   	NOT NULL 	COMMENT 'Warehouse ID',
address_id             	VARCHAR(512)   	NOT NULL 	COMMENT 'Delivery address_2 ID of the shipment leg',
product_type_id        	VARCHAR(512)   	NOT NULL 	COMMENT 'Product type ID of the shipment leg',
delivery_dt            	DATE   			NOT NULL 	COMMENT 'End of the delivery day to optimize for (max 24hrs after start)',
total_quantity			NUMBER(38,0)   	NULL 		COMMENT 'Sum of non-forecast shipment legs which are planned on a non-dummy_2 route',
total_pre_delivery      NUMBER(38,0)   	NULL 		COMMENT 'Sum of shipment legs which have IsPredelivery = true',
total_post_delivery     NUMBER(38,0)   	NULL 		COMMENT 'Sum of shipment legs which have IsPostDelivery = true',
pallet_type             VARCHAR(512)   	NOT NULL 	COMMENT 'Pallet type or derived pallet type of the shipment leg',
package_numbers         VARCHAR(512)   	NULL	 	COMMENT 'String of package_2 numbers of the shipment legs',
dwh_load_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created 			TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated 			TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
dwh_valid_from 			DATE 			NOT NULL 	COMMENT 'Valid from date',
dwh_valid_to 			DATE 			NOT NULL 	COMMENT 'Valid to date',
deleted_fg 				BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id, wh_id, address_id, product_type_id, delivery_dt, pallet_type, dwh_valid_from)
) COMMENT = 'On address_2 product type pallet type there are some KPIs that have to be reported'; 