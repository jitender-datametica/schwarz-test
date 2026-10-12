/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedaddproducttype
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_reportedaddproducttype (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
address_id STRING(512) NOT NULL OPTIONS(description='Which address belongs to this entry'),
picklist_zero_out_val BIGNUMERIC(38,0)
OPTIONS(description='Amount of picklist for this product type with ordered quantity 1 below minimum value'),
delivery_dt DATE NOT NULL OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start).'),
day_of_week BIGNUMERIC(38,0) OPTIONS(description='Stores the weekday of this delivery day'),
qty_zero_fg BOOL
OPTIONS(description='Indicator if there are picklists for this product type which have the ordered quantity 1 below the minimum value'),
product_type_id STRING(512) NOT NULL OPTIONS(description='Which productType belongs to this entry'),
fixed_picked_share BIGNUMERIC(38,10) OPTIONS(description='Share fixed pallets of the picked pallets'),
created_ordered_share BIGNUMERIC(38,10) OPTIONS(description='Share picked and created pallets of ordered pallets'),
picked_ordered_share BIGNUMERIC(38,10) OPTIONS(description='Share picked pallets of the ordered pallets'),
fixed_pal_sum BIGNUMERIC(38,10) OPTIONS(description='Total forecasted floorspaces in WAMAS per store and product type'),
zeroed_floorspace_sum BIGNUMERIC(38,10)
OPTIONS(description='The sum of all floor spaced which were zeroed by the parameter Min value set to zero.'),
manual_pallet_sum BIGNUMERIC(38,10) OPTIONS(description='Manually created shipmentlegs for this day'),
ordered_pallet_sum BIGNUMERIC(38,10) OPTIONS(description='All pallets which are created in Quintiq for all picklists'),
picked_pallet_sum BIGNUMERIC(38,10)
OPTIONS(description='Amount of pallets which were picked within the current delivery day excluding manual created shipment legs'),
shipped_pallet_sum BIGNUMERIC(38,10)
OPTIONS(description='Amount of pallets from WaWi with status departure at the end of the delivery day for this product type'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, address_id, product_type_id, delivery_dt, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='QUINTIQ - Object type in quintiq is reported address product type on address product type there are some kpis that have to be reported');