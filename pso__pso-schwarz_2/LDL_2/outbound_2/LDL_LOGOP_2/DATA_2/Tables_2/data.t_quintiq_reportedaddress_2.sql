/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedaddress_2
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_reportedaddress_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
picklist_zero_out_val BIGNUMERIC(38,10)
OPTIONS(description='Amount of picklist for all product types with ordered quantity 1 below minimum value'),
pallet_pos_per_stop_avg BIGNUMERIC(38,10)
OPTIONS(description='The average number of pallet positions which were delivered to an address_2 per stop'),
calendar_week BIGNUMERIC(38,10) OPTIONS(description='CalendarWeek'),
delivery_dt DATE NOT NULL OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start).'),
dist_rdc BIGNUMERIC(38,10) OPTIONS(description='DistanceRDC'),
address_id STRING(512) NOT NULL OPTIONS(description='Id of address_2'),
addr_long_name STRING(512) OPTIONS(description='Address_2 name that covers most of the address_2 details'),
stops_cnt BIGNUMERIC(38,10) OPTIONS(description='Counts the number of stops at an address_2'),
fixed_picked_share BIGNUMERIC(38,10) OPTIONS(description='Share fixed pallets of the picked pallets'),
created_ordered_share BIGNUMERIC(38,10) OPTIONS(description='Share picked and created pallets of ordered pallets'),
picked_ordered_share BIGNUMERIC(38,10) OPTIONS(description='Share picked pallets of the ordered pallets'),
fixed_pallet_sum BIGNUMERIC(38,10) OPTIONS(description='total forecasted floorspaces in WAMAS per store'),
zeroed_floorspace_sum BIGNUMERIC(38,10)
OPTIONS(description='The sum of all floor spaced which were zeroed by the parameter Min value set to zero.'),
manual_pallet_sum BIGNUMERIC(38,10) OPTIONS(description='Manually created shipmentlegs for this day'),
ordered_pallet_sum BIGNUMERIC(38,10) OPTIONS(description='All pallets which are created in Quintiq for all picklists'),
picked_pallet_sum BIGNUMERIC(38,10)
OPTIONS(description='Amount of pallets which were picked within the current delivery day excluding manual created shipment legs'),
shipped_pallet_sum BIGNUMERIC(38,10)
OPTIONS(description='Amount of pallets from WaWi with status_2 departure at the end of the delivery day'),
extra_info_txt STRING(512) OPTIONS(description='Free text field to fill external information'),
special_market_fg BOOL
OPTIONS(description='TRUE if this address_2 is a special stores that require different delivery handling'),
qnty_set_to_zero_fg BOOL
OPTIONS(description='Indicator if there are picklists for all product types which have the ordered quantity 1 below the minimum value'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, address_id, delivery_dt, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='QUINTIQ - Object type in quintiq is ReportedAddress On address_2 there are some KPIs that have to be reported');