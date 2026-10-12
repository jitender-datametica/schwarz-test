/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedkpianalysis
Description		|	QUINTIQ table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_quintiq_reportedkpianalysis (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country code',
	lidl_country VARCHAR(3) COMMENT 'Country code. Original field name bic_zmlila',
	source_system VARCHAR(30) COMMENT 'Source system',
	wh_id VARCHAR(5) NOT NULL COMMENT 'Warehouse ID',
	costs_pallet_pos NUMBER(38,10) COMMENT 'Costs per pallet position is defined as the total real costs divided by the total number ofplanned pallet positions (ShipmentLegs with ShipmentLeg.IsPlanned = true).',
	creation_tmsp timestamp_ntz(9) COMMENT 'Time when the kpi\"s are stored',
	delivery_dt DATE NOT NULL COMMENT 'Date of the delivery',
	kpi_name VARCHAR(512) NOT NULL COMMENT 'Which type of KPI analysis its',
	tours_cnt NUMBER(38,10) COMMENT 'Count of the number of tours in the plan',
	elke_tours_cnt NUMBER(38,10) COMMENT 'The number of tours with HasStoreDelivery = true is counted over all routes with at least one shipment planned (Route.IsUsed = true).',
	tours_shift_cnt NUMBER(38,10) COMMENT 'Number of tours per shift',
	elke_tours_shift_cnt NUMBER(38,10) COMMENT 'This calculates the number of tours with store delivery per shift (= Company.NumToursElke / Company.TotalNumShiftsElke)',
	planned_pos_cnt NUMBER(38,10) COMMENT 'The number of all pallet positions that need to be delivered to a non-RDC address (e.g. store) and are planned on the delivery day.This means the planned pallet positions excl. returns/collections is the sum ofall ShipmentLeg.Quantity1 with ShipmentLeg.IsPlanned = true and ShipmentLeg.DeliveryAddress.Type <> RDC.',
	total_costs_qty NUMBER(38,10) COMMENT 'Total costs are defined as the total real costs plus the total penalty costs',
	drive_excess_tm_sum NUMBER(38,10) COMMENT 'The sum of all minutes above the maximum driving time for each driver on all routes',
	shifts_cnt NUMBER(38,10) COMMENT 'Total number of shifts used in the plan',
	elke_shifts_cnt NUMBER(38,10) COMMENT 'Counts the number of shifts (Route.NumOfDriverShifts) in all used routes with store deliveries',
	penalty_costs_qty NUMBER(38,10) COMMENT 'The penalty costs are the sum of all penalty costs for constraints that are currently violated.',
	real_costs_qty NUMBER(38,10) COMMENT 'Total real costs are defined as all costs that occur due to transportation of the orders.',
	used_routes_cnt NUMBER(38,10) COMMENT 'Total number of routes with at least one shipment leg planned',
	elke_used_routes_cnt NUMBER(38,10) COMMENT 'Counts the number of routes that are in use for a store delivery',
	used_dist NUMBER(38,10) COMMENT 'Total distance planned in all routes with at least one planned shipment',
	elke_used_dist NUMBER(38,10) COMMENT 'The distance planned on all used tours with store deliveries',
	waiting_tm_sum NUMBER(38,10) COMMENT 'The total amount of time spent waiting across all routes on this day. More specifically this is the sum of all hours (hh:mm) of the duration of the activities of type Waiting and Calendar Event for this delivery day, in minutes as real',
	work_excess_tm_sum NUMBER(38,10) COMMENT 'Total duration of excess of working time for all drivers',
	unplanned_pos_cnt NUMBER(38,10) COMMENT 'Costs per pallet position is defined as the total real costs divided by the total number ofplanned pallet positions (ShipmentLegs with ShipmentLeg.IsPlanned = true).',
	util_dlv_avg NUMBER(38,10) COMMENT 'Utilization over all resources and outbound shipments (deliveries)',
	util_tm_avg NUMBER(38,10) COMMENT 'Utilization of the available time of a resource',
	elke_util_wh_avg NUMBER(38,10) COMMENT 'The average of the utilization over all tours which have storedeliveries',
	dwh_load_id NUMBER(38,0) COMMENT 'Load id',
	dwh_created timestamp_ntz(9) COMMENT 'Record created at',
	dwh_updated timestamp_ntz(9) COMMENT 'Record updated at',
	dwh_valid_from DATE NOT NULL COMMENT 'Valid from date',
	dwh_valid_to DATE COMMENT 'Valid to date',
	deleted_fg BOOLEAN COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, delivery_dt, kpi_name, dwh_valid_from)
	)
COMMENT = 'QUINTIQ - Object type in quintiq is ReportedKPIAnalysis Stores all KPIs'
;
