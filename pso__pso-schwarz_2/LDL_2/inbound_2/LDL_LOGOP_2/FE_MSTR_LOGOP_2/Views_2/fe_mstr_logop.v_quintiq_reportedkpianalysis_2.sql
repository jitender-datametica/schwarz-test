/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedkpianalysis_2
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_quintiq_reportedkpianalysis_2 (
	client_id COMMENT 'Client id - calculated based on the country_2 code'
	,lidl_country COMMENT 'Country_2 code. Original field name bic_zmlila'
	,source_system COMMENT 'Source system'
	,wh_id COMMENT 'Warehouse ID'
	,costs_pallet_pos COMMENT 'Costs per pallet position is defined as the total real costs divided by the total number ofplanned pallet positions (ShipmentLegs with ShipmentLeg.IsPlanned = true).'
	,creation_tmsp COMMENT 'Time when the kpi\"s are stored'
	,delivery_dt COMMENT 'Date of the delivery'
	,kpi_name COMMENT 'Which type of KPI analysis its'
	,tours_cnt COMMENT 'Count of the number of tours in the plan'
	,elke_tours_cnt COMMENT 'The number of tours with HasStoreDelivery = true is counted over all routes with at least one shipment planned (Route.IsUsed = true).'
	,tours_shift_cnt COMMENT 'Number of tours per shift'
	,elke_tours_shift_cnt COMMENT 'This calculates the number of tours with store delivery per shift (= Company.NumToursElke / Company.TotalNumShiftsElke)'
	,planned_pos_cnt COMMENT 'The number of all pallet positions that need to be delivered to a non-RDC address_2 (e.g. store) and are planned on the delivery day.This means the planned pallet positions excl. returns/collections is the sum ofall ShipmentLeg.Quantity1 with ShipmentLeg.IsPlanned = true and ShipmentLeg.DeliveryAddress.Type <> RDC.'
	,total_costs_qty COMMENT 'Total costs are defined as the total real costs plus the total penalty costs'
	,drive_excess_tm_sum COMMENT 'The sum of all minutes above the maximum driving time for each driver on all routes'
	,shifts_cnt COMMENT 'Total number of shifts used in the plan'
	,elke_shifts_cnt COMMENT 'Counts the number of shifts (Route.NumOfDriverShifts) in all used routes with store deliveries'
	,penalty_costs_qty COMMENT 'The penalty costs are the sum of all penalty costs for constraints that are currently violated.'
	,real_costs_qty COMMENT 'Total real costs are defined as all costs that occur due to transportation of the orders.'
	,used_routes_cnt COMMENT 'Total number of routes with at least one shipment leg planned'
	,elke_used_routes_cnt COMMENT 'Counts the number of routes that are in use for a store delivery'
	,used_dist COMMENT 'Total distance planned in all routes with at least one planned shipment'
	,elke_used_dist COMMENT 'The distance planned on all used tours with store deliveries'
	,waiting_tm_sum COMMENT 'The total amount of time spent waiting across all routes on this day. More specifically this is the sum of all hours (hh:mm_2) of the duration of the activities of type Waiting and Calendar_2 Event for this delivery day, in minutes as real'
	,work_excess_tm_sum COMMENT 'Total duration of excess of working time for all drivers'
	,unplanned_pos_cnt COMMENT 'Costs per pallet position is defined as the total real costs divided by the total number ofplanned pallet positions (ShipmentLegs with ShipmentLeg.IsPlanned = true).'
	,util_dlv_avg COMMENT 'Utilization over all resources and outbound shipments (deliveries)'
	,util_tm_avg COMMENT 'Utilization of the available time of a resource'
	,elke_util_wh_avg COMMENT 'The average of the utilization over all tours which have storedeliveries'
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
	,costs_pallet_pos
	,creation_tmsp
	,delivery_dt
	,kpi_name
	,tours_cnt
	,elke_tours_cnt
	,tours_shift_cnt
	,elke_tours_shift_cnt
	,planned_pos_cnt
	,total_costs_qty
	,drive_excess_tm_sum
	,shifts_cnt
	,elke_shifts_cnt
	,penalty_costs_qty
	,real_costs_qty
	,used_routes_cnt
	,elke_used_routes_cnt
	,used_dist
	,elke_used_dist
	,waiting_tm_sum
	,work_excess_tm_sum
	,unplanned_pos_cnt
	,util_dlv_avg
	,util_tm_avg
	,elke_util_wh_avg
	,dwh_load_id
	,dwh_created
	,dwh_updated
	,dwh_valid_from
	,dwh_valid_to
	,deleted_fg
FROM DATA.t_quintiq_reportedkpianalysis_2
;