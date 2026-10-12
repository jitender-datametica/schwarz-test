/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedaddproducttype_2
Description		|	QUINTIQ table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_quintiq_reportedaddproducttype_2 (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country_2 code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country_2 code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_id VARCHAR(5) NOT NULL COMMENT 'Warehouse ID',
	address_id VARCHAR(512) NOT NULL COMMENT 'Which address_2 belongs to this entry',
	picklist_zero_out_val NUMBER(38,0) COMMENT 'Amount of picklist for this product type with ordered quantity 1 below minimum value',
	delivery_dt DATE NOT NULL COMMENT 'End of the delivery day to optimize for (max 24hrs after start).',
	day_of_week NUMBER(38,0) COMMENT 'Stores the weekday of this delivery day',
	qty_zero_fg BOOLEAN COMMENT 'Indicator if there are picklists for this product type which have the ordered quantity 1 below the minimum value',
	product_type_id VARCHAR(512) NOT NULL COMMENT 'Which productType belongs to this entry',
	fixed_picked_share NUMBER(38,10) COMMENT 'Share fixed pallets of the picked pallets',
	created_ordered_share NUMBER(38,10) COMMENT 'Share picked and created pallets of ordered pallets',
	picked_ordered_share NUMBER(38,10) COMMENT 'Share picked pallets of the ordered pallets',
	fixed_pal_sum NUMBER(38,10) COMMENT 'Total forecasted floorspaces in WAMAS per store and product type',
	zeroed_floorspace_sum NUMBER(38,10) COMMENT 'The sum of all floor spaced which were zeroed by the parameter Min value set to zero.',
	manual_pallet_sum NUMBER(38,10) COMMENT 'Manually created shipmentlegs for this day',
	ordered_pallet_sum NUMBER(38,10) COMMENT 'All pallets which are created in Quintiq for all picklists',
	picked_pallet_sum NUMBER(38,10) COMMENT 'Amount of pallets which were picked within the current delivery day excluding manual created shipment legs',
	shipped_pallet_sum NUMBER(38,10) COMMENT 'Amount of pallets from WaWi with status_2 departure at the end of the delivery day for this product type',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	dwh_created timestamp_ntz(9) NOT NULL COMMENT 'Record created at',
	dwh_updated timestamp_ntz(9) NOT NULL COMMENT 'Record updated at',
	dwh_valid_from DATE NOT NULL COMMENT 'Valid from date',
	dwh_valid_to DATE NOT NULL COMMENT 'Valid to date',
	deleted_fg BOOLEAN NOT NULL COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, address_id, product_type_id, delivery_dt, dwh_valid_from)
	)
COMMENT = 'QUINTIQ - Object type in quintiq is reported address_2 product type on address_2 product type there are some kpis that have to be reported'
;
