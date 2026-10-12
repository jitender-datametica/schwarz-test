/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedproducttype_1
Description		|	QUINTIQ table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_quintiq_reportedproducttype_1 (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country_1 code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country_1 code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_id VARCHAR(5) NOT NULL COMMENT 'Warehouse ID',
	picklist_zero_out_val NUMBER(38,10) COMMENT 'Amount of picklist for this product type with ordered quantity 1 below minimum value',
	delivery_dt DATE NOT NULL COMMENT 'End of the delivery day to optimize for (max 24hrs after start).',
	product_type_id VARCHAR(512) NOT NULL COMMENT 'Id of product type',
	qty_zero_fg BOOLEAN COMMENT 'Indicator if there are picklists for this product type which have the ordered quantity 1 below the minimum value',
	product_type_name VARCHAR(512) COMMENT 'product type name',
	fixed_picked_share NUMBER(38,10) COMMENT 'Share fixed pallets of the picked pallets',
	created_ordered_share NUMBER(38,10) COMMENT 'Share picked and created pallets of ordered pallets',
	picked_ordered_share NUMBER(38,10) COMMENT 'Share picked pallets of the ordered pallets',
	fixed_pallet_sum NUMBER(38,10) COMMENT 'total forecasted floorspaces in WAMAS per store and product type',
	zeroed_floorspace_sum NUMBER(38,10) COMMENT 'The sum of all floor spaced which were zeroed by the parameter Min value set to zero.',
	manual_picked_pallet_sum NUMBER(38,10) COMMENT 'Manual created shipmentlegs that are considered picked',
	ordered_pallet_sum NUMBER(38,10) COMMENT 'All pallets which are created in Quintiq for all picklists',
	picked_created_pallet_sum NUMBER(38,10) COMMENT 'Amount of pallets which were picked within the current delivery day for this product type',
	picked_pallet_sum NUMBER(38,10) COMMENT 'Amount of pallets which were picked within the current delivery day excluding manual created shipment legs',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
	dwh_valid_from DATE NOT NULL COMMENT 'Valid from date',
	dwh_valid_to DATE NOT NULL COMMENT 'Valid to date',
	deleted_fg BOOLEAN NOT NULL COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, delivery_dt, product_type_id, dwh_valid_from)
	)
COMMENT = 'QUINTIQ - Object type in quintiq is reported product type'
;
