/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedaddress
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reportedaddress (client_id
OPTIONS(description='Client id - calculated based on the country code'), lidl_country
OPTIONS(description='Country code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), picklist_zero_out_val
OPTIONS(description='Amount of picklist for all product types with ordered quantity 1 below minimum value'),
pallet_pos_per_stop_avg
OPTIONS(description='The average number of pallet positions which were delivered to an address per stop'), calendar_week
OPTIONS(description='CalendarWeek'), delivery_dt
OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start).'), dist_rdc
OPTIONS(description='DistanceRDC'), address_id OPTIONS(description='Id of address'), addr_long_name
OPTIONS(description='Address name that covers most of the address details'), stops_cnt
OPTIONS(description='Counts the number of stops at an address'), fixed_picked_share
OPTIONS(description='Share fixed pallets of the picked pallets'), created_ordered_share
OPTIONS(description='Share picked and created pallets of ordered pallets'), picked_ordered_share
OPTIONS(description='Share picked pallets of the ordered pallets'), fixed_pallet_sum
OPTIONS(description='total forecasted floorspaces in WAMAS per store'), zeroed_floorspace_sum
OPTIONS(description='The sum of all floor spaced which were zeroed by the parameter Min value set to zero.'),
manual_pallet_sum OPTIONS(description='Manually created shipmentlegs for this day'), ordered_pallet_sum
OPTIONS(description='All pallets which are created in Quintiq for all picklists'), picked_pallet_sum
OPTIONS(description='Amount of pallets which were picked within the current delivery day excluding manual created shipment legs'),
shipped_pallet_sum
OPTIONS(description='Amount of pallets from WaWi with status departure at the end of the delivery day'), extra_info_txt
OPTIONS(description='Free text field to fill external information'), special_market_fg
OPTIONS(description='TRUE if this address is a special stores that require different delivery handling'),
qnty_set_to_zero_fg
OPTIONS(description='Indicator if there are picklists for all product types which have the ordered quantity 1 below the minimum value'),
dwh_load_id OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted'))
OPTIONS(DESCRIPTION = `QUINTIQ - PREPARED VIEW ON RAW DATA`) AS SELECT *
FROM ldl_logop_data.t_quintiq_reportedaddress;