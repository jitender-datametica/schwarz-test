/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedkpianalysis_kpi
Description		|	QUINTIQ - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reportedkpianalysis_kpi (client_id
OPTIONS(description='Client id - calculated based on the country code'), lidl_country
OPTIONS(description='Country code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), costs_pallet_pos
OPTIONS(description='Costs per pallet position is defined as the total real costs divided by the total number ofplanned pallet positions (ShipmentLegs with ShipmentLeg.IsPlanned = true).'),
creation_tmsp OPTIONS(description='Time when the kpi\"s are stored'), delivery_dt
OPTIONS(description='Date of the delivery'), kpi_name OPTIONS(description='Which type of KPI analysis its'), tours_cnt
OPTIONS(description='Count of the number of tours in the plan'), elke_tours_cnt
OPTIONS(description='The number of tours with HasStoreDelivery = true is counted over all routes with at least one shipment planned (Route.IsUsed = true).'),
tours_shift_cnt OPTIONS(description='Number of tours per shift'), elke_tours_shift_cnt
OPTIONS(description='This calculates the number of tours with store delivery per shift (= Company.NumToursElke / Company.TotalNumShiftsElke)'),
planned_pos_cnt
OPTIONS(description='The number of all pallet positions that need to be delivered to a non-RDC address (e.g. store) and are planned on the delivery day.This means the planned pallet positions excl. returns/collections is the sum ofall ShipmentLeg.Quantity1 with ShipmentLeg.IsPlanned = true and ShipmentLeg.DeliveryAddress.Type <> RDC.'),
total_costs_qty OPTIONS(description='Total costs are defined as the total real costs plus the total penalty costs'),
drive_excess_tm_sum
OPTIONS(description='The sum of all minutes above the maximum driving time for each driver on all routes'), shifts_cnt
OPTIONS(description='Total number of shifts used in the plan'), elke_shifts_cnt
OPTIONS(description='Counts the number of shifts (Route.NumOfDriverShifts) in all used routes with store deliveries'),
penalty_costs_qty
OPTIONS(description='The penalty costs are the sum of all penalty costs for constraints that are currently violated.'),
real_costs_qty
OPTIONS(description='Total real costs are defined as all costs that occur due to transportation of the orders.'),
used_routes_cnt OPTIONS(description='Total number of routes with at least one shipment leg planned'),
elke_used_routes_cnt OPTIONS(description='Counts the number of routes that are in use for a store delivery'), used_dist
OPTIONS(description='Total distance planned in all routes with at least one planned shipment'), elke_used_dist
OPTIONS(description='The distance planned on all used tours with store deliveries'), waiting_tm_sum
OPTIONS(description='The total amount of time spent waiting across all routes on this day. More specifically this is the sum of all hours (hh:mm) of the duration of the activities of type Waiting and Calendar Event for this delivery day, in minutes as real'),
work_excess_tm_sum OPTIONS(description='Total duration of excess of working time for all drivers'), unplanned_pos_cnt
OPTIONS(description='Costs per pallet position is defined as the total real costs divided by the total number ofplanned pallet positions (ShipmentLegs with ShipmentLeg.IsPlanned = true).'),
util_dlv_avg OPTIONS(description='Utilization over all resources and outbound shipments (deliveries)'), util_tm_avg
OPTIONS(description='Utilization of the available time of a resource'), elke_util_wh_avg
OPTIONS(description='The average of the utilization over all tours which have storedeliveries'), dwh_load_id
OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted'), active_fg
OPTIONS(description='Flag if record is active')) OPTIONS(DESCRIPTION = `QUINTIQ - VIEW WITH FINAL KPIS FOR FE`) AS
SELECT client_id,
 lidl_country,
 source_system,
 wh_id,
 costs_pallet_pos,
 creation_tmsp,
 delivery_dt,
 kpi_name,
 tours_cnt,
 elke_tours_cnt,
 tours_shift_cnt,
 elke_tours_shift_cnt,
 planned_pos_cnt,
 total_costs_qty,
 drive_excess_tm_sum,
 shifts_cnt,
 elke_shifts_cnt,
 penalty_costs_qty,
 real_costs_qty,
 used_routes_cnt,
 elke_used_routes_cnt,
 used_dist,
 elke_used_dist,
 waiting_tm_sum,
 work_excess_tm_sum,
 unplanned_pos_cnt,
 util_dlv_avg,
 util_tm_avg,
 elke_util_wh_avg,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 IF(dwh_valid_to = SAFE_CAST('9999-12-30' as DATE), 1, 0) AS active_fg
FROM ldl_logop_fe_mstr_logop.v_quintiq_reportedkpianalysis;