/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedaddress
Description		|	QUINTIQ table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_quintiq_reportedaddress (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_id VARCHAR(5) NOT NULL COMMENT 'Warehouse ID',
	picklist_zero_out_val NUMBER(38,10) COMMENT 'Amount of picklist for all product types with ordered quantity 1 below minimum value',
	pallet_pos_per_stop_avg NUMBER(38,10) COMMENT 'The average number of pallet positions which were delivered to an address per stop',
	calendar_week NUMBER(38,10) COMMENT 'CalendarWeek',
	delivery_dt DATE NOT NULL COMMENT 'End of the delivery day to optimize for (max 24hrs after start).',
	dist_rdc NUMBER(38,10) COMMENT 'DistanceRDC',
	address_id VARCHAR(512) NOT NULL COMMENT 'Id of address',
	addr_long_name VARCHAR(512) COMMENT 'Address name that covers most of the address details',
	stops_cnt NUMBER(38,10) COMMENT 'Counts the number of stops at an address',
	fixed_picked_share NUMBER(38,10) COMMENT 'Share fixed pallets of the picked pallets',
	created_ordered_share NUMBER(38,10) COMMENT 'Share picked and created pallets of ordered pallets',
	picked_ordered_share NUMBER(38,10) COMMENT 'Share picked pallets of the ordered pallets',
	fixed_pallet_sum NUMBER(38,10) COMMENT 'total forecasted floorspaces in WAMAS per store',
	zeroed_floorspace_sum NUMBER(38,10) COMMENT 'The sum of all floor spaced which were zeroed by the parameter Min value set to zero.',
	manual_pallet_sum NUMBER(38,10) COMMENT 'Manually created shipmentlegs for this day',
	ordered_pallet_sum NUMBER(38,10) COMMENT 'All pallets which are created in Quintiq for all picklists',
	picked_pallet_sum NUMBER(38,10) COMMENT 'Amount of pallets which were picked within the current delivery day excluding manual created shipment legs',
	shipped_pallet_sum NUMBER(38,10) COMMENT 'Amount of pallets from WaWi with status departure at the end of the delivery day',
	extra_info_txt VARCHAR(512) COMMENT 'Free text field to fill external information',
	special_market_fg BOOLEAN COMMENT 'TRUE if this address is a special stores that require different delivery handling',
	qnty_set_to_zero_fg BOOLEAN COMMENT 'Indicator if there are picklists for all product types which have the ordered quantity 1 below the minimum value',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
	dwh_valid_from DATE NOT NULL COMMENT 'Valid from date',
	dwh_valid_to DATE NOT NULL COMMENT 'Valid to date',
	deleted_fg BOOLEAN NOT NULL COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, address_id, delivery_dt, dwh_valid_from)
	)
COMMENT = 'QUINTIQ - Object type in quintiq is ReportedAddress On address there are some KPIs that have to be reported'
;
