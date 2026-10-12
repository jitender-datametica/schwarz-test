/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedkpi_1
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_reportedkpi_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
store_stops_avg BIGNUMERIC(38,10)
OPTIONS(description='The KPI counts the average number of stores that are visited during a tour_1'),
dist_per_shift_avg BIGNUMERIC(38,10)
OPTIONS(description='The KPI counts the average used distance per shift used for tours with store visits'),
dur_per_shift_avg STRING(512)
OPTIONS(description='The KPI calculates the average used duration per shift used for tours with store visits'),
costs_per_pallet_pos_sum BIGNUMERIC(38,10)
OPTIONS(description='Costs per pallet position is defined as the total real costs divided by the total number of planned pallet positions (ShipmentLegs with ShipmentLeg.IsPlanned = true).'),
delivery_dt DATE NOT NULL OPTIONS(description='Inidcates the delivery day of the reporting line '),
max_additional_dist_per_pallet BIGNUMERIC(38,10)
OPTIONS(description='The largest AdditionalDistancePerPallet of all tours during a delivery day'),
lanes_assigned_cnt BIGNUMERIC(38,10) OPTIONS(description='Total number of Lanes that have a Picklist assigned'),
lanes_blocked_cnt BIGNUMERIC(38,10) OPTIONS(description='Total number of blocked lanes'),
store_stops_cnt BIGNUMERIC(38,10) OPTIONS(description='The KPI counts the number of stops at a store over all tours'),
tours_cnt BIGNUMERIC(38,10) OPTIONS(description='Count of the number of tours in the plan'),
tours_elke_cnt BIGNUMERIC(38,10)
OPTIONS(description='The number of tours with HasStoreDelivery = true is counted over all routes with at least one shipment planned (Route.IsUsed = true).'),
tours_per_shift_cnt BIGNUMERIC(38,10) OPTIONS(description='Number of tours per shift '),
tours_per_shift_elke_cnt BIGNUMERIC(38,10)
OPTIONS(description='This calculates the number of tours with store delivery per shift (= Company.NumToursElke / Company.TotalNumShiftsElke)'),
planned_pos_cnt BIGNUMERIC(38,10)
OPTIONS(description='The number of all pallet positions that need to be delivered to a non-RDC address_1(e.g. store) and are planned on the delivery day. This means the planned pallet positions excl.returns/collections is the sum of all ShipmentLeg.Quantity1 with ShipmentLeg.IsPlanned = true and ShipmentLeg.DeliveryAddress.Type <> RDC.'),
duration_sum STRING(512) OPTIONS(description='sum overall Route.TotalDuration with Route.IsUsed = true'),
dur_per_shift_elke STRING(512) OPTIONS(description='Total Duration/TotalNumShiftsElke'),
pallets_1a_cnt BIGNUMERIC(38,10)
OPTIONS(description='This calculates the number of 1a pallets (store deliveries). It sums all ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = true'),
pallets_1a_per_shift_elke_cnt BIGNUMERIC(38,10) OPTIONS(description='TotalNum1aPallets/TotalNumShiftsElke'),
pallets_1b_cnt BIGNUMERIC(38,10)
OPTIONS(description='This calculates the number of 1b pallets (returns and transfers). It counts all ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = false'),
paid_shifts_cnt BIGNUMERIC(38,10)
OPTIONS(description='Total number of shifts used on resources with a shift-cost model'),
paid_single_shift_routes_cnt BIGNUMERIC(38,10)
OPTIONS(description='Total number of routes with single shifts on resources with a shif-cost model'),
shifts_cnt BIGNUMERIC(38,10) OPTIONS(description='Total number of shifts used in the plan'),
shifts_elke_cnt BIGNUMERIC(38,10)
OPTIONS(description='Counts the number of shifts (Route.NumOfDriverShifts) in all used routes with store deliveries'),
toll_costs_sum BIGNUMERIC(38,10)
OPTIONS(description='The sum of all toll costs which are incurred during the activities of a resource'),
routes_elke_cnt BIGNUMERIC(38,10)
OPTIONS(description='Counts the number of routes that are in use for a store delivery'),
dist_sum BIGNUMERIC(38,10)
OPTIONS(description='Total distance planned in all routes with at least one planned shipment'),
dist_elke_sum BIGNUMERIC(38,10) OPTIONS(description='The distance planned on all used tours with store deliveries'),
dist_per_pallet_elke_sum BIGNUMERIC(38,10) OPTIONS(description='Used distance per number of pallets of type 1a'),
dist_per_shift_elke_sum BIGNUMERIC(38,10)
OPTIONS(description='Company.TotalUsedDistanceElke / Company.TotalNumShiftsElke'),
dur_user_sum STRING(512) OPTIONS(description='The sum of the user duration for all tours with store visits'),
util_sum BIGNUMERIC(38,10) OPTIONS(description='Utilization over all resources and all shipments'),
util_pallet_pos_elke BIGNUMERIC(38,10)
OPTIONS(description='The average utilization of the resources that are going to stores over all tours that have store delivery'),
util_wh_elke BIGNUMERIC(38,10)
OPTIONS(description='The average of the utilization over all tours which have storedeliveries'),
utilization_5_flop_tours_avg BIGNUMERIC(38,10)
OPTIONS(description='This counts the average utilization of the five tours which have the highest AdditionalDistancePerPalletPosition'),
constraint_violations_per_tour_avg BIGNUMERIC(38,10)
OPTIONS(description='The average constraint violations per TripForShipments is calculated by the number of constraint violations divided by the total number of TripForShipments that are planned for the delivery day'),
cost_per_pallet_position_excl_pickup BIGNUMERIC(38,10)
OPTIONS(description='Costs per pallet position is defined as the total real costs divided by the total number of planned pallet position pallet positions (ShipmentLeg.Quantity1 with ShipmentLeg.IsPlanned = true) with ShipmentLeg.DeliveryAddress.Type <> RDC.'),
store_stops_max_cnt BIGNUMERIC(38,0)
OPTIONS(description='The KPI counts the highest number of stops at a store during the delivery day'),
product_decay_transport_max_qty BIGNUMERIC(38,10)
OPTIONS(description='Maximum product decay in transport over all shipments on a delivery day'),
mins_outside_preferred_window_cnt BIGNUMERIC(38,10)
OPTIONS(description='Total minutes outside the preferred time window'),
mins_outside_tolerance_window_cnt BIGNUMERIC(38,10)
OPTIONS(description='Total minutes outside the tolerances of the preferred time window'),
addresses_max_drivers_hauliers_exceeded_cnt BIGNUMERIC(38,0)
OPTIONS(description='Count of the number of addresses where the number of drivers or the number of hauliers per day is exceeded'),
addresses_max_stops_per_delivery_day_exceeded_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of addresses where the maximum number of stops per delivery day are exceeded'),
addresses_max_undelivered_exceeded_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of addresses where the maximum number of undelivered pallets per delivery day are exceeded'),
addresses_max_vehicles_exceeded_cnt BIGNUMERIC(38,0)
OPTIONS(description='Count of the number of addresses where the number of vehicles per day is exceeded'),
addresses_unmanned_pallet_positions_exceeded_cnt BIGNUMERIC(38,0)
OPTIONS(description='Count of the number of addresses where the number pallets delivered as an unmanned delivery per day is exceeded'),
constraint_violations_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of constraint violations for the current plan over all routes.'),
contract_allocations_exceeded_cnt BIGNUMERIC(38,0)
OPTIONS(description='Count the number of contract allocations which are exceeded'),
within_tolerance_delivery_performance_pct BIGNUMERIC(38,10)
OPTIONS(description='Percentage to indicate how many shipmenst deliverd to store are delivered within the preferred time window with tolerances'),
utilization_time BIGNUMERIC(38,10) OPTIONS(description='Utilization of the available time of a resource'),
utilization_deliveries_1 BIGNUMERIC(38,10)
OPTIONS(description='Utilization over all resources and outbound shipments (deliveries)'),
unplanned_positions_cnt BIGNUMERIC(38,10)
OPTIONS(description='The number of all pallet positions that need to be delivered to a non-RDC address_1 (e.g. store) and are still unplanned. This means the planned pallet positions excl. returns/collections is the sum of all ShipmentLeg.Quantity1 with ShipmentLeg.IsPlanned = false and ShipmentLeg.DeliveryAddress.Type <> RDC.'),
max_additional_distance_per_pallet_tour_id STRING(512)
OPTIONS(description='The short ID of the tour_1 which had the largest AdditionalDistancePerPallet during a delivery day'),
total_working_time_excess_qty BIGNUMERIC(38,10)
OPTIONS(description='Total duration of excess of working time for all drivers'),
total_waiting_time_qty BIGNUMERIC(38,10)
OPTIONS(description='The total amount of time spent waiting across all routes on this day. More specifically this is the sum of all hours (hh:mm_1) of the duration of the activities of type Waiting and Calendar_1 Event for this delivery day, in minutes as real'),
paid_multi_shift_routes_total_cnt BIGNUMERIC(38,0)
OPTIONS(description='Total number of routes with multi shifts on resources with a shif-cost model'),
shift_indicator_elke_total_cnt BIGNUMERIC(38,10)
OPTIONS(description='Sum over all unique shiftIndicators which have IsStoreDelivery'),
routes_in_use_total_cnt BIGNUMERIC(38,0)
OPTIONS(description='Total number of routes with at least one shipment leg planned'),
driving_time_excess_total_sum BIGNUMERIC(38,10)
OPTIONS(description='Total duration of excess of driving time for all drivers'),
most_stops_stores_id STRING(5000)
OPTIONS(description='The KPI returns the ID of addresses which have the highest number of stops during the delivery day'),
picklists_without_lane_incl_dummy_pct BIGNUMERIC(38,10)
OPTIONS(description='Picklists (including dummy_1) without a lane assigned in comparison to all picklists'),
picklists_without_lane_pct BIGNUMERIC(38,10)
OPTIONS(description='Picklists without a lane assigned in comparison to all picklists'),
pallet_positions_without_lane_incl_dummy_pct BIGNUMERIC(38,10)
OPTIONS(description='Pallet positions (including dummy_1) without a lane assigned in comparison to all pallet positions'),
pallet_positions_without_lane_pct BIGNUMERIC(38,10)
OPTIONS(description='Pallet positions without a lane assigned in comparison to all pallet positions'),
above_max_multi_shift_pct BIGNUMERIC(38,10)
OPTIONS(description='Percentage of routes with multi shift above the maximum multi shift percentage'),
unplanned_pallet_positions_store_deliveries_cnt BIGNUMERIC(38,10)
OPTIONS(description='Sums the total unplanned and planned for next day pallet positions to stores'),
unplanned_pallet_positions_returns_cnt BIGNUMERIC(38,10)
OPTIONS(description='Sums the total unplanned and planned for next day pallet positions from stores and to/from non-stores'),
unloading_teams_excess_cnt BIGNUMERIC(38,0)
OPTIONS(description='Sum over all time periods of the number of unloading teams above the maximum per time period'),
product_availability_exceeded_tour_cnt BIGNUMERIC(38,0)
OPTIONS(description='Count of the number of tours where the product availability is exceeded'),
invalid_resource_dimensions_stops_cnt BIGNUMERIC(38,0)
OPTIONS(description='The total count of unique stops where the resource dimension is incorrect.'),
constraint_violations_tour_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of trips (tours) with constraint violations counts the TripForShipments which have at least one constraint violated.'),
infeasible_compartments_tour_cnt BIGNUMERIC(38,0)
OPTIONS(description='Count of the number of tours where the compartment configuration is infeasible'),
max_capacity_exceeded_tour_cnt BIGNUMERIC(38,0)
OPTIONS(description='Count of the number of tours where the pallet positions or weight is exceeded'),
max_dg_capacity_exceeded_tour_cnt BIGNUMERIC(38,0)
OPTIONS(description='Count of the number of tours where the ADR points or LQ weight is exceeded'),
max_distance_exceeded_tour_cnt BIGNUMERIC(38,0)
OPTIONS(description='Count of the number of tours where the maximum distance is exceeded'),
one_way_unallowed_tour_cnt BIGNUMERIC(38,0)
OPTIONS(description='Count of the number of tours planned as one way while not allowed'),
outside_wh_area_opening_tour_cnt BIGNUMERIC(38,0)
OPTIONS(description='Count of the number of tours which start or end outisde the warehouse area opening hours'),
incorrect_unloading_equipment_stops_cnt BIGNUMERIC(38,0)
OPTIONS(description='The total count of unique stops where the resource unload equipment is incorrect.'),
outside_delivery_day_route_cnt BIGNUMERIC(38,0)
OPTIONS(description='Count of the number of routes which start or end outside of the delivery day'),
planned_pallet_positions_store_deliveries_cnt BIGNUMERIC(38,10)
OPTIONS(description='Sums the total planned pallet positions to stores'),
planned_pallet_positions_returns_cnt BIGNUMERIC(38,10)
OPTIONS(description='Sums the total planned pallet positions from stores and to/from non-stores'),
pallet_positions_store_deliveries_per_shift_cnt BIGNUMERIC(38,10)
OPTIONS(description='Per store the number of pallet positions delivered per shift'),
pallet_positions_returns_cnt BIGNUMERIC(38,10)
OPTIONS(description='Sums all pallet positions from stores and to/from non-stores'),
lanes_unassigned_not_blocked_cnt BIGNUMERIC(38,10) OPTIONS(description='Total number of unassigned and unblocked lanes'),
pallet_positions_cnt BIGNUMERIC(38,10)
OPTIONS(description='Sums the total planned, unplanned and planned for next day pallet positions'),
excess_movements_cnt BIGNUMERIC(38,0)
OPTIONS(description='Sum over all time periods of the number of movements above the maximum per time period'),
pallet_positions_product_decay_transport_exceeded_cnt BIGNUMERIC(38,10)
OPTIONS(description='Sum of the number of pallets where the product decay in transport is above 100'),
averagenumstorestopsexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The KPI counts the average number of stores that are visited during a tour_1'),
costperpalletpositionexcldummy BIGNUMERIC(38,10)
OPTIONS(description='Costs per pallet position is defined as the total real costs divided by the total number of planned pallet positions (ShipmentLeg.Quantity1 with ShipmentLeg.IsPlanned = true). This includes all shipments (such as store returns, collection, store deliveries and any other types).'),
numpalletpositionsexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The number of pallet positions, planned, unplanned and planned for next day (excluding deactivated shipments).'),
numpalletpositionsreturnsexcldummy BIGNUMERIC(38,10)
OPTIONS(description='sum of pallet positions across all shipment legs where ToAddress is equal to RDCAddress that are not deactivated'),
numpalletpositionsstoredeliveriespershiftexcldummy BIGNUMERIC(38,10)
OPTIONS(description='Company.NumPlannedPalletPositionsStoreDeliveriesExclDummy/ Company.TotalNumShiftsExclDummy'),
numstorestopsexcldummy BIGNUMERIC(38,0)
OPTIONS(description='The KPI counts the number of stops at a store over all tours'),
numtourselkeexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The number of tours with HasStoreDelivery = true is counted over all routes with at least one shipment planned (Route.IsUsed = true).'),
numtoursexcldummy BIGNUMERIC(38,0)
OPTIONS(description='total number of tours across all routes where Route.IsUsed = true'),
numtourspershiftelkeexcldummy BIGNUMERIC(38,10)
OPTIONS(description='This calculates the number of tours with store delivery per shift (= Company.NumToursElkeExclDummy / Company.TotalNumShiftsElkeExclDummy)'),
numtourspershiftexcldummy BIGNUMERIC(38,10)
OPTIONS(description='total number of tours across all routes where Route.IsUsed = true / total number of driver shifts for all routes where route.IsUsed = true'),
totaldurationexcldummy STRING(512) OPTIONS(description='sum overall Route.TotalDuration with Route.IsUsed = true'),
totaldurationpershiftelkeexcldummy STRING(512)
OPTIONS(description='Total Duration ExclDummy /TotalNumShiftsElkeExclDummy'),
totalnum1apalletspershiftelkeexcldummy BIGNUMERIC(38,10)
OPTIONS(description='TotalNum1aPalletsExclDummy/TotalNumShiftsElkeExclDummy'),
totalnum1apalletsplannedexcldummy BIGNUMERIC(38,10)
OPTIONS(description='This calculates the number of 1a pallets (store deliveries). It sums all ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = true excluding resourceSet dummies'),
totalnum1bpalletsplannedexcldummy BIGNUMERIC(38,10)
OPTIONS(description='This calculates the number of 1b pallets (returns and transfers). It counts all ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = false excluding resourceSet dummies'),
totalnumshiftselkeexcldummy BIGNUMERIC(38,10)
OPTIONS(description='Counts the number of shifts (Route.NumOfDriverShifts) in all used routes with store deliveries'),
totalnumshiftsexcldummy BIGNUMERIC(38,0)
OPTIONS(description='Total number of driver shifts for all routes where route.IsUsed = true'),
totalpalletsdeliveredwithinpreferredwindowsexcldummy BIGNUMERIC(38,10)
OPTIONS(description='TotalPalletsDeliveredWithinPreferredWindowsExclDummy'),
totalroutesinuseelkeexcldummy BIGNUMERIC(38,10)
OPTIONS(description='Counts the number of routes that are in use for a store delivery'),
totalroutesinuseexcldummy BIGNUMERIC(38,0)
OPTIONS(description='Calculates the number of routes in use excluding the dummy_1 resourceSets'),
totaluseddistanceelkeexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The distance planned on all used tours with store deliveries'),
totaluseddistanceexcldummy BIGNUMERIC(38,10)
OPTIONS(description='sum of the distance travelled for all routes where route.IsUsed=true'),
totaluseddistanceperpalletelkeexcldummy BIGNUMERIC(38,10)
OPTIONS(description='Used distance per number of pallets of type 1a'),
totaluseddistancepershiftelkeexcldummy BIGNUMERIC(38,10)
OPTIONS(description='Company.TotalUsedDistanceElkeExclDummy / Company.TotalNumShiftsElkeExclDummy'),
totalusedduration STRING(512) OPTIONS(description='the total used duration for tours with store visits'),
totaluseddurationexcldummy STRING(512) OPTIONS(description='the total used duration for tours with store visits'),
totaluseddurationuserexcldummy STRING(512)
OPTIONS(description='The sum of the user duration for all tours with store visits'),
totalwaitingtimeexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total amount of time spent waiting across all routes on this day. More specifically this is the sum of all hours (hh:mm_1) of the duration of the activities of type Waiting and Calendar_1 Event for this delivery day, in minutes as real'),
utilization1excldummy BIGNUMERIC(38,10)
OPTIONS(description='sum of the totalutilization1 for all routes in the dataset divided by the sum of the total distance driven across all routes'),
utilizationdeliveries1excldummy BIGNUMERIC(38,10)
OPTIONS(description='Total utilization across all routes not including return shipments'),
utilizationpalletpositions BIGNUMERIC(38,10)
OPTIONS(description='Average pallet position utilization of all used routes'),
utilizationpalletpositionselkeexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The average utilization of the resources that are going to stores over all tours that have store delivery'),
utilizationpalletpositionsexcldummy BIGNUMERIC(38,10)
OPTIONS(description='Average pallet position utilization of all used routes'),
utilizationwarehouseelkeexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The average of the utilization over all tours which have storedeliveries'),
withinpreferreddeliveryperformance BIGNUMERIC(38,10)
OPTIONS(description='Percentage to indicate how many shipmenst deliverd to store are delivered within the preferred time window'),
costperpalletpositionexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The total real costs divided by the total number of planned pallet positions converted excluding the dummy_1 resource sets.'),
numpalletpositionsexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The converted number of pallet positions: planned, unplanned and planned for next day (excluding deactivated shipments) Excluding the dummy_1 resource sets'),
numplannedpalletpositionsstoredeliveriesconverted BIGNUMERIC(38,10)
OPTIONS(description='The number of converted planned pallet positions (number of 1a pallets converted) for store deliveries. It sums all converted ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = true and are planned on a route'),
numtoursnonstoredeliveryexcldummy BIGNUMERIC(38,0)
OPTIONS(description='Total number of used, non-dummy_1, non-resource Tours without store deliveries'),
numtourspershiftindicatorexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total number of used, non-dummy_1 Tours as a factor of the total number of IndicatorShifts on non-dummy_1 Routes'),
numtourspershiftindicatornonstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The average number of Tours per used, non-dummy_1 RouteInIndicatorShift without store deliveries on a non-resource Route'),
numtourspershiftindicatorstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The average number of Tours per used, non-dummy_1 RouteInIndicatorShift with store deliveries on a non-resource Route'),
numtourspershiftnonstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The average number of Tours per used, non-dummy_1 driver shift without store deliveries on a non-resource Route'),
numtourspershiftstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The average number of Tours per used, non-dummy_1 driver shift with store deliveries on a non-resource Route'),
numtoursstoredeliveryexcldummy BIGNUMERIC(38,0)
OPTIONS(description='Total number of used, non-dummy_1, non-resource Tours with store deliveries'),
sharesecondshiftindicatornonstoredeliveriesexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The percentage of used, non-dummy_1, non-resource routes with a second shift indicator and without store deliveries'),
sharesecondshiftindicatorsexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The percentage of used, non-dummy_1, non-resource routes with a second shift indicator'),
sharesecondshiftindicatorstoredeliveriesexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The percentage of used, non-dummy_1, non-resource routes with store deliveries and a second shift indicator'),
sharesecondshiftsexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The percentage of used, non-dummy_1 Routes with a second shift'),
sharesecondshiftsnonstoredeliveriesexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The percentage of used, non-dummy_1, non-resource routes with a second shift and without store deliveries'),
sharesecondshiftsstoredeliveriesexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The percentage of used, non-dummy_1, non-resource routes with store deliveries and a second shift'),
totaldurationfirstshiftsexcldummy STRING(512)
OPTIONS(description='The total duration, including waiting time, of used non-dummy_1 first shifts on non-resource routes'),
totaldurationfirstshiftsnonstoredeliveriesexcldummy STRING(512)
OPTIONS(description='The total duration, including waiting time, of used non-dummy_1 first shifts without store deliveries'),
totaldurationfirstshiftsstoredeliveriesexcldummy STRING(512)
OPTIONS(description='The total duration, including waiting time, of used non-dummy_1 first shifts with store deliveries'),
totaldurationnonstoredeliveriesexcldummy STRING(512)
OPTIONS(description='The total duration of used non-dummy_1, non-resource Routes without store deliveries'),
totaldurationperrouteexcldummy STRING(512)
OPTIONS(description='The average duration, including waiting time, per used non-dummy_1, non-resource route'),
totaldurationperroutenonstoredeliveriesexcldummy STRING(512)
OPTIONS(description='The average duration, including waiting time, per used non-dummy_1, non-resource route without store deliveries'),
totaldurationperroutestoredeliveriesexcldummy STRING(512)
OPTIONS(description='The average duration, including waiting time, per used non-dummy_1, non-resource route with store deliveries'),
totaldurationpershiftexcldummy STRING(512)
OPTIONS(description='The average duration, including waiting time, per used non-dummy_1 shift on a non-resource route'),
totaldurationpershiftindicatorexcldummy STRING(512)
OPTIONS(description='The average duration, including waiting time, per used non-dummy_1 shift indicator on a non-resource route'),
totaldurationpershiftindicatornonstoredeliveriesexcldummy STRING(512)
OPTIONS(description='The average duration, including waiting time, per used non-dummy_1 shift indicator without store deliveries on a non-resource route'),
totaldurationpershiftindicatorstoredeliveriesexcldummy STRING(512)
OPTIONS(description='The average duration, including waiting time, per used non-dummy_1 shift indicator with store deliveries on a non-resource route'),
totaldurationpershiftnonstoredeliveriesexcldummy STRING(512)
OPTIONS(description='The average duration, including waiting time, per used non-dummy_1 shift without store deliveries on a non-resource route'),
totaldurationpershiftstoredeliveriesexcldummy STRING(512)
OPTIONS(description='The average duration, including waiting time, per used non-dummy_1 shift with store deliveries on a non-resource route'),
totaldurationsecondshiftsexcldummy STRING(512)
OPTIONS(description='The total duration, including waiting time, of used non-dummy_1 second shifts on non-resource route'),
totaldurationsecondshiftsnonstoredeliveriesexcldummy STRING(512)
OPTIONS(description='The total duration, including waiting time, of used non-dummy_1 second shifts without store deliveries'),
totaldurationsecondshiftsstoredeliveriesexcldummy STRING(512)
OPTIONS(description='The total duration, including waiting time, of used non-dummy_1 second shifts with store deliveries'),
totaldurationstoredeliveriesexcldummy STRING(512)
OPTIONS(description='The total duration of used non-dummy_1, non-resource Routes with store deliveries'),
totalnum1apalletspershiftelkeexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='TotalNum1aPalletsExclDummy/TotalNumShiftsElkeExclDummy (Converted)'),
totalnum1apalletsplannedexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='This calculates the number of 1a pallets converted (store deliveries). It sums all ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = true and are planned on a route and route is not using dummy_1 resourceset'),
totalnum1bpalletsplannedexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='This calculates the number of 1b pallets converted (returns and transfers). It counts all ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = false Excluding the dummy_1 resourcesets'),
totalnumfirstshiftnonstoredeliveryexcldummy BIGNUMERIC(38,0)
OPTIONS(description='The total number of used, non-dummy_1 first shifts without store deliveries, excluding shifts on resource routes'),
totalnumfirstshiftsexcldummy BIGNUMERIC(38,0)
OPTIONS(description='The total number of used, non-dummy_1 first shifts, excluding shifts on resource routes'),
totalnumfirstshiftstoredeliveryexcldummy BIGNUMERIC(38,0)
OPTIONS(description='The total number of used, non-dummy_1 first shifts with store deliveries, excluding shifts on resource routes'),
totalnumpalletscapacityontournonstoredeliveriesexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total capacity on used, non-dummy_1, non-resource Tours without store deliveries'),
totalnumpalletscapacityontournonstoredeliveriesexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The total capacity converted on used, non-dummy_1, non-resource Tours without store deliveries'),
totalnumpalletscapacityontourstoredeliveriesexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total capacity on used, non-dummy_1, non-resource Tours with store deliveries'),
totalnumpalletscapacityontourstoredeliveriesexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The total capacity converted on used, non-dummy_1, non-resource Tours with store deliveries'),
totalnumpalletsplannedonroutenonstoredeliveriesexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets planned on used, non-dummy_1, non-resource Routes without store deliveries'),
totalnumpalletsplannedonroutenonstoredeliveriesexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets converted planned on used, non-dummy_1, non-resource Routes without store deliveries'),
totalnumpalletsplannedonroutestoredeliveriesexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets planned on used, non-dummy_1, non-resource Routes with store deliveries'),
totalnumpalletsplannedonroutestoredeliveriesexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets converted planned on used, non-dummy_1, non-resource Routes with store deliveries'),
totalnumpalletsplannedonshiftindicatorexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets planned on used, non-dummy_1 IndicatorShifts on non-resource Routes'),
totalnumpalletsplannedonshiftindicatorexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets converted planned on used, non-dummy_1 IndicatorShifts on non-resource Routes'),
totalnumpalletsplannedonshiftindicatornonstoredeliveriesexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets planned on used, non-dummy_1 IndicatorShifts on non-resource Routes without store deliveries'),
totalnumpalletsplannedonshiftindicatornonstoredeliveriesexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets converted planned on used, non-dummy_1 IndicatorShifts on non-resource Routes without store deliveries'),
totalnumpalletsplannedonshiftindicatorstoredeliveriesexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets planned on used, non-dummy_1 IndicatorShifts on non-resource Routes with store deliveries'),
totalnumpalletsplannedonshiftindicatorstoredeliveriesexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets converted planned on used, non-dummy_1 IndicatorShifts on non-resource Routes with store deliveries'),
totalnumpalletsplannedonshiftnonstoredeliveriesexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets planned on used, non-dummy_1 Shifts on non-resource Routes without store deliveries'),
totalnumpalletsplannedonshiftnonstoredeliveriesexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets converted planned on used, non-dummy_1 Shifts on non-resource Routes without store deliveries'),
totalnumpalletsplannedonshiftstoredeliveriesexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets planned on used, non-dummy_1 Shifts on non-resource Routes with store deliveries'),
totalnumpalletsplannedonshiftstoredeliveriesexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets converted planned on used, non-dummy_1 Shifts on non-resource Routes with store deliveries'),
totalnumpalletsplannedontournonstoredeliveriesexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets planned on used, non-dummy_1, non-resource Tours without store deliveries'),
totalnumpalletsplannedontournonstoredeliveriesexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets converted planned on used, non-dummy_1, non-resource Tours without store deliveries'),
totalnumpalletsplannedontourstoredeliveriesexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets planned on used, non-dummy_1, non-resource Tours with store deliveries'),
totalnumpalletsplannedontourstoredeliveriesexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets converted planned on used, non-dummy_1, non-resource Tours with store deliveries'),
totalnumpalletsplannedpershiftexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The average number of pallets planned per used, non-dummy_1 shift on a non-resource route'),
totalnumpalletsplannedpershiftexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The average number of pallets converted planned per used, non-dummy_1 shift on a non-resource route'),
totalnumpalletsplannedpershiftindicatorexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The average number of pallets planned per used, non-dummy_1 shift indicator on a non-resource route'),
totalnumpalletsplannedpershiftindicatorexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The average number of pallets converted planned per used, non-dummy_1 shift indicator on a non-resource route'),
totalnumpalletsplannedpershiftindicatornonstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The average number of pallets planned per used, non-dummy_1 shift indicator without store deliveries on a non-resource route'),
totalnumpalletsplannedpershiftindicatornonstoredeliveryexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The average number of pallets converted planned per used, non-dummy_1 shift indicator without store deliveries on a non-resource route'),
totalnumpalletsplannedpershiftindicatorstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The average number of pallets planned per used, non-dummy_1 shift indicator with store deliveries on a non-resource route'),
totalnumpalletsplannedpershiftindicatorstoredeliveryexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The average number of pallets converted planned per used, non-dummy_1 shift indicator with store deliveries on a non-resource route'),
totalnumpalletsplannedpershiftnonstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The average number of pallets planned per used, non-dummy_1 shift without store deliveries on a non-resource route'),
totalnumpalletsplannedpershiftnonstoredeliveryexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The average number of pallets converted planned per used, non-dummy_1 shift without store deliveries on a non-resource route'),
totalnumpalletsplannedpershiftstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The average number of pallets planned per used, non-dummy_1 shift with store deliveries on a non-resource route'),
totalnumpalletsplannedpershiftstoredeliveryexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The average number of pallets converted planned per used, non-dummy_1 shift with store deliveries on a non-resource route'),
totalnumpalletswithisdeliverytoexternalwarehouseplannedexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets for all shipment legs on non-dummy_1 routes which were delivered to an external warehouse'),
totalnumpalletswithispickingcrossdockingplannedexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets for all shipment legs on non-dummy_1 routes which were picked from cross docking'),
totalnumpalletswithisreceivingcrossdockingplannedexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets for all shipment legs on non-dummy_1 routes which were received from cross docking'),
totalnumpalletswithisstocktransferplannedexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets for all shipment legs on non-dummy_1 routes which were a stock transfer'),
totalnumsecondshiftnonstoredeliveryexcldummy BIGNUMERIC(38,0)
OPTIONS(description='The total number of used, non-dummy_1 second shifts without store deliveries, excluding shifts on resource routes'),
totalnumsecondshiftsexcldummy BIGNUMERIC(38,0)
OPTIONS(description='The total number of used, non-dummy_1 second shifts, excluding shifts on resource routes'),
totalnumsecondshiftstoredeliveryexcldummy BIGNUMERIC(38,0)
OPTIONS(description='The total number of used, non-dummy_1 second shifts with store deliveries, excluding shifts on resource routes'),
totalnumshiftindicatorelkeexcldummy BIGNUMERIC(38,10)
OPTIONS(description='Sum over all unique shiftIndicators which have IsStoreDelivery for non dummy_1 routes'),
totalnumshiftindicatorexcldummy BIGNUMERIC(38,10)
OPTIONS(description='Sum over indicator shifts of all used tours on non-dummy_1 routes'),
totalnumshiftindicatornonstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total number of used, non-dummy_1 shift indicators without store deliveries on non-resource Routes'),
totalnumshiftindicatorstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total number of used, non-dummy_1 shift indicators with store deliveries on non-resource Routes'),
totalnumshiftsnonstoredeliveryexcldummy BIGNUMERIC(38,0)
OPTIONS(description='The total number of used, non-dummy_1 driver shifts without store deliveries on non-resource Routes'),
totalnumshiftsstoredeliveryexcldummy BIGNUMERIC(38,0)
OPTIONS(description='The total number of used, non-dummy_1 driver shifts with store deliveries on non-resource Routes'),
totalroutesinusenonstoredeliveryexcldummy BIGNUMERIC(38,0)
OPTIONS(description='Total number of used, non-dummy_1, non-resource Routes without store deliveries'),
totalroutesinusestoredeliveryexcldummy BIGNUMERIC(38,0)
OPTIONS(description='Total number of used, non-dummy_1, non-resource Routes with store deliveries'),
totaluseddistancecngelkeexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1 Tours with store deliveries driven by CNG DriveTypes'),
totaluseddistancecngexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1 Tours driven by CNG DriveTypes'),
totaluseddistancecngnonstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1, non-resource Tours without store deliveries driven by CNG DriveTypes'),
totaluseddistancecngstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1, non-resource Tours with store deliveries driven by CNG DriveTypes'),
totaluseddistancedieselelkelexldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1 Tours with store deliveries driven by Diesel DriveTypes'),
totaluseddistancedieselexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1 Tours driven by diesel DriveTypes'),
totaluseddistancedieselnonstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1, non-resource Tours without store deliveries driven by diesel DriveTypes'),
totaluseddistancedieselstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1, non-resource Tours with store deliveries driven by diesel DriveTypes'),
totaluseddistanceelectricelkeexldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1 Tours with store deliveries driven by Electric DriveTypes'),
totaluseddistanceelectricexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1 Tours driven by electric DriveTypes'),
totaluseddistanceelectricnonstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1, non-resource Tours without store deliveries driven by electric DriveTypes'),
totaluseddistanceelectricstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1, non-resource Tours with store deliveries driven by electric DriveType'),
totaluseddistancehydrogenelkeexldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1 Tours with store deliveries driven by Hydrogen DriveTypes'),
totaluseddistancehydrogenexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1 Tours driven by Hydrogen DriveTypes'),
totaluseddistancehydrogennonstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1, non-resource Tours without store deliveries driven by hydrogen DriveTypes'),
totaluseddistancehydrogenstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1, non-resource Tours with store deliveries driven by hydrogen DriveTypes'),
totaluseddistancelngelkeexldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1 Tours with store deliveries driven by LNG DriveTypes'),
totaluseddistancelngexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1 Tours driven by LNG DriveTypes'),
totaluseddistancelngnonstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1, non-resource Tours without store deliveries driven by LNG DriveTypes'),
totaluseddistancelngstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance in km of used, non-dummy_1, non-resource Tours with store deliveries driven by LNG DriveTypes'),
totaluseddistancenonstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance traveled by all used, non-dummy_1 Tours without store deliveries on non-resource routes'),
totaluseddistanceperpalletelkeexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='Converted used distance per number of pallets of type 1a Excluding the dummy_1 resourcesets'),
totaluseddistanceperpalletexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total used distance of Tours as a factor of the total number of pallet positions excluding dummies and non-resource tours'),
totaluseddistanceperpalletexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The total used distance of Tours as a factor of the total number of converted pallet positions excluding dummies and non-resource tours'),
totaluseddistanceperpalletnonstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total used distance of Tours without store deliveries as a factor of the total number of pallet positions excluding dummies and non-resource tours'),
totaluseddistanceperpalletnonstoredeliveryexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The total used distance of Tours without store deliveries as a factor of the total number of converted pallet positions excluding dummies and non resource-tours'),
totaluseddistanceperpalletstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total used distance of Tours with store deliveries as a factor of the total number of pallet positions excluding dummies and non-resource tours'),
totaluseddistanceperpalletstoredeliveryexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The total used distance of Tours with store deliveries as a factor of the total number of converted pallet positions excluding dummies'),
totaluseddistancestoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total distance traveled by all used, non-dummy_1 Tours with store deliveries on non-resource routes'),
utilizationpalletpositionselkeexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The average converted utilization of the resources that are going to stores over all tours that have store delivery'),
utilizationwarehouseelkeexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The converted average of the utilization over all tours which have store deliveries, excluding the dummy_1 resource sets and tours which have no pickup (load actions) at the RDC'),
utilizationwarehouseexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The average of the utilization over all used tours on non-dummy_1 routes, excluding tours which have no pickup (load actions) at the RDC'),
utilizationwarehouseexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The converted average of the utilization over all used tours on non-dummy_1 routes, excluding tours which have no pickup (load actions) at the RDC'),
utilizationwarehousenonstoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The average utilization over all used Tours without store deliveries on non-dummy_1, non-resource Routes, excluding tours which have no pickup (load actions) at the RDC'),
utilizationwarehousenonstoredeliveryexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The average utilization of quantity1 converted over all used Tours without store deliveries on non-dummy_1, non-resource Routes, excluding tours which have no pickup (load actions) at the RDC'),
utilizationwarehousestoredeliveryexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The average utilization over all used Tours with store deliveries on non-dummy_1, non-resource Routes, excluding tours which have no pickup (load actions) at the RDC'),
utilizationwarehousestoredeliveryexcldummyconverted BIGNUMERIC(38,10)
OPTIONS(description='The average utilization of quantity1 converted over all used Tours with store deliveries on non-dummy_1, non-resource Routes, excluding tours which have no pickup (load actions) at the RDC'),
totalnumpalletswithisdeliverytointernalwarehouseplannedexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets for all shipment legs on non-dummy_1 routes which were delivered to an internal warehouse'),
totalnumpalletswithisdeliverytononfoodwarehouseplannedexcldummy BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets for all shipment legs on non-dummy_1 routes which were delivered to a non food warehouse'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, delivery_dt, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='The object ReportedKPIs in the RDCMatrix dataset gathers all relevant KPIs for this object from the Company object in the RDCDay dataset.');