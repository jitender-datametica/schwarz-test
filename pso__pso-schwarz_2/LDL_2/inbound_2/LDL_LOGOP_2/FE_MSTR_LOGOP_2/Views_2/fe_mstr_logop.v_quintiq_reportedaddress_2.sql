/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedaddress_2
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_quintiq_reportedaddress_2 (
	client_id COMMENT 'Client id - calculated based on the country_2 code'
	,lidl_country COMMENT 'Country_2 code. Original field name bic_zmlila'
	,source_system COMMENT 'Source system'
	,wh_id COMMENT 'Warehouse ID'
	,picklist_zero_out_val COMMENT 'Amount of picklist for all product types with ordered quantity 1 below minimum value'
	,pallet_pos_per_stop_avg COMMENT 'The average number of pallet positions which were delivered to an address_2 per stop'
	,calendar_week COMMENT 'CalendarWeek'
	,delivery_dt COMMENT 'End of the delivery day to optimize for (max 24hrs after start).'
	,dist_rdc COMMENT 'DistanceRDC'
	,address_id COMMENT 'Id of address_2'
	,addr_long_name COMMENT 'Address_2 name that covers most of the address_2 details'
	,stops_cnt COMMENT 'Counts the number of stops at an address_2'
	,fixed_picked_share COMMENT 'Share fixed pallets of the picked pallets'
	,created_ordered_share COMMENT 'Share picked and created pallets of ordered pallets'
	,picked_ordered_share COMMENT 'Share picked pallets of the ordered pallets'
	,fixed_pallet_sum COMMENT 'total forecasted floorspaces in WAMAS per store'
	,zeroed_floorspace_sum COMMENT 'The sum of all floor spaced which were zeroed by the parameter Min value set to zero.'
	,manual_pallet_sum COMMENT 'Manually created shipmentlegs for this day'
	,ordered_pallet_sum COMMENT 'All pallets which are created in Quintiq for all picklists'
	,picked_pallet_sum COMMENT 'Amount of pallets which were picked within the current delivery day excluding manual created shipment legs'
	,shipped_pallet_sum COMMENT 'Amount of pallets from WaWi with status_2 departure at the end of the delivery day'
	,extra_info_txt COMMENT 'Free text field to fill external information'
	,special_market_fg COMMENT 'TRUE if this address_2 is a special stores that require different delivery handling'
	,qnty_set_to_zero_fg COMMENT 'Indicator if there are picklists for all product types which have the ordered quantity 1 below the minimum value'
	,dwh_load_id COMMENT 'Load id'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
	,dwh_valid_from COMMENT 'Valid from date'
	,dwh_valid_to COMMENT 'Valid to date'
	,deleted_fg COMMENT 'Flag if record is deleted'
	) 
COMMENT = 'QUINTIQ - prepared view on raw data'
AS 
SELECT
	client_id
	,lidl_country
	,source_system
	,wh_id
	,picklist_zero_out_val
	,pallet_pos_per_stop_avg
	,calendar_week
	,delivery_dt
	,dist_rdc
	,address_id
	,addr_long_name
	,stops_cnt
	,fixed_picked_share
	,created_ordered_share
	,picked_ordered_share
	,fixed_pallet_sum
	,zeroed_floorspace_sum
	,manual_pallet_sum
	,ordered_pallet_sum
	,picked_pallet_sum
	,shipped_pallet_sum
	,extra_info_txt
	,special_market_fg
	,qnty_set_to_zero_fg
	,dwh_load_id
	,dwh_created
	,dwh_updated
	,dwh_valid_from
	,dwh_valid_to
	,deleted_fg
FROM DATA.t_quintiq_reportedaddress_2
;