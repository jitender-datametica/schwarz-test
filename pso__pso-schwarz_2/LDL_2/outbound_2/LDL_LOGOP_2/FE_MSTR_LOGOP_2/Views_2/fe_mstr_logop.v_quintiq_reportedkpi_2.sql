/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedkpi_2
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reportedkpi_2 (client_id
OPTIONS(description='Client id - calculated based on the country_2 code'), lidl_country
OPTIONS(description='Country_2 code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), store_stops_avg
OPTIONS(description='The KPI counts the average number of stores that are visited during a tour_2'), dist_per_shift_avg
OPTIONS(description='The KPI counts the average used distance per shift used for tours with store visits'),
dur_per_shift_avg
OPTIONS(description='The KPI calculates the average used duration per shift used for tours with store visits'),
costs_per_pallet_pos_sum
OPTIONS(description='Costs per pallet position is defined as the total real costs divided by the total number of planned pallet positions (ShipmentLegs with ShipmentLeg.IsPlanned = true).'),
delivery_dt OPTIONS(description='Inidcates the delivery day of the reporting line '), max_additional_dist_per_pallet
OPTIONS(description='The largest AdditionalDistancePerPallet of all tours during a delivery day'), lanes_assigned_cnt
OPTIONS(description='Total number of Lanes that have a Picklist assigned'), lanes_blocked_cnt
OPTIONS(description='Total number of blocked lanes'), store_stops_cnt
OPTIONS(description='The KPI counts the number of stops at a store over all tours'), tours_cnt
OPTIONS(description='Count of the number of tours in the plan'), tours_elke_cnt
OPTIONS(description='The number of tours with HasStoreDelivery = true is counted over all routes with at least one shipment planned (Route.IsUsed = true).'),
tours_per_shift_cnt OPTIONS(description='Number of tours per shift '), tours_per_shift_elke_cnt
OPTIONS(description='This calculates the number of tours with store delivery per shift (= Company.NumToursElke / Company.TotalNumShiftsElke)'),
planned_pos_cnt
OPTIONS(description='The number of all pallet positions that need to be delivered to a non-RDC address_2(e.g. store) and are planned on the delivery day. This means the planned pallet positions excl.returns/collections is the sum of all ShipmentLeg.Quantity1 with ShipmentLeg.IsPlanned = true and ShipmentLeg.DeliveryAddress.Type <> RDC.'),
duration_sum OPTIONS(description='sum overall Route.TotalDuration with Route.IsUsed = true'), dur_per_shift_elke
OPTIONS(description='Total Duration/TotalNumShiftsElke'), pallets_1a_cnt
OPTIONS(description='This calculates the number of 1a pallets (store deliveries). It sums all ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = true'),
pallets_1a_per_shift_elke_cnt OPTIONS(description='TotalNum1aPallets/TotalNumShiftsElke'), pallets_1b_cnt
OPTIONS(description='This calculates the number of 1b pallets (returns and transfers). It counts all ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = false'),
paid_shifts_cnt OPTIONS(description='Total number of shifts used on resources with a shift-cost model'),
paid_single_shift_routes_cnt
OPTIONS(description='Total number of routes with single shifts on resources with a shif-cost model'), shifts_cnt
OPTIONS(description='Total number of shifts used in the plan'), shifts_elke_cnt
OPTIONS(description='Counts the number of shifts (Route.NumOfDriverShifts) in all used routes with store deliveries'),
toll_costs_sum OPTIONS(description='The sum of all toll costs which are incurred during the activities of a resource'),
routes_elke_cnt OPTIONS(description='Counts the number of routes that are in use for a store delivery'), dist_sum
OPTIONS(description='Total distance planned in all routes with at least one planned shipment'), dist_elke_sum
OPTIONS(description='The distance planned on all used tours with store deliveries'), dist_per_pallet_elke_sum
OPTIONS(description='Used distance per number of pallets of type 1a'), dist_per_shift_elke_sum
OPTIONS(description='Company.TotalUsedDistanceElke / Company.TotalNumShiftsElke'), dur_user_sum
OPTIONS(description='The sum of the user duration for all tours with store visits'), util_sum
OPTIONS(description='Utilization over all resources and all shipments'), util_pallet_pos_elke
OPTIONS(description='The average utilization of the resources that are going to stores over all tours that have store delivery'),
util_wh_elke OPTIONS(description='The average of the utilization over all tours which have storedeliveries'),
utilization_5_flop_tours_avg
OPTIONS(description='This counts the average utilization of the five tours which have the highest AdditionalDistancePerPalletPosition'),
constraint_violations_per_tour_avg
OPTIONS(description='The average constraint violations per TripForShipments is calculated by the number of constraint violations divided by the total number of TripForShipments that are planned for the delivery day'),
cost_per_pallet_position_excl_pickup
OPTIONS(description='Costs per pallet position is defined as the total real costs divided by the total number of planned pallet position pallet positions (ShipmentLeg.Quantity1 with ShipmentLeg.IsPlanned = true) with ShipmentLeg.DeliveryAddress.Type <> RDC.'),
store_stops_max_cnt OPTIONS(description='The KPI counts the highest number of stops at a store during the delivery day'),
product_decay_transport_max_qty
OPTIONS(description='Maximum product decay in transport over all shipments on a delivery day'),
mins_outside_preferred_window_cnt OPTIONS(description='Total minutes outside the preferred time window'),
mins_outside_tolerance_window_cnt
OPTIONS(description='Total minutes outside the tolerances of the preferred time window'),
addresses_max_drivers_hauliers_exceeded_cnt
OPTIONS(description='Count of the number of addresses where the number of drivers or the number of hauliers per day is exceeded'),
addresses_max_stops_per_delivery_day_exceeded_cnt
OPTIONS(description='The number of addresses where the maximum number of stops per delivery day are exceeded'),
addresses_max_undelivered_exceeded_cnt
OPTIONS(description='The number of addresses where the maximum number of undelivered pallets per delivery day are exceeded'),
addresses_max_vehicles_exceeded_cnt
OPTIONS(description='Count of the number of addresses where the number of vehicles per day is exceeded'),
addresses_unmanned_pallet_positions_exceeded_cnt
OPTIONS(description='Count of the number of addresses where the number pallets delivered as an unmanned delivery per day is exceeded'),
constraint_violations_cnt
OPTIONS(description='The number of constraint violations for the current plan over all routes.'),
contract_allocations_exceeded_cnt OPTIONS(description='Count the number of contract allocations which are exceeded'),
within_tolerance_delivery_performance_pct
OPTIONS(description='Percentage to indicate how many shipmenst deliverd to store are delivered within the preferred time window with tolerances'),
utilization_time OPTIONS(description='Utilization of the available time of a resource'), utilization_deliveries_1
OPTIONS(description='Utilization over all resources and outbound shipments (deliveries)'), unplanned_positions_cnt
OPTIONS(description='The number of all pallet positions that need to be delivered to a non-RDC address_2 (e.g. store) and are still unplanned. This means the planned pallet positions excl. returns/collections is the sum of all ShipmentLeg.Quantity1 with ShipmentLeg.IsPlanned = false and ShipmentLeg.DeliveryAddress.Type <> RDC.'),
max_additional_distance_per_pallet_tour_id
OPTIONS(description='The short ID of the tour_2 which had the largest AdditionalDistancePerPallet during a delivery day'),
total_working_time_excess_qty OPTIONS(description='Total duration of excess of working time for all drivers'),
total_waiting_time_qty
OPTIONS(description='The total amount of time spent waiting across all routes on this day. More specifically this is the sum of all hours (hh:mm_2) of the duration of the activities of type Waiting and Calendar_2 Event for this delivery day	in minutes as real'),
paid_multi_shift_routes_total_cnt
OPTIONS(description='Total number of routes with multi shifts on resources with a shif-cost model'),
shift_indicator_elke_total_cnt OPTIONS(description='Sum over all unique shiftIndicators which have IsStoreDelivery'),
routes_in_use_total_cnt OPTIONS(description='Total number of routes with at least one shipment leg planned'),
driving_time_excess_total_sum OPTIONS(description='Total duration of excess of driving time for all drivers'),
most_stops_stores_id
OPTIONS(description='The KPI returns the ID of addresses which have the highest number of stops during the delivery day'),
picklists_without_lane_incl_dummy_pct
OPTIONS(description='Picklists (including dummy_2) without a lane assigned in comparison to all picklists'),
picklists_without_lane_pct OPTIONS(description='Picklists without a lane assigned in comparison to all picklists'),
pallet_positions_without_lane_incl_dummy_pct
OPTIONS(description='Pallet positions (including dummy_2) without a lane assigned in comparison to all pallet positions'),
pallet_positions_without_lane_pct
OPTIONS(description='Pallet positions without a lane assigned in comparison to all pallet positions'),
above_max_multi_shift_pct
OPTIONS(description='Percentage of routes with multi shift above the maximum multi shift percentage'),
unplanned_pallet_positions_store_deliveries_cnt
OPTIONS(description='Sums the total unplanned and planned for next day pallet positions to stores'),
unplanned_pallet_positions_returns_cnt
OPTIONS(description='Sums the total unplanned and planned for next day pallet positions from stores and to/from non-stores'),
unloading_teams_excess_cnt
OPTIONS(description='Sum over all time periods of the number of unloading teams above the maximum per time period'),
product_availability_exceeded_tour_cnt
OPTIONS(description='Count of the number of tours where the product availability is exceeded'),
invalid_resource_dimensions_stops_cnt
OPTIONS(description='The total count of unique stops where the resource dimension is incorrect.'),
constraint_violations_tour_cnt
OPTIONS(description='The number of trips (tours) with constraint violations counts the TripForShipments which have at least one constraint violated.'),
infeasible_compartments_tour_cnt
OPTIONS(description='Count of the number of tours where the compartment configuration is infeasible'),
max_capacity_exceeded_tour_cnt
OPTIONS(description='Count of the number of tours where the pallet positions or weight is exceeded'),
max_dg_capacity_exceeded_tour_cnt
OPTIONS(description='Count of the number of tours where the ADR points or LQ weight is exceeded'),
max_distance_exceeded_tour_cnt
OPTIONS(description='Count of the number of tours where the maximum distance is exceeded'), one_way_unallowed_tour_cnt
OPTIONS(description='Count of the number of tours planned as one way while not allowed'),
outside_wh_area_opening_tour_cnt
OPTIONS(description='Count of the number of tours which start or end outisde the warehouse area opening hours'),
incorrect_unloading_equipment_stops_cnt
OPTIONS(description='The total count of unique stops where the resource unload equipment is incorrect.'),
outside_delivery_day_route_cnt
OPTIONS(description='Count of the number of routes which start or end outside of the delivery day'),
planned_pallet_positions_store_deliveries_cnt OPTIONS(description='Sums the total planned pallet positions to stores'),
planned_pallet_positions_returns_cnt
OPTIONS(description='Sums the total planned pallet positions from stores and to/from non-stores'),
pallet_positions_store_deliveries_per_shift_cnt
OPTIONS(description='Per store the number of pallet positions delivered per shift'), pallet_positions_returns_cnt
OPTIONS(description='Sums all pallet positions from stores and to/from non-stores'), lanes_unassigned_not_blocked_cnt
OPTIONS(description='Total number of unassigned and unblocked lanes'), pallet_positions_cnt
OPTIONS(description='Sums the total planned	unplanned and planned for next day pallet positions'), excess_movements_cnt
OPTIONS(description='Sum over all time periods of the number of movements above the maximum per time period'),
pallet_positions_product_decay_transport_exceeded_cnt
OPTIONS(description='Sum of the number of pallets where the product decay in transport is above 100'), dwh_load_id
OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted'),
averagenumstorestopsexcldummy
OPTIONS(description='The KPI counts the average number of stores that are visited during a tour_2'),
costperpalletpositionexcldummy
OPTIONS(description='Costs per pallet position is defined as the total real costs divided by the total number of planned pallet positions (ShipmentLeg.Quantity1 with ShipmentLeg.IsPlanned = true). This includes all shipments (such as store returns collection store deliveries and any other types).'),
costperpalletpositionexcldummyconverted
OPTIONS(description='The total real costs divided by the total number of planned pallet positions converted excluding the dummy_2 resource sets.'),
numpalletpositionsexcldummy
OPTIONS(description='The number of pallet positions planned unplanned and planned for next day (excluding deactivated shipments).'),
numpalletpositionsexcldummyconverted
OPTIONS(description='The converted number of pallet positions: planned unplanned and planned for next day (excluding deactivated shipments) Excluding the dummy_2 resource sets'),
numpalletpositionsstoredeliveriespershiftexcldummy
OPTIONS(description='Company.NumPlannedPalletPositionsStoreDeliveriesExclDummy/ Company.TotalNumShiftsExclDummy'),
numplannedpalletpositionsstoredeliveriesconverted
OPTIONS(description='The number of converted planned pallet positions (number of 1a pallets converted) for store deliveries. It sums all converted ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = true and are planned on a route'),
numstorestopsexcldummy OPTIONS(description='The KPI counts the number of stops at a store over all tours'),
numtourselkeexcldummy
OPTIONS(description='The number of tours with HasStoreDelivery = true is counted over all routes with at least one shipment planned (Route.IsUsed = true).'),
numtoursexcldummy OPTIONS(description='total number of tours across all routes where Route.IsUsed = true'),
numtoursnonstoredeliveryexcldummy
OPTIONS(description='Total number of used non-dummy_2 non-resource Tours without store deliveries'),
numtourspershiftelkeexcldummy
OPTIONS(description='This calculates the number of tours with store delivery per shift (= Company.NumToursElkeExclDummy / Company.TotalNumShiftsElkeExclDummy)'),
numtourspershiftexcldummy
OPTIONS(description='total number of tours across all routes where Route.IsUsed = true / total number of driver shifts for all routes where route.IsUsed = true'),
numtourspershiftindicatorexcldummy
OPTIONS(description='The total number of used non-dummy_2 Tours as a factor of the total number of IndicatorShifts on non-dummy_2 Routes'),
numtourspershiftindicatornonstoredeliveryexcldummy
OPTIONS(description='The average number of Tours per used non-dummy_2 RouteInIndicatorShift without store deliveries on a non-resource Route'),
numtourspershiftindicatorstoredeliveryexcldummy
OPTIONS(description='The average number of Tours per used non-dummy_2 RouteInIndicatorShift with store deliveries on a non-resource Route'),
numtourspershiftnonstoredeliveryexcldummy
OPTIONS(description='The average number of Tours per used non-dummy_2 driver shift without store deliveries on a non-resource Route'),
numtourspershiftstoredeliveryexcldummy
OPTIONS(description='The average number of Tours per used non-dummy_2 driver shift with store deliveries on a non-resource Route'),
numtoursstoredeliveryexcldummy
OPTIONS(description='Total number of used non-dummy_2 non-resource Tours with store deliveries'),
sharesecondshiftindicatornonstoredeliveriesexcldummy
OPTIONS(description='The percentage of used non-dummy_2 non-resource routes with a second shift indicator and without store deliveries'),
sharesecondshiftindicatorsexcldummy
OPTIONS(description='The percentage of used non-dummy_2 non-resource routes with a second shift indicator'),
sharesecondshiftindicatorstoredeliveriesexcldummy
OPTIONS(description='The percentage of used non-dummy_2 non-resource routes with store deliveries and a second shift indicator'),
sharesecondshiftsexcldummy OPTIONS(description='The percentage of used non-dummy_2 Routes with a second shift'),
sharesecondshiftsnonstoredeliveriesexcldummy
OPTIONS(description='The percentage of used non-dummy_2 non-resource routes with a second shift and without store deliveries'),
sharesecondshiftsstoredeliveriesexcldummy
OPTIONS(description='The percentage of used non-dummy_2 non-resource routes with store deliveries and a second shift'),
totaldurationexcldummy OPTIONS(description='sum overall Route.TotalDuration with Route.IsUsed = true'),
totaldurationfirstshiftsexcldummy
OPTIONS(description='The total duration including waiting time of used non-dummy_2 first shifts on non-resource routes'),
totaldurationfirstshiftsnonstoredeliveriesexcldummy
OPTIONS(description='The total duration including waiting time of used non-dummy_2 first shifts without store deliveries'),
totaldurationfirstshiftsstoredeliveriesexcldummy
OPTIONS(description='The total duration including waiting time of used non-dummy_2 first shifts with store deliveries'),
totaldurationnonstoredeliveriesexcldummy
OPTIONS(description='The total duration of used non-dummy_2 non-resource Routes without store deliveries'),
totaldurationperrouteexcldummy
OPTIONS(description='The average duration including waiting time per used non-dummy_2 non-resource route'),
totaldurationperroutenonstoredeliveriesexcldummy
OPTIONS(description='The average duration including waiting time per used non-dummy_2 non-resource route without store deliveries'),
totaldurationperroutestoredeliveriesexcldummy
OPTIONS(description='The average duration including waiting time per used non-dummy_2 non-resource route with store deliveries'),
totaldurationpershiftelkeexcldummy OPTIONS(description='Total Duration ExclDummy /TotalNumShiftsElkeExclDummy'),
totaldurationpershiftexcldummy
OPTIONS(description='The average duration including waiting time per used non-dummy_2 shift on a non-resource route'),
totaldurationpershiftindicatorexcldummy
OPTIONS(description='The average duration including waiting time per used non-dummy_2 shift indicator on a non-resource route'),
totaldurationpershiftindicatornonstoredeliveriesexcldummy
OPTIONS(description='The average duration including waiting time per used non-dummy_2 shift indicator without store deliveries on a non-resource route'),
totaldurationpershiftindicatorstoredeliveriesexcldummy
OPTIONS(description='The average duration including waiting time per used non-dummy_2 shift indicator with store deliveries on a non-resource route'),
totaldurationpershiftnonstoredeliveriesexcldummy
OPTIONS(description='The average duration including waiting time per used non-dummy_2 shift without store deliveries on a non-resource route'),
totaldurationpershiftstoredeliveriesexcldummy
OPTIONS(description='The average duration including waiting time per used non-dummy_2 shift with store deliveries on a non-resource route'),
totaldurationsecondshiftsexcldummy
OPTIONS(description='The total duration including waiting time of used non-dummy_2 second shifts on non-resource route'),
totaldurationsecondshiftsnonstoredeliveriesexcldummy
OPTIONS(description='The total duration including waiting time of used non-dummy_2 second shifts without store deliveries'),
totaldurationsecondshiftsstoredeliveriesexcldummy
OPTIONS(description='The total duration including waiting time of used non-dummy_2 second shifts with store deliveries'),
totaldurationstoredeliveriesexcldummy
OPTIONS(description='The total duration of used non-dummy_2 non-resource Routes with store deliveries'),
totalnum1apalletspershiftelkeexcldummy OPTIONS(description='TotalNum1aPalletsExclDummy/TotalNumShiftsElkeExclDummy'),
totalnum1apalletspershiftelkeexcldummyconverted
OPTIONS(description='TotalNum1aPalletsExclDummy/TotalNumShiftsElkeExclDummy (Converted)'),
totalnum1apalletsplannedexcldummy
OPTIONS(description='This calculates the number of 1a pallets (store deliveries). It sums all ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = true excluding resourceSet dummies'),
totalnum1apalletsplannedexcldummyconverted
OPTIONS(description='This calculates the number of 1a pallets converted (store deliveries). It sums all ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = true and are planned on a route and route is not using dummy_2 resourceset'),
totalnum1bpalletsplannedexcldummy
OPTIONS(description='This calculates the number of 1b pallets (returns and transfers). It counts all ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = false excluding resourceSet dummies'),
totalnum1bpalletsplannedexcldummyconverted
OPTIONS(description='This calculates the number of 1b pallets converted (returns and transfers). It counts all ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = false Excluding the dummy_2 resourcesets'),
totalnumfirstshiftnonstoredeliveryexcldummy
OPTIONS(description='The total number of used non-dummy_2 first shifts without store deliveries excluding shifts on resource routes'),
totalnumfirstshiftsexcldummy
OPTIONS(description='The total number of used non-dummy_2 first shifts excluding shifts on resource routes'),
totalnumfirstshiftstoredeliveryexcldummy
OPTIONS(description='The total number of used non-dummy_2 first shifts with store deliveries excluding shifts on resource routes'),
totalnumpalletscapacityontournonstoredeliveriesexcldummy
OPTIONS(description='The total capacity on used non-dummy_2 non-resource Tours without store deliveries'),
totalnumpalletscapacityontournonstoredeliveriesexcldummyconverted
OPTIONS(description='The total capacity converted on used non-dummy_2 non-resource Tours without store deliveries'),
totalnumpalletscapacityontourstoredeliveriesexcldummy
OPTIONS(description='The total capacity on used non-dummy_2 non-resource Tours with store deliveries'),
totalnumpalletscapacityontourstoredeliveriesexcldummyconverted
OPTIONS(description='The total capacity converted on used non-dummy_2 non-resource Tours with store deliveries'),
totalnumpalletsplannedonroutenonstoredeliveriesexcldummy
OPTIONS(description='The total number of pallets planned on used non-dummy_2 non-resource Routes without store deliveries'),
totalnumpalletsplannedonroutenonstoredeliveriesexcldummyconverted
OPTIONS(description='The total number of pallets converted planned on used non-dummy_2 non-resource Routes without store deliveries'),
totalnumpalletsplannedonroutestoredeliveriesexcldummy
OPTIONS(description='The total number of pallets planned on used non-dummy_2 non-resource Routes with store deliveries'),
totalnumpalletsplannedonroutestoredeliveriesexcldummyconverted
OPTIONS(description='The total number of pallets converted planned on used non-dummy_2 non-resource Routes with store deliveries'),
totalnumpalletsplannedonshiftindicatorexcldummy
OPTIONS(description='The total number of pallets planned on used non-dummy_2 IndicatorShifts on non-resource Routes'),
totalnumpalletsplannedonshiftindicatorexcldummyconverted
OPTIONS(description='The total number of pallets converted planned on used non-dummy_2 IndicatorShifts on non-resource Routes'),
totalnumpalletsplannedonshiftindicatornonstoredeliveriesexcldummy
OPTIONS(description='The total number of pallets planned on used non-dummy_2 IndicatorShifts on non-resource Routes without store deliveries'),
totalnumpalletsplannedonshiftindicatornonstoredeliveriesexcldummyconverted
OPTIONS(description='The total number of pallets converted planned on used non-dummy_2 IndicatorShifts on non-resource Routes without store deliveries'),
totalnumpalletsplannedonshiftindicatorstoredeliveriesexcldummy
OPTIONS(description='The total number of pallets planned on used non-dummy_2 IndicatorShifts on non-resource Routes with store deliveries'),
totalnumpalletsplannedonshiftindicatorstoredeliveriesexcldummyconverted
OPTIONS(description='The total number of pallets converted planned on used non-dummy_2 IndicatorShifts on non-resource Routes with store deliveries'),
totalnumpalletsplannedonshiftnonstoredeliveriesexcldummy
OPTIONS(description='The total number of pallets planned on used non-dummy_2 Shifts on non-resource Routes without store deliveries'),
totalnumpalletsplannedonshiftnonstoredeliveriesexcldummyconverted
OPTIONS(description='The total number of pallets converted planned on used non-dummy_2 Shifts on non-resource Routes without store deliveries'),
totalnumpalletsplannedonshiftstoredeliveriesexcldummy
OPTIONS(description='The total number of pallets planned on used non-dummy_2 Shifts on non-resource Routes with store deliveries'),
totalnumpalletsplannedonshiftstoredeliveriesexcldummyconverted
OPTIONS(description='The total number of pallets converted planned on used non-dummy_2 Shifts on non-resource Routes with store deliveries'),
totalnumpalletsplannedontournonstoredeliveriesexcldummy
OPTIONS(description='The total number of pallets planned on used non-dummy_2 non-resource Tours without store deliveries'),
totalnumpalletsplannedontournonstoredeliveriesexcldummyconverted
OPTIONS(description='The total number of pallets converted planned on used non-dummy_2 non-resource Tours without store deliveries'),
totalnumpalletsplannedontourstoredeliveriesexcldummy
OPTIONS(description='The total number of pallets planned on used non-dummy_2 non-resource Tours with store deliveries'),
totalnumpalletsplannedontourstoredeliveriesexcldummyconverted
OPTIONS(description='The total number of pallets converted planned on used non-dummy_2 non-resource Tours with store deliveries'),
totalnumpalletsplannedpershiftexcldummy
OPTIONS(description='The average number of pallets planned per used non-dummy_2 shift on a non-resource route'),
totalnumpalletsplannedpershiftexcldummyconverted
OPTIONS(description='The average number of pallets converted planned per used non-dummy_2 shift on a non-resource route'),
totalnumpalletsplannedpershiftindicatorexcldummy
OPTIONS(description='The average number of pallets planned per used non-dummy_2 shift indicator on a non-resource route'),
totalnumpalletsplannedpershiftindicatorexcldummyconverted
OPTIONS(description='The average number of pallets converted planned per used non-dummy_2 shift indicator on a non-resource route'),
totalnumpalletsplannedpershiftindicatornonstoredeliveryexcldummy
OPTIONS(description='The average number of pallets planned per used non-dummy_2 shift indicator without store deliveries on a non-resource route'),
totalnumpalletsplannedpershiftindicatornonstoredeliveryexcldummyconverted
OPTIONS(description='The average number of pallets converted planned per used non-dummy_2 shift indicator without store deliveries on a non-resource route'),
totalnumpalletsplannedpershiftindicatorstoredeliveryexcldummy
OPTIONS(description='The average number of pallets planned per used non-dummy_2 shift indicator with store deliveries on a non-resource route'),
totalnumpalletsplannedpershiftindicatorstoredeliveryexcldummyconverted
OPTIONS(description='The average number of pallets converted planned per used non-dummy_2 shift indicator with store deliveries on a non-resource route'),
totalnumpalletsplannedpershiftnonstoredeliveryexcldummy
OPTIONS(description='The average number of pallets planned per used non-dummy_2 shift without store deliveries on a non-resource route'),
totalnumpalletsplannedpershiftnonstoredeliveryexcldummyconverted
OPTIONS(description='The average number of pallets converted planned per used non-dummy_2 shift without store deliveries on a non-resource route'),
totalnumpalletsplannedpershiftstoredeliveryexcldummy
OPTIONS(description='The average number of pallets planned per used non-dummy_2 shift with store deliveries on a non-resource route'),
totalnumpalletsplannedpershiftstoredeliveryexcldummyconverted
OPTIONS(description='The average number of pallets converted planned per used non-dummy_2 shift with store deliveries on a non-resource route'),
totalnumpalletswithisdeliverytoexternalwarehouseplannedexcldummy
OPTIONS(description='The total number of pallets for all shipment legs on non-dummy_2 routes which were delivered to an external warehouse'),
totalnumpalletswithisdeliverytointernalwarehouseplannedexcldummy
OPTIONS(description='The total number of pallets for all shipment legs on non-dummy_2 routes which were delivered to an internal warehouse'),
totalnumpalletswithisdeliverytononfoodwarehouseplannedexcldummy
OPTIONS(description='The total number of pallets for all shipment legs on non-dummy_2 routes which were delivered to a non food warehouse'),
totalnumpalletswithispickingcrossdockingplannedexcldummy
OPTIONS(description='The total number of pallets for all shipment legs on non-dummy_2 routes which were picked from cross docking'),
totalnumpalletswithisreceivingcrossdockingplannedexcldummy
OPTIONS(description='The total number of pallets for all shipment legs on non-dummy_2 routes which were received from cross docking'),
totalnumpalletswithisstocktransferplannedexcldummy
OPTIONS(description='The total number of pallets for all shipment legs on non-dummy_2 routes which were a stock transfer'),
totalnumsecondshiftnonstoredeliveryexcldummy
OPTIONS(description='The total number of used non-dummy_2 second shifts without store deliveries excluding shifts on resource routes'),
totalnumsecondshiftsexcldummy
OPTIONS(description='The total number of used non-dummy_2 second shifts excluding shifts on resource routes'),
totalnumsecondshiftstoredeliveryexcldummy
OPTIONS(description='The total number of used non-dummy_2 second shifts with store deliveries excluding shifts on resource routes'),
totalnumshiftindicatorelkeexcldummy
OPTIONS(description='Sum over all unique shiftIndicators which have IsStoreDelivery for non dummy_2 routes'),
totalnumshiftindicatorexcldummy OPTIONS(description='Sum over indicator shifts of all used tours on non-dummy_2 routes'),
totalnumshiftindicatornonstoredeliveryexcldummy
OPTIONS(description='The total number of used non-dummy_2 shift indicators without store deliveries on non-resource Routes'),
totalnumshiftindicatorstoredeliveryexcldummy
OPTIONS(description='The total number of used non-dummy_2 shift indicators with store deliveries on non-resource Routes'),
totalnumshiftselkeexcldummy
OPTIONS(description='Counts the number of shifts (Route.NumOfDriverShifts) in all used routes with store deliveries'),
totalnumshiftsexcldummy OPTIONS(description='Total number of driver shifts for all routes where route.IsUsed = true'),
totalnumshiftsnonstoredeliveryexcldummy
OPTIONS(description='The total number of used non-dummy_2 driver shifts without store deliveries on non-resource Routes'),
totalnumshiftsstoredeliveryexcldummy
OPTIONS(description='The total number of used non-dummy_2 driver shifts with store deliveries on non-resource Routes'),
totalroutesinuseelkeexcldummy OPTIONS(description='Counts the number of routes that are in use for a store delivery'),
totalroutesinuseexcldummy OPTIONS(description='Calculates the number of routes in use excluding the dummy_2 resourceSets'),
totalroutesinusenonstoredeliveryexcldummy
OPTIONS(description='Total number of used non-dummy_2 non-resource Routes without store deliveries'),
totalroutesinusestoredeliveryexcldummy
OPTIONS(description='Total number of used non-dummy_2 non-resource Routes with store deliveries'),
totaluseddistancecngelkeexcldummy
OPTIONS(description='The total distance in km of used non-dummy_2 Tours with store deliveries driven by CNG DriveTypes'),
totaluseddistancecngexcldummy
OPTIONS(description='The total distance in km of used non-dummy_2 Tours driven by CNG DriveTypes'),
totaluseddistancecngnonstoredeliveryexcldummy
OPTIONS(description='The total distance in km of used non-dummy_2 non-resource Tours without store deliveries driven by CNG DriveTypes'),
totaluseddistancecngstoredeliveryexcldummy
OPTIONS(description='The total distance in km of used non-dummy_2 non-resource Tours with store deliveries driven by CNG DriveTypes'),
totaluseddistancedieselelkelexldummy
OPTIONS(description='The total distance in km of used non-dummy_2 Tours with store deliveries driven by Diesel DriveTypes'),
totaluseddistancedieselexcldummy
OPTIONS(description='The total distance in km of used non-dummy_2 Tours driven by diesel DriveTypes'),
totaluseddistancedieselnonstoredeliveryexcldummy
OPTIONS(description='The total distance in km of used non-dummy_2 non-resource Tours without store deliveries driven by diesel DriveTypes'),
totaluseddistancedieselstoredeliveryexcldummy
OPTIONS(description='The total distance in km of used non-dummy_2 non-resource Tours with store deliveries driven by diesel DriveTypes'),
totaluseddistanceelectricelkeexldummy
OPTIONS(description='The total distance in km of used non-dummy_2 Tours with store deliveries driven by Electric DriveTypes'),
totaluseddistanceelectricexcldummy
OPTIONS(description='The total distance in km of used non-dummy_2 Tours driven by electric DriveTypes'),
totaluseddistanceelectricnonstoredeliveryexcldummy
OPTIONS(description='The total distance in km of used non-dummy_2 non-resource Tours without store deliveries driven by electric DriveTypes'),
totaluseddistanceelectricstoredeliveryexcldummy
OPTIONS(description='The total distance in km of used non-dummy_2 non-resource Tours with store deliveries driven by electric DriveType'),
totaluseddistanceelkeexcldummy OPTIONS(description='The distance planned on all used tours with store deliveries'),
totaluseddistanceexcldummy OPTIONS(description='sum of the distance travelled for all routes where route.IsUsed=true'),
totaluseddistancehydrogenelkeexldummy
OPTIONS(description='The total distance in km of used non-dummy_2 Tours with store deliveries driven by Hydrogen DriveTypes'),
totaluseddistancehydrogenexcldummy
OPTIONS(description='The total distance in km of used non-dummy_2 Tours driven by Hydrogen DriveTypes'),
totaluseddistancehydrogennonstoredeliveryexcldummy
OPTIONS(description='The total distance in km of used non-dummy_2 non-resource Tours without store deliveries driven by hydrogen DriveTypes'),
totaluseddistancehydrogenstoredeliveryexcldummy
OPTIONS(description='The total distance in km of used non-dummy_2 non-resource Tours with store deliveries driven by hydrogen DriveTypes'),
totaluseddistancelngelkeexldummy
OPTIONS(description='The total distance in km of used non-dummy_2 Tours with store deliveries driven by LNG DriveTypes'),
totaluseddistancelngexcldummy
OPTIONS(description='The total distance in km of used non-dummy_2 Tours driven by LNG DriveTypes'),
totaluseddistancelngnonstoredeliveryexcldummy
OPTIONS(description='The total distance in km of used non-dummy_2 non-resource Tours without store deliveries driven by LNG DriveTypes'),
totaluseddistancelngstoredeliveryexcldummy
OPTIONS(description='The total distance in km of used non-dummy_2 non-resource Tours with store deliveries driven by LNG DriveTypes'),
totaluseddistancenonstoredeliveryexcldummy
OPTIONS(description='The total distance traveled by all used non-dummy_2 Tours without store deliveries on non-resource routes'),
totaluseddistanceperpalletelkeexcldummy OPTIONS(description='Used distance per number of pallets of type 1a'),
totaluseddistanceperpalletelkeexcldummyconverted
OPTIONS(description='Converted used distance per number of pallets of type 1a Excluding the dummy_2 resourcesets'),
totaluseddistanceperpalletexcldummy
OPTIONS(description='The total used distance of Tours as a factor of the total number of pallet positions excluding dummies and non-resource tours'),
totaluseddistanceperpalletexcldummyconverted
OPTIONS(description='The total used distance of Tours as a factor of the total number of converted pallet positions excluding dummies and non-resource tours'),
totaluseddistanceperpalletnonstoredeliveryexcldummy
OPTIONS(description='The total used distance of Tours without store deliveries as a factor of the total number of pallet positions excluding dummies and non-resource tours'),
totaluseddistanceperpalletnonstoredeliveryexcldummyconverted
OPTIONS(description='The total used distance of Tours without store deliveries as a factor of the total number of converted pallet positions excluding dummies and non resource-tours'),
totaluseddistanceperpalletstoredeliveryexcldummy
OPTIONS(description='The total used distance of Tours with store deliveries as a factor of the total number of pallet positions excluding dummies and non-resource tours'),
totaluseddistanceperpalletstoredeliveryexcldummyconverted
OPTIONS(description='The total used distance of Tours with store deliveries as a factor of the total number of converted pallet positions excluding dummies'),
totaluseddistancepershiftelkeexcldummy
OPTIONS(description='Company.TotalUsedDistanceElkeExclDummy / Company.TotalNumShiftsElkeExclDummy'),
totaluseddistancestoredeliveryexcldummy
OPTIONS(description='The total distance traveled by all used non-dummy_2 Tours with store deliveries on non-resource routes'),
totaluseddurationuserexcldummy OPTIONS(description='The sum of the user duration for all tours with store visits'),
utilization1excldummy
OPTIONS(description='sum of the totalutilization1 for all routes in the dataset divided by the sum of the total distance driven across all routes'),
utilizationdeliveries1excldummy
OPTIONS(description='Total utilization across all routes not including return shipments'),
utilizationpalletpositionselkeexcldummy
OPTIONS(description='The average utilization of the resources that are going to stores over all tours that have store delivery'),
utilizationpalletpositionselkeexcldummyconverted
OPTIONS(description='The average converted utilization of the resources that are going to stores over all tours that have store delivery'),
utilizationwarehouseelkeexcldummy
OPTIONS(description='The average of the utilization over all tours which have storedeliveries'),
utilizationwarehouseelkeexcldummyconverted
OPTIONS(description='The converted average of the utilization over all tours which have store deliveries excluding the dummy_2 resource sets and tours which have no pickup (load actions) at the RDC'),
utilizationwarehouseexcldummy
OPTIONS(description='The average of the utilization over all used tours on non-dummy_2 routes excluding tours which have no pickup (load actions) at the RDC'),
utilizationwarehouseexcldummyconverted
OPTIONS(description='The converted average of the utilization over all used tours on non-dummy_2 routes excluding tours which have no pickup (load actions) at the RDC'),
utilizationwarehousenonstoredeliveryexcldummy
OPTIONS(description='The average utilization over all used Tours without store deliveries on non-dummy_2 non-resource Routes excluding tours which have no pickup (load actions) at the RDC'),
utilizationwarehousenonstoredeliveryexcldummyconverted
OPTIONS(description='The average utilization of quantity1 converted over all used Tours without store deliveries on non-dummy_2 non-resource Routes excluding tours which have no pickup (load actions) at the RDC'),
utilizationwarehousestoredeliveryexcldummy
OPTIONS(description='The average utilization over all used Tours with store deliveries on non-dummy_2 non-resource Routes excluding tours which have no pickup (load actions) at the RDC'),
utilizationwarehousestoredeliveryexcldummyconverted
OPTIONS(description='The average utilization of quantity1 converted over all used Tours with store deliveries on non-dummy_2 non-resource Routes excluding tours which have no pickup (load actions) at the RDC'))
OPTIONS(DESCRIPTION = `QUINTIQ - PREPARED VIEW ON RAW DATA`) AS SELECT client_id,
 lidl_country,
 source_system,
 wh_id,
 store_stops_avg,
 dist_per_shift_avg,
 dur_per_shift_avg,
 costs_per_pallet_pos_sum,
 delivery_dt,
 max_additional_dist_per_pallet,
 lanes_assigned_cnt,
 lanes_blocked_cnt,
 store_stops_cnt,
 tours_cnt,
 tours_elke_cnt,
 tours_per_shift_cnt,
 tours_per_shift_elke_cnt,
 planned_pos_cnt,
 duration_sum,
 dur_per_shift_elke,
 pallets_1a_cnt,
 pallets_1a_per_shift_elke_cnt,
 pallets_1b_cnt,
 paid_shifts_cnt,
 paid_single_shift_routes_cnt,
 shifts_cnt,
 shifts_elke_cnt,
 toll_costs_sum,
 routes_elke_cnt,
 dist_sum,
 dist_elke_sum,
 dist_per_pallet_elke_sum,
 dist_per_shift_elke_sum,
 dur_user_sum,
 util_sum,
 util_pallet_pos_elke,
 util_wh_elke,
 utilization_5_flop_tours_avg,
 constraint_violations_per_tour_avg,
 cost_per_pallet_position_excl_pickup,
 store_stops_max_cnt,
 product_decay_transport_max_qty,
 mins_outside_preferred_window_cnt,
 mins_outside_tolerance_window_cnt,
 addresses_max_drivers_hauliers_exceeded_cnt,
 addresses_max_stops_per_delivery_day_exceeded_cnt,
 addresses_max_undelivered_exceeded_cnt,
 addresses_max_vehicles_exceeded_cnt,
 addresses_unmanned_pallet_positions_exceeded_cnt,
 constraint_violations_cnt,
 contract_allocations_exceeded_cnt,
 within_tolerance_delivery_performance_pct,
 utilization_time,
 utilization_deliveries_1,
 unplanned_positions_cnt,
 max_additional_distance_per_pallet_tour_id,
 total_working_time_excess_qty,
 total_waiting_time_qty,
 paid_multi_shift_routes_total_cnt,
 shift_indicator_elke_total_cnt,
 routes_in_use_total_cnt,
 driving_time_excess_total_sum,
 most_stops_stores_id,
 picklists_without_lane_incl_dummy_pct,
 picklists_without_lane_pct,
 pallet_positions_without_lane_incl_dummy_pct,
 pallet_positions_without_lane_pct,
 above_max_multi_shift_pct,
 unplanned_pallet_positions_store_deliveries_cnt,
 unplanned_pallet_positions_returns_cnt,
 unloading_teams_excess_cnt,
 product_availability_exceeded_tour_cnt,
 invalid_resource_dimensions_stops_cnt,
 constraint_violations_tour_cnt,
 infeasible_compartments_tour_cnt,
 max_capacity_exceeded_tour_cnt,
 max_dg_capacity_exceeded_tour_cnt,
 max_distance_exceeded_tour_cnt,
 one_way_unallowed_tour_cnt,
 outside_wh_area_opening_tour_cnt,
 incorrect_unloading_equipment_stops_cnt,
 outside_delivery_day_route_cnt,
 planned_pallet_positions_store_deliveries_cnt,
 planned_pallet_positions_returns_cnt,
 pallet_positions_store_deliveries_per_shift_cnt,
 pallet_positions_returns_cnt,
 lanes_unassigned_not_blocked_cnt,
 pallet_positions_cnt,
 excess_movements_cnt,
 pallet_positions_product_decay_transport_exceeded_cnt,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 averagenumstorestopsexcldummy,
 costperpalletpositionexcldummy,
 costperpalletpositionexcldummyconverted,
 numpalletpositionsexcldummy,
 numpalletpositionsexcldummyconverted,
 numpalletpositionsstoredeliveriespershiftexcldummy,
 numplannedpalletpositionsstoredeliveriesconverted,
 numstorestopsexcldummy,
 numtourselkeexcldummy,
 numtoursexcldummy,
 numtoursnonstoredeliveryexcldummy,
 numtourspershiftelkeexcldummy,
 numtourspershiftexcldummy,
 numtourspershiftindicatorexcldummy,
 numtourspershiftindicatornonstoredeliveryexcldummy,
 numtourspershiftindicatorstoredeliveryexcldummy,
 numtourspershiftnonstoredeliveryexcldummy,
 numtourspershiftstoredeliveryexcldummy,
 numtoursstoredeliveryexcldummy,
 sharesecondshiftindicatornonstoredeliveriesexcldummy,
 sharesecondshiftindicatorsexcldummy,
 sharesecondshiftindicatorstoredeliveriesexcldummy,
 sharesecondshiftsexcldummy,
 sharesecondshiftsnonstoredeliveriesexcldummy,
 sharesecondshiftsstoredeliveriesexcldummy,
 totaldurationexcldummy,
 totaldurationfirstshiftsexcldummy,
 totaldurationfirstshiftsnonstoredeliveriesexcldummy,
 totaldurationfirstshiftsstoredeliveriesexcldummy,
 totaldurationnonstoredeliveriesexcldummy,
 totaldurationperrouteexcldummy,
 totaldurationperroutenonstoredeliveriesexcldummy,
 totaldurationperroutestoredeliveriesexcldummy,
 totaldurationpershiftelkeexcldummy,
 totaldurationpershiftexcldummy,
 totaldurationpershiftindicatorexcldummy,
 totaldurationpershiftindicatornonstoredeliveriesexcldummy,
 totaldurationpershiftindicatorstoredeliveriesexcldummy,
 totaldurationpershiftnonstoredeliveriesexcldummy,
 totaldurationpershiftstoredeliveriesexcldummy,
 totaldurationsecondshiftsexcldummy,
 totaldurationsecondshiftsnonstoredeliveriesexcldummy,
 totaldurationsecondshiftsstoredeliveriesexcldummy,
 totaldurationstoredeliveriesexcldummy,
 totalnum1apalletspershiftelkeexcldummy,
 totalnum1apalletspershiftelkeexcldummyconverted,
 totalnum1apalletsplannedexcldummy,
 totalnum1apalletsplannedexcldummyconverted,
 totalnum1bpalletsplannedexcldummy,
 totalnum1bpalletsplannedexcldummyconverted,
 totalnumfirstshiftnonstoredeliveryexcldummy,
 totalnumfirstshiftsexcldummy,
 totalnumfirstshiftstoredeliveryexcldummy,
 totalnumpalletscapacityontournonstoredeliveriesexcldummy,
 totalnumpalletscapacityontournonstoredeliveriesexcldummyconverted,
 totalnumpalletscapacityontourstoredeliveriesexcldummy,
 totalnumpalletscapacityontourstoredeliveriesexcldummyconverted,
 totalnumpalletsplannedonroutenonstoredeliveriesexcldummy,
 totalnumpalletsplannedonroutenonstoredeliveriesexcldummyconverted,
 totalnumpalletsplannedonroutestoredeliveriesexcldummy,
 totalnumpalletsplannedonroutestoredeliveriesexcldummyconverted,
 totalnumpalletsplannedonshiftindicatorexcldummy,
 totalnumpalletsplannedonshiftindicatorexcldummyconverted,
 totalnumpalletsplannedonshiftindicatornonstoredeliveriesexcldummy,
 totalnumpalletsplannedonshiftindicatornonstoredeliveriesexcldummyconverted,
 totalnumpalletsplannedonshiftindicatorstoredeliveriesexcldummy,
 totalnumpalletsplannedonshiftindicatorstoredeliveriesexcldummyconverted,
 totalnumpalletsplannedonshiftnonstoredeliveriesexcldummy,
 totalnumpalletsplannedonshiftnonstoredeliveriesexcldummyconverted,
 totalnumpalletsplannedonshiftstoredeliveriesexcldummy,
 totalnumpalletsplannedonshiftstoredeliveriesexcldummyconverted,
 totalnumpalletsplannedontournonstoredeliveriesexcldummy,
 totalnumpalletsplannedontournonstoredeliveriesexcldummyconverted,
 totalnumpalletsplannedontourstoredeliveriesexcldummy,
 totalnumpalletsplannedontourstoredeliveriesexcldummyconverted,
 totalnumpalletsplannedpershiftexcldummy,
 totalnumpalletsplannedpershiftexcldummyconverted,
 totalnumpalletsplannedpershiftindicatorexcldummy,
 totalnumpalletsplannedpershiftindicatorexcldummyconverted,
 totalnumpalletsplannedpershiftindicatornonstoredeliveryexcldummy,
 totalnumpalletsplannedpershiftindicatornonstoredeliveryexcldummyconverted,
 totalnumpalletsplannedpershiftindicatorstoredeliveryexcldummy,
 totalnumpalletsplannedpershiftindicatorstoredeliveryexcldummyconverted,
 totalnumpalletsplannedpershiftnonstoredeliveryexcldummy,
 totalnumpalletsplannedpershiftnonstoredeliveryexcldummyconverted,
 totalnumpalletsplannedpershiftstoredeliveryexcldummy,
 totalnumpalletsplannedpershiftstoredeliveryexcldummyconverted,
 totalnumpalletswithisdeliverytoexternalwarehouseplannedexcldummy,
 totalnumpalletswithisdeliverytointernalwarehouseplannedexcldummy,
 totalnumpalletswithisdeliverytononfoodwarehouseplannedexcldummy,
 totalnumpalletswithispickingcrossdockingplannedexcldummy,
 totalnumpalletswithisreceivingcrossdockingplannedexcldummy,
 totalnumpalletswithisstocktransferplannedexcldummy,
 totalnumsecondshiftnonstoredeliveryexcldummy,
 totalnumsecondshiftsexcldummy,
 totalnumsecondshiftstoredeliveryexcldummy,
 totalnumshiftindicatorelkeexcldummy,
 totalnumshiftindicatorexcldummy,
 totalnumshiftindicatornonstoredeliveryexcldummy,
 totalnumshiftindicatorstoredeliveryexcldummy,
 totalnumshiftselkeexcldummy,
 totalnumshiftsexcldummy,
 totalnumshiftsnonstoredeliveryexcldummy,
 totalnumshiftsstoredeliveryexcldummy,
 totalroutesinuseelkeexcldummy,
 totalroutesinuseexcldummy,
 totalroutesinusenonstoredeliveryexcldummy,
 totalroutesinusestoredeliveryexcldummy,
 totaluseddistancecngelkeexcldummy,
 totaluseddistancecngexcldummy,
 totaluseddistancecngnonstoredeliveryexcldummy,
 totaluseddistancecngstoredeliveryexcldummy,
 totaluseddistancedieselelkelexldummy,
 totaluseddistancedieselexcldummy,
 totaluseddistancedieselnonstoredeliveryexcldummy,
 totaluseddistancedieselstoredeliveryexcldummy,
 totaluseddistanceelectricelkeexldummy,
 totaluseddistanceelectricexcldummy,
 totaluseddistanceelectricnonstoredeliveryexcldummy,
 totaluseddistanceelectricstoredeliveryexcldummy,
 totaluseddistanceelkeexcldummy,
 totaluseddistanceexcldummy,
 totaluseddistancehydrogenelkeexldummy,
 totaluseddistancehydrogenexcldummy,
 totaluseddistancehydrogennonstoredeliveryexcldummy,
 totaluseddistancehydrogenstoredeliveryexcldummy,
 totaluseddistancelngelkeexldummy,
 totaluseddistancelngexcldummy,
 totaluseddistancelngnonstoredeliveryexcldummy,
 totaluseddistancelngstoredeliveryexcldummy,
 totaluseddistancenonstoredeliveryexcldummy,
 totaluseddistanceperpalletelkeexcldummy,
 totaluseddistanceperpalletelkeexcldummyconverted,
 totaluseddistanceperpalletexcldummy,
 totaluseddistanceperpalletexcldummyconverted,
 totaluseddistanceperpalletnonstoredeliveryexcldummy,
 totaluseddistanceperpalletnonstoredeliveryexcldummyconverted,
 totaluseddistanceperpalletstoredeliveryexcldummy,
 totaluseddistanceperpalletstoredeliveryexcldummyconverted,
 totaluseddistancepershiftelkeexcldummy,
 totaluseddistancestoredeliveryexcldummy,
 totaluseddurationuserexcldummy,
 utilization1excldummy,
 utilizationdeliveries1excldummy,
 utilizationpalletpositionselkeexcldummy,
 utilizationpalletpositionselkeexcldummyconverted,
 utilizationwarehouseelkeexcldummy,
 utilizationwarehouseelkeexcldummyconverted,
 utilizationwarehouseexcldummy,
 utilizationwarehouseexcldummyconverted,
 utilizationwarehousenonstoredeliveryexcldummy,
 utilizationwarehousenonstoredeliveryexcldummyconverted,
 utilizationwarehousestoredeliveryexcldummy,
 utilizationwarehousestoredeliveryexcldummyconverted
FROM ldl_logop_data.t_quintiq_reportedkpi_2;