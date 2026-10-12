/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedkpianalysis_2
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_reportedkpianalysis_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) OPTIONS(description='Source system'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
costs_pallet_pos BIGNUMERIC(38,10)
OPTIONS(description='Costs per pallet position is defined as the total real costs divided by the total number ofplanned pallet positions (ShipmentLegs with ShipmentLeg.IsPlanned = true).'),
creation_tmsp DATETIME OPTIONS(description='Time when the kpi\"s are stored'),
delivery_dt DATE NOT NULL OPTIONS(description='Date of the delivery'),
kpi_name STRING(512) NOT NULL OPTIONS(description='Which type of KPI analysis its'),
tours_cnt BIGNUMERIC(38,10) OPTIONS(description='Count of the number of tours in the plan'),
elke_tours_cnt BIGNUMERIC(38,10)
OPTIONS(description='The number of tours with HasStoreDelivery = true is counted over all routes with at least one shipment planned (Route.IsUsed = true).'),
tours_shift_cnt BIGNUMERIC(38,10) OPTIONS(description='Number of tours per shift'),
elke_tours_shift_cnt BIGNUMERIC(38,10)
OPTIONS(description='This calculates the number of tours with store delivery per shift (= Company.NumToursElke / Company.TotalNumShiftsElke)'),
planned_pos_cnt BIGNUMERIC(38,10)
OPTIONS(description='The number of all pallet positions that need to be delivered to a non-RDC address_2 (e.g. store) and are planned on the delivery day.This means the planned pallet positions excl. returns/collections is the sum ofall ShipmentLeg.Quantity1 with ShipmentLeg.IsPlanned = true and ShipmentLeg.DeliveryAddress.Type <> RDC.'),
total_costs_qty BIGNUMERIC(38,10)
OPTIONS(description='Total costs are defined as the total real costs plus the total penalty costs'),
drive_excess_tm_sum BIGNUMERIC(38,10)
OPTIONS(description='The sum of all minutes above the maximum driving time for each driver on all routes'),
shifts_cnt BIGNUMERIC(38,10) OPTIONS(description='Total number of shifts used in the plan'),
elke_shifts_cnt BIGNUMERIC(38,10)
OPTIONS(description='Counts the number of shifts (Route.NumOfDriverShifts) in all used routes with store deliveries'),
penalty_costs_qty BIGNUMERIC(38,10)
OPTIONS(description='The penalty costs are the sum of all penalty costs for constraints that are currently violated.'),
real_costs_qty BIGNUMERIC(38,10)
OPTIONS(description='Total real costs are defined as all costs that occur due to transportation of the orders.'),
used_routes_cnt BIGNUMERIC(38,10) OPTIONS(description='Total number of routes with at least one shipment leg planned'),
elke_used_routes_cnt BIGNUMERIC(38,10)
OPTIONS(description='Counts the number of routes that are in use for a store delivery'),
used_dist BIGNUMERIC(38,10)
OPTIONS(description='Total distance planned in all routes with at least one planned shipment'),
elke_used_dist BIGNUMERIC(38,10) OPTIONS(description='The distance planned on all used tours with store deliveries'),
waiting_tm_sum BIGNUMERIC(38,10)
OPTIONS(description='The total amount of time spent waiting across all routes on this day. More specifically this is the sum of all hours (hh:mm_2) of the duration of the activities of type Waiting and Calendar_2 Event for this delivery day, in minutes as real'),
work_excess_tm_sum BIGNUMERIC(38,10) OPTIONS(description='Total duration of excess of working time for all drivers'),
unplanned_pos_cnt BIGNUMERIC(38,10)
OPTIONS(description='Costs per pallet position is defined as the total real costs divided by the total number ofplanned pallet positions (ShipmentLegs with ShipmentLeg.IsPlanned = true).'),
util_dlv_avg BIGNUMERIC(38,10) OPTIONS(description='Utilization over all resources and outbound shipments (deliveries)'),
util_tm_avg BIGNUMERIC(38,10) OPTIONS(description='Utilization of the available time of a resource'),
elke_util_wh_avg BIGNUMERIC(38,10)
OPTIONS(description='The average of the utilization over all tours which have storedeliveries'),
dwh_load_id BIGNUMERIC(38,0) OPTIONS(description='Load id'),
dwh_created DATETIME OPTIONS(description='Record created at'),
dwh_updated DATETIME OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE OPTIONS(description='Valid to date'),
deleted_fg BOOL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, delivery_dt, kpi_name, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='QUINTIQ - Object type in quintiq is ReportedKPIAnalysis Stores all KPIs');