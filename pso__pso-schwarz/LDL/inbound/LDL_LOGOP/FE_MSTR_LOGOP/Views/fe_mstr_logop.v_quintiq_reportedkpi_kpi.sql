/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedkpi_kpi
Description		|	QUINTIQ - view with final KPIs for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_QUINTIQ_REPORTEDKPI_KPI(
  CLIENT_ID COMMENT 'Client id - calculated based on the country code'
, LIDL_COUNTRY COMMENT 'Country code. Original field name bic_zmlila'
, SOURCE_SYSTEM COMMENT 'Source system'
, WH_ID COMMENT 'Warehouse ID'
, STORE_STOPS_AVG COMMENT 'The KPI counts the average number of stores that are visited during a tour'
, DIST_PER_SHIFT_AVG COMMENT 'The KPI counts the average used distance per shift used for tours with store visits'
, DUR_PER_SHIFT_AVG COMMENT 'The KPI calculates the average used duration per shift used for tours with store visits'
, COSTS_PER_PALLET_POS_SUM COMMENT 'Costs per pallet position is defined as the total real costs divided by the total number of planned pallet positions (ShipmentLegs with ShipmentLeg.IsPlanned = true).'
, DELIVERY_DT COMMENT 'Inidcates the delivery day of the reporting line '
, MAX_ADDITIONAL_DIST_PER_PALLET COMMENT 'The largest AdditionalDistancePerPallet of all tours during a delivery day'
, LANES_ASSIGNED_CNT COMMENT 'Total number of Lanes that have a Picklist assigned'
, LANES_BLOCKED_CNT COMMENT 'Total number of blocked lanes'
, STORE_STOPS_CNT COMMENT 'The KPI counts the number of stops at a store over all tours'
, TOURS_CNT COMMENT 'Count of the number of tours in the plan'
, TOURS_ELKE_CNT COMMENT 'The number of tours with HasStoreDelivery = true is counted over all routes with at least one shipment planned (Route.IsUsed = true).'
, TOURS_PER_SHIFT_CNT COMMENT 'Number of tours per shift '
, TOURS_PER_SHIFT_ELKE_CNT COMMENT 'This calculates the number of tours with store delivery per shift (= Company.NumToursElke / Company.TotalNumShiftsElke)'
, PLANNED_POS_CNT COMMENT 'The number of all pallet positions that need to be delivered to a non-RDC address(e.g. store) and are planned on the delivery day. This means the planned pallet positions excl.returns/collections is the sum of all ShipmentLeg.Quantity1 with ShipmentLeg.IsPlanned = true and ShipmentLeg.DeliveryAddress.Type <> RDC.'
, DURATION_SUM COMMENT 'sum overall Route.TotalDuration with Route.IsUsed = true'
, DUR_PER_SHIFT_ELKE COMMENT 'Total Duration/TotalNumShiftsElke'
, PALLETS_1A_CNT COMMENT 'This calculates the number of 1a pallets (store deliveries). It sums all ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = true'
, PALLETS_1A_PER_SHIFT_ELKE_CNT COMMENT 'TotalNum1aPallets/TotalNumShiftsElke'
, PALLETS_1B_CNT COMMENT 'This calculates the number of 1b pallets (returns and transfers). It counts all ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = false'
, PAID_SHIFTS_CNT COMMENT 'Total number of shifts used on resources with a shift-cost model'
, PAID_SINGLE_SHIFT_ROUTES_CNT COMMENT 'Total number of routes with single shifts on resources with a shif-cost model'
, SHIFTS_CNT COMMENT 'Total number of shifts used in the plan'
, SHIFTS_ELKE_CNT COMMENT 'Counts the number of shifts (Route.NumOfDriverShifts) in all used routes with store deliveries'
, TOLL_COSTS_SUM COMMENT 'The sum of all toll costs which are incurred during the activities of a resource'
, ROUTES_ELKE_CNT COMMENT 'Counts the number of routes that are in use for a store delivery'
, DIST_SUM COMMENT 'Total distance planned in all routes with at least one planned shipment'
, DIST_ELKE_SUM COMMENT 'The distance planned on all used tours with store deliveries'
, DIST_PER_PALLET_ELKE_SUM COMMENT 'Used distance per number of pallets of type 1a'
, DIST_PER_SHIFT_ELKE_SUM COMMENT 'Company.TotalUsedDistanceElke / Company.TotalNumShiftsElke'
, DUR_USER_SUM COMMENT 'The sum of the user duration for all tours with store visits'
, UTIL_SUM COMMENT 'Utilization over all resources and all shipments'
, UTIL_PALLET_POS_ELKE COMMENT 'The average utilization of the resources that are going to stores over all tours that have store delivery'
, UTIL_WH_ELKE COMMENT 'The average of the utilization over all tours which have storedeliveries'
, UTILIZATION_5_FLOP_TOURS_AVG COMMENT 'This counts the average utilization of the five tours which have the highest AdditionalDistancePerPalletPosition'
, CONSTRAINT_VIOLATIONS_PER_TOUR_AVG COMMENT 'The average constraint violations per TripForShipments is calculated by the number of constraint violations divided by the total number of TripForShipments that are planned for the delivery day'
, COST_PER_PALLET_POSITION_EXCL_PICKUP COMMENT 'Costs per pallet position is defined as the total real costs divided by the total number of planned pallet position pallet positions (ShipmentLeg.Quantity1 with ShipmentLeg.IsPlanned = true) with ShipmentLeg.DeliveryAddress.Type <> RDC.'
, STORE_STOPS_MAX_CNT COMMENT 'The KPI counts the highest number of stops at a store during the delivery day'
, PRODUCT_DECAY_TRANSPORT_MAX_QTY COMMENT 'Maximum product decay in transport over all shipments on a delivery day'
, MINS_OUTSIDE_PREFERRED_WINDOW_CNT COMMENT 'Total minutes outside the preferred time window'
, MINS_OUTSIDE_TOLERANCE_WINDOW_CNT COMMENT 'Total minutes outside the tolerances of the preferred time window'
, ADDRESSES_MAX_DRIVERS_HAULIERS_EXCEEDED_CNT COMMENT 'Count of the number of addresses where the number of drivers or the number of hauliers per day is exceeded'
, ADDRESSES_MAX_STOPS_PER_DELIVERY_DAY_EXCEEDED_CNT COMMENT 'The number of addresses where the maximum number of stops per delivery day are exceeded'
, ADDRESSES_MAX_UNDELIVERED_EXCEEDED_CNT COMMENT 'The number of addresses where the maximum number of undelivered pallets per delivery day are exceeded'
, ADDRESSES_MAX_VEHICLES_EXCEEDED_CNT COMMENT 'Count of the number of addresses where the number of vehicles per day is exceeded'
, ADDRESSES_UNMANNED_PALLET_POSITIONS_EXCEEDED_CNT COMMENT 'Count of the number of addresses where the number pallets delivered as an unmanned delivery per day is exceeded'
, CONSTRAINT_VIOLATIONS_CNT COMMENT 'The number of constraint violations for the current plan over all routes.'
, CONTRACT_ALLOCATIONS_EXCEEDED_CNT COMMENT 'Count the number of contract allocations which are exceeded'
, WITHIN_TOLERANCE_DELIVERY_PERFORMANCE_PCT COMMENT 'Percentage to indicate how many shipmenst deliverd to store are delivered within the preferred time window with tolerances'
, UTILIZATION_TIME COMMENT 'Utilization of the available time of a resource'
, UTILIZATION_DELIVERIES_1 COMMENT 'Utilization over all resources and outbound shipments (deliveries)'
, UNPLANNED_POSITIONS_CNT COMMENT 'The number of all pallet positions that need to be delivered to a non-RDC address (e.g. store) and are still unplanned. This means the planned pallet positions excl. returns/collections is the sum of all ShipmentLeg.Quantity1 with ShipmentLeg.IsPlanned = false and ShipmentLeg.DeliveryAddress.Type <> RDC.'
, MAX_ADDITIONAL_DISTANCE_PER_PALLET_TOUR_ID COMMENT 'The short ID of the tour which had the largest AdditionalDistancePerPallet during a delivery day'
, TOTAL_WORKING_TIME_EXCESS_QTY COMMENT 'Total duration of excess of working time for all drivers'
, TOTAL_WAITING_TIME_QTY COMMENT 'The total amount of time spent waiting across all routes on this day. More specifically this is the sum of all hours (hh:mm) of the duration of the activities of type Waiting and Calendar Event for this delivery day	in minutes as real'
, PAID_MULTI_SHIFT_ROUTES_TOTAL_CNT COMMENT 'Total number of routes with multi shifts on resources with a shif-cost model'
, SHIFT_INDICATOR_ELKE_TOTAL_CNT COMMENT 'Sum over all unique shiftIndicators which have IsStoreDelivery'
, ROUTES_IN_USE_TOTAL_CNT COMMENT 'Total number of routes with at least one shipment leg planned'
, DRIVING_TIME_EXCESS_TOTAL_SUM COMMENT 'Total duration of excess of driving time for all drivers'
, MOST_STOPS_STORES_ID COMMENT 'The KPI returns the ID of addresses which have the highest number of stops during the delivery day'
, PICKLISTS_WITHOUT_LANE_INCL_DUMMY_PCT COMMENT 'Picklists (including dummy) without a lane assigned in comparison to all picklists'
, PICKLISTS_WITHOUT_LANE_PCT COMMENT 'Picklists without a lane assigned in comparison to all picklists'
, PALLET_POSITIONS_WITHOUT_LANE_INCL_DUMMY_PCT COMMENT 'Pallet positions (including dummy) without a lane assigned in comparison to all pallet positions'
, PALLET_POSITIONS_WITHOUT_LANE_PCT COMMENT 'Pallet positions without a lane assigned in comparison to all pallet positions'
, ABOVE_MAX_MULTI_SHIFT_PCT COMMENT 'Percentage of routes with multi shift above the maximum multi shift percentage'
, UNPLANNED_PALLET_POSITIONS_STORE_DELIVERIES_CNT COMMENT 'Sums the total unplanned and planned for next day pallet positions to stores'
, UNPLANNED_PALLET_POSITIONS_RETURNS_CNT COMMENT 'Sums the total unplanned and planned for next day pallet positions from stores and to/from non-stores'
, UNLOADING_TEAMS_EXCESS_CNT COMMENT 'Sum over all time periods of the number of unloading teams above the maximum per time period'
, PRODUCT_AVAILABILITY_EXCEEDED_TOUR_CNT COMMENT 'Count of the number of tours where the product availability is exceeded'
, INVALID_RESOURCE_DIMENSIONS_STOPS_CNT COMMENT 'The total count of unique stops where the resource dimension is incorrect.'
, CONSTRAINT_VIOLATIONS_TOUR_CNT COMMENT 'The number of trips (tours) with constraint violations counts the TripForShipments which have at least one constraint violated.'
, INFEASIBLE_COMPARTMENTS_TOUR_CNT COMMENT 'Count of the number of tours where the compartment configuration is infeasible'
, MAX_CAPACITY_EXCEEDED_TOUR_CNT COMMENT 'Count of the number of tours where the pallet positions or weight is exceeded'
, MAX_DG_CAPACITY_EXCEEDED_TOUR_CNT COMMENT 'Count of the number of tours where the ADR points or LQ weight is exceeded'
, MAX_DISTANCE_EXCEEDED_TOUR_CNT COMMENT 'Count of the number of tours where the maximum distance is exceeded'
, ONE_WAY_UNALLOWED_TOUR_CNT COMMENT 'Count of the number of tours planned as one way while not allowed'
, OUTSIDE_WH_AREA_OPENING_TOUR_CNT COMMENT 'Count of the number of tours which start or end outisde the warehouse area opening hours'
, INCORRECT_UNLOADING_EQUIPMENT_STOPS_CNT COMMENT 'The total count of unique stops where the resource unload equipment is incorrect.'
, OUTSIDE_DELIVERY_DAY_ROUTE_CNT COMMENT 'Count of the number of routes which start or end outside of the delivery day'
, PLANNED_PALLET_POSITIONS_STORE_DELIVERIES_CNT COMMENT 'Sums the total planned pallet positions to stores'
, PLANNED_PALLET_POSITIONS_RETURNS_CNT COMMENT 'Sums the total planned pallet positions from stores and to/from non-stores'
, PALLET_POSITIONS_STORE_DELIVERIES_PER_SHIFT_CNT COMMENT 'Per store the number of pallet positions delivered per shift'
, PALLET_POSITIONS_RETURNS_CNT COMMENT 'Sums all pallet positions from stores and to/from non-stores'
, LANES_UNASSIGNED_NOT_BLOCKED_CNT COMMENT 'Total number of unassigned and unblocked lanes'
, PALLET_POSITIONS_CNT COMMENT 'Sums the total planned	unplanned and planned for next day pallet positions'
, EXCESS_MOVEMENTS_CNT COMMENT 'Sum over all time periods of the number of movements above the maximum per time period'
, PALLET_POSITIONS_PRODUCT_DECAY_TRANSPORT_EXCEEDED_CNT COMMENT 'Sum of the number of pallets where the product decay in transport is above 100'
, DWH_LOAD_ID COMMENT 'Load id'
, DWH_CREATED COMMENT 'Record created at'
, DWH_UPDATED COMMENT 'Record updated at'
, DWH_VALID_FROM COMMENT 'Valid from date'
, DWH_VALID_TO COMMENT 'Valid to date'
, DELETED_FG COMMENT 'Flag if record is deleted'
, ACTIVE_FG COMMENT 'Flag if record is active'
, AVERAGENUMSTORESTOPSEXCLDUMMY COMMENT 'The KPI counts the average number of stores that are visited during a tour'
, COSTPERPALLETPOSITIONEXCLDUMMY COMMENT 'Costs per pallet position is defined as the total real costs divided by the total number of planned pallet positions (ShipmentLeg.Quantity1 with ShipmentLeg.IsPlanned = true). This includes all shipments (such as store returns collection store deliveries and any other types).'
, COSTPERPALLETPOSITIONEXCLDUMMYCONVERTED COMMENT 'The total real costs divided by the total number of planned pallet positions converted excluding the dummy resource sets.'
, NUMPALLETPOSITIONSEXCLDUMMY COMMENT 'The number of pallet positions planned unplanned and planned for next day (excluding deactivated shipments).'
, NUMPALLETPOSITIONSEXCLDUMMYCONVERTED COMMENT 'The converted number of pallet positions: planned unplanned and planned for next day (excluding deactivated shipments) Excluding the dummy resource sets'
, NUMPALLETPOSITIONSSTOREDELIVERIESPERSHIFTEXCLDUMMY COMMENT 'Company.NumPlannedPalletPositionsStoreDeliveriesExclDummy/ Company.TotalNumShiftsExclDummy'
, NUMPLANNEDPALLETPOSITIONSSTOREDELIVERIESCONVERTED COMMENT 'The number of converted planned pallet positions (number of 1a pallets converted) for store deliveries. It sums all converted ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = true and are planned on a route'
, NUMSTORESTOPSEXCLDUMMY COMMENT 'The KPI counts the number of stops at a store over all tours'
, NUMTOURSELKEEXCLDUMMY COMMENT 'The number of tours with HasStoreDelivery = true is counted over all routes with at least one shipment planned (Route.IsUsed = true).'
, NUMTOURSEXCLDUMMY COMMENT 'total number of tours across all routes where Route.IsUsed = true'
, NUMTOURSNONSTOREDELIVERYEXCLDUMMY COMMENT 'Total number of used non-dummy non-resource Tours without store deliveries'
, NUMTOURSPERSHIFTELKEEXCLDUMMY COMMENT 'This calculates the number of tours with store delivery per shift (= Company.NumToursElkeExclDummy / Company.TotalNumShiftsElkeExclDummy)'
, NUMTOURSPERSHIFTEXCLDUMMY COMMENT 'total number of tours across all routes where Route.IsUsed = true / total number of driver shifts for all routes where route.IsUsed = true'
, NUMTOURSPERSHIFTINDICATOREXCLDUMMY COMMENT 'The total number of used non-dummy Tours as a factor of the total number of IndicatorShifts on non-dummy Routes'
, NUMTOURSPERSHIFTINDICATORNONSTOREDELIVERYEXCLDUMMY COMMENT 'The average number of Tours per used non-dummy RouteInIndicatorShift without store deliveries on a non-resource Route'
, NUMTOURSPERSHIFTINDICATORSTOREDELIVERYEXCLDUMMY COMMENT 'The average number of Tours per used non-dummy RouteInIndicatorShift with store deliveries on a non-resource Route'
, NUMTOURSPERSHIFTNONSTOREDELIVERYEXCLDUMMY COMMENT 'The average number of Tours per used non-dummy driver shift without store deliveries on a non-resource Route'
, NUMTOURSPERSHIFTSTOREDELIVERYEXCLDUMMY COMMENT 'The average number of Tours per used non-dummy driver shift with store deliveries on a non-resource Route'
, NUMTOURSSTOREDELIVERYEXCLDUMMY COMMENT 'Total number of used non-dummy non-resource Tours with store deliveries'
, SHARESECONDSHIFTINDICATORNONSTOREDELIVERIESEXCLDUMMY COMMENT 'The percentage of used non-dummy non-resource routes with a second shift indicator and without store deliveries'
, SHARESECONDSHIFTINDICATORSEXCLDUMMY COMMENT 'The percentage of used non-dummy non-resource routes with a second shift indicator'
, SHARESECONDSHIFTINDICATORSTOREDELIVERIESEXCLDUMMY COMMENT 'The percentage of used non-dummy non-resource routes with store deliveries and a second shift indicator'
, SHARESECONDSHIFTSEXCLDUMMY COMMENT 'The percentage of used non-dummy Routes with a second shift'
, SHARESECONDSHIFTSNONSTOREDELIVERIESEXCLDUMMY COMMENT 'The percentage of used non-dummy non-resource routes with a second shift and without store deliveries'
, SHARESECONDSHIFTSSTOREDELIVERIESEXCLDUMMY COMMENT 'The percentage of used non-dummy non-resource routes with store deliveries and a second shift'
, TOTALDURATIONEXCLDUMMY COMMENT 'sum overall Route.TotalDuration with Route.IsUsed = true'
, TOTALDURATIONFIRSTSHIFTSEXCLDUMMY COMMENT 'The total duration including waiting time of used non-dummy first shifts on non-resource routes'
, TOTALDURATIONFIRSTSHIFTSNONSTOREDELIVERIESEXCLDUMMY COMMENT 'The total duration including waiting time of used non-dummy first shifts without store deliveries'
, TOTALDURATIONFIRSTSHIFTSSTOREDELIVERIESEXCLDUMMY COMMENT 'The total duration including waiting time of used non-dummy first shifts with store deliveries'
, TOTALDURATIONNONSTOREDELIVERIESEXCLDUMMY COMMENT 'The total duration of used non-dummy non-resource Routes without store deliveries'
, TOTALDURATIONPERROUTEEXCLDUMMY COMMENT 'The average duration including waiting time per used non-dummy non-resource route'
, TOTALDURATIONPERROUTENONSTOREDELIVERIESEXCLDUMMY COMMENT 'The average duration including waiting time per used non-dummy non-resource route without store deliveries'
, TOTALDURATIONPERROUTESTOREDELIVERIESEXCLDUMMY COMMENT 'The average duration including waiting time per used non-dummy non-resource route with store deliveries'
, TOTALDURATIONPERSHIFTELKEEXCLDUMMY COMMENT 'Total Duration ExclDummy /TotalNumShiftsElkeExclDummy'
, TOTALDURATIONPERSHIFTEXCLDUMMY COMMENT 'The average duration including waiting time per used non-dummy shift on a non-resource route'
, TOTALDURATIONPERSHIFTINDICATOREXCLDUMMY COMMENT 'The average duration including waiting time per used non-dummy shift indicator on a non-resource route'
, TOTALDURATIONPERSHIFTINDICATORNONSTOREDELIVERIESEXCLDUMMY COMMENT 'The average duration including waiting time per used non-dummy shift indicator without store deliveries on a non-resource route'
, TOTALDURATIONPERSHIFTINDICATORSTOREDELIVERIESEXCLDUMMY COMMENT 'The average duration including waiting time per used non-dummy shift indicator with store deliveries on a non-resource route'
, TOTALDURATIONPERSHIFTNONSTOREDELIVERIESEXCLDUMMY COMMENT 'The average duration including waiting time per used non-dummy shift without store deliveries on a non-resource route'
, TOTALDURATIONPERSHIFTSTOREDELIVERIESEXCLDUMMY COMMENT 'The average duration including waiting time per used non-dummy shift with store deliveries on a non-resource route'
, TOTALDURATIONSECONDSHIFTSEXCLDUMMY COMMENT 'The total duration including waiting time of used non-dummy second shifts on non-resource route'
, TOTALDURATIONSECONDSHIFTSNONSTOREDELIVERIESEXCLDUMMY COMMENT 'The total duration including waiting time of used non-dummy second shifts without store deliveries'
, TOTALDURATIONSECONDSHIFTSSTOREDELIVERIESEXCLDUMMY COMMENT 'The total duration including waiting time of used non-dummy second shifts with store deliveries'
, TOTALDURATIONSTOREDELIVERIESEXCLDUMMY COMMENT 'The total duration of used non-dummy non-resource Routes with store deliveries'
, TOTALNUM1APALLETSPERSHIFTELKEEXCLDUMMY COMMENT 'TotalNum1aPalletsExclDummy/TotalNumShiftsElkeExclDummy'
, TOTALNUM1APALLETSPERSHIFTELKEEXCLDUMMYCONVERTED COMMENT 'TotalNum1aPalletsExclDummy/TotalNumShiftsElkeExclDummy (Converted)'
, TOTALNUM1APALLETSPLANNEDEXCLDUMMY COMMENT 'This calculates the number of 1a pallets (store deliveries). It sums all ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = true excluding resourceSet dummies'
, TOTALNUM1APALLETSPLANNEDEXCLDUMMYCONVERTED COMMENT 'This calculates the number of 1a pallets converted (store deliveries). It sums all ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = true and are planned on a route and route is not using dummy resourceset'
, TOTALNUM1BPALLETSPLANNEDEXCLDUMMY COMMENT 'This calculates the number of 1b pallets (returns and transfers). It counts all ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = false excluding resourceSet dummies'
, TOTALNUM1BPALLETSPLANNEDEXCLDUMMYCONVERTED COMMENT 'This calculates the number of 1b pallets converted (returns and transfers). It counts all ShipmentLeg.Quantity1 with DeliveryAddress.IsStore = false Excluding the dummy resourcesets'
, TOTALNUMFIRSTSHIFTNONSTOREDELIVERYEXCLDUMMY COMMENT 'The total number of used non-dummy first shifts without store deliveries excluding shifts on resource routes'
, TOTALNUMFIRSTSHIFTSEXCLDUMMY COMMENT 'The total number of used non-dummy first shifts excluding shifts on resource routes'
, TOTALNUMFIRSTSHIFTSTOREDELIVERYEXCLDUMMY COMMENT 'The total number of used non-dummy first shifts with store deliveries excluding shifts on resource routes'
, TOTALNUMPALLETSCAPACITYONTOURNONSTOREDELIVERIESEXCLDUMMY COMMENT 'The total capacity on used non-dummy non-resource Tours without store deliveries'
, TOTALNUMPALLETSCAPACITYONTOURNONSTOREDELIVERIESEXCLDUMMYCONVERTED COMMENT 'The total capacity converted on used non-dummy non-resource Tours without store deliveries'
, TOTALNUMPALLETSCAPACITYONTOURSTOREDELIVERIESEXCLDUMMY COMMENT 'The total capacity on used non-dummy non-resource Tours with store deliveries'
, TOTALNUMPALLETSCAPACITYONTOURSTOREDELIVERIESEXCLDUMMYCONVERTED COMMENT 'The total capacity converted on used non-dummy non-resource Tours with store deliveries'
, TOTALNUMPALLETSPLANNEDONROUTENONSTOREDELIVERIESEXCLDUMMY COMMENT 'The total number of pallets planned on used non-dummy non-resource Routes without store deliveries'
, TOTALNUMPALLETSPLANNEDONROUTENONSTOREDELIVERIESEXCLDUMMYCONVERTED COMMENT 'The total number of pallets converted planned on used non-dummy non-resource Routes without store deliveries'
, TOTALNUMPALLETSPLANNEDONROUTESTOREDELIVERIESEXCLDUMMY COMMENT 'The total number of pallets planned on used non-dummy non-resource Routes with store deliveries'
, TOTALNUMPALLETSPLANNEDONROUTESTOREDELIVERIESEXCLDUMMYCONVERTED COMMENT 'The total number of pallets converted planned on used non-dummy non-resource Routes with store deliveries'
, TOTALNUMPALLETSPLANNEDONSHIFTINDICATOREXCLDUMMY COMMENT 'The total number of pallets planned on used non-dummy IndicatorShifts on non-resource Routes'
, TOTALNUMPALLETSPLANNEDONSHIFTINDICATOREXCLDUMMYCONVERTED COMMENT 'The total number of pallets converted planned on used non-dummy IndicatorShifts on non-resource Routes'
, TOTALNUMPALLETSPLANNEDONSHIFTINDICATORNONSTOREDELIVERIESEXCLDUMMY COMMENT 'The total number of pallets planned on used non-dummy IndicatorShifts on non-resource Routes without store deliveries'
, TOTALNUMPALLETSPLANNEDONSHIFTINDICATORNONSTOREDELIVERIESEXCLDUMMYCONVERTED COMMENT 'The total number of pallets converted planned on used non-dummy IndicatorShifts on non-resource Routes without store deliveries'
, TOTALNUMPALLETSPLANNEDONSHIFTINDICATORSTOREDELIVERIESEXCLDUMMY COMMENT 'The total number of pallets planned on used non-dummy IndicatorShifts on non-resource Routes with store deliveries'
, TOTALNUMPALLETSPLANNEDONSHIFTINDICATORSTOREDELIVERIESEXCLDUMMYCONVERTED COMMENT 'The total number of pallets converted planned on used non-dummy IndicatorShifts on non-resource Routes with store deliveries'
, TOTALNUMPALLETSPLANNEDONSHIFTNONSTOREDELIVERIESEXCLDUMMY COMMENT 'The total number of pallets planned on used non-dummy Shifts on non-resource Routes without store deliveries'
, TOTALNUMPALLETSPLANNEDONSHIFTNONSTOREDELIVERIESEXCLDUMMYCONVERTED COMMENT 'The total number of pallets converted planned on used non-dummy Shifts on non-resource Routes without store deliveries'
, TOTALNUMPALLETSPLANNEDONSHIFTSTOREDELIVERIESEXCLDUMMY COMMENT 'The total number of pallets planned on used non-dummy Shifts on non-resource Routes with store deliveries'
, TOTALNUMPALLETSPLANNEDONSHIFTSTOREDELIVERIESEXCLDUMMYCONVERTED COMMENT 'The total number of pallets converted planned on used non-dummy Shifts on non-resource Routes with store deliveries'
, TOTALNUMPALLETSPLANNEDONTOURNONSTOREDELIVERIESEXCLDUMMY COMMENT 'The total number of pallets planned on used non-dummy non-resource Tours without store deliveries'
, TOTALNUMPALLETSPLANNEDONTOURNONSTOREDELIVERIESEXCLDUMMYCONVERTED COMMENT 'The total number of pallets converted planned on used non-dummy non-resource Tours without store deliveries'
, TOTALNUMPALLETSPLANNEDONTOURSTOREDELIVERIESEXCLDUMMY COMMENT 'The total number of pallets planned on used non-dummy non-resource Tours with store deliveries'
, TOTALNUMPALLETSPLANNEDONTOURSTOREDELIVERIESEXCLDUMMYCONVERTED COMMENT 'The total number of pallets converted planned on used non-dummy non-resource Tours with store deliveries'
, TOTALNUMPALLETSPLANNEDPERSHIFTEXCLDUMMY COMMENT 'The average number of pallets planned per used non-dummy shift on a non-resource route'
, TOTALNUMPALLETSPLANNEDPERSHIFTEXCLDUMMYCONVERTED COMMENT 'The average number of pallets converted planned per used non-dummy shift on a non-resource route'
, TOTALNUMPALLETSPLANNEDPERSHIFTINDICATOREXCLDUMMY COMMENT 'The average number of pallets planned per used non-dummy shift indicator on a non-resource route'
, TOTALNUMPALLETSPLANNEDPERSHIFTINDICATOREXCLDUMMYCONVERTED COMMENT 'The average number of pallets converted planned per used non-dummy shift indicator on a non-resource route'
, TOTALNUMPALLETSPLANNEDPERSHIFTINDICATORNONSTOREDELIVERYEXCLDUMMY COMMENT 'The average number of pallets planned per used non-dummy shift indicator without store deliveries on a non-resource route'
, TOTALNUMPALLETSPLANNEDPERSHIFTINDICATORNONSTOREDELIVERYEXCLDUMMYCONVERTED COMMENT 'The average number of pallets converted planned per used non-dummy shift indicator without store deliveries on a non-resource route'
, TOTALNUMPALLETSPLANNEDPERSHIFTINDICATORSTOREDELIVERYEXCLDUMMY COMMENT 'The average number of pallets planned per used non-dummy shift indicator with store deliveries on a non-resource route'
, TOTALNUMPALLETSPLANNEDPERSHIFTINDICATORSTOREDELIVERYEXCLDUMMYCONVERTED COMMENT 'The average number of pallets converted planned per used non-dummy shift indicator with store deliveries on a non-resource route'
, TOTALNUMPALLETSPLANNEDPERSHIFTNONSTOREDELIVERYEXCLDUMMY COMMENT 'The average number of pallets planned per used non-dummy shift without store deliveries on a non-resource route'
, TOTALNUMPALLETSPLANNEDPERSHIFTNONSTOREDELIVERYEXCLDUMMYCONVERTED COMMENT 'The average number of pallets converted planned per used non-dummy shift without store deliveries on a non-resource route'
, TOTALNUMPALLETSPLANNEDPERSHIFTSTOREDELIVERYEXCLDUMMY COMMENT 'The average number of pallets planned per used non-dummy shift with store deliveries on a non-resource route'
, TOTALNUMPALLETSPLANNEDPERSHIFTSTOREDELIVERYEXCLDUMMYCONVERTED COMMENT 'The average number of pallets converted planned per used non-dummy shift with store deliveries on a non-resource route'
, TOTALNUMPALLETSWITHISDELIVERYTOEXTERNALWAREHOUSEPLANNEDEXCLDUMMY COMMENT 'The total number of pallets for all shipment legs on non-dummy routes which were delivered to an external warehouse'
, TOTALNUMPALLETSWITHISDELIVERYTOINTERNALWAREHOUSEPLANNEDEXCLDUMMY COMMENT 'The total number of pallets for all shipment legs on non-dummy routes which were delivered to an internal warehouse'
, TOTALNUMPALLETSWITHISDELIVERYTONONFOODWAREHOUSEPLANNEDEXCLDUMMY COMMENT 'The total number of pallets for all shipment legs on non-dummy routes which were delivered to a non food warehouse'
, TOTALNUMPALLETSWITHISPICKINGCROSSDOCKINGPLANNEDEXCLDUMMY COMMENT 'The total number of pallets for all shipment legs on non-dummy routes which were picked from cross docking'
, TOTALNUMPALLETSWITHISRECEIVINGCROSSDOCKINGPLANNEDEXCLDUMMY COMMENT 'The total number of pallets for all shipment legs on non-dummy routes which were received from cross docking'
, TOTALNUMPALLETSWITHISSTOCKTRANSFERPLANNEDEXCLDUMMY COMMENT 'The total number of pallets for all shipment legs on non-dummy routes which were a stock transfer'
, TOTALNUMSECONDSHIFTNONSTOREDELIVERYEXCLDUMMY COMMENT 'The total number of used non-dummy second shifts without store deliveries excluding shifts on resource routes'
, TOTALNUMSECONDSHIFTSEXCLDUMMY COMMENT 'The total number of used non-dummy second shifts excluding shifts on resource routes'
, TOTALNUMSECONDSHIFTSTOREDELIVERYEXCLDUMMY COMMENT 'The total number of used non-dummy second shifts with store deliveries excluding shifts on resource routes'
, TOTALNUMSHIFTINDICATORELKEEXCLDUMMY COMMENT 'Sum over all unique shiftIndicators which have IsStoreDelivery for non dummy routes'
, TOTALNUMSHIFTINDICATOREXCLDUMMY COMMENT 'Sum over indicator shifts of all used tours on non-dummy routes'
, TOTALNUMSHIFTINDICATORNONSTOREDELIVERYEXCLDUMMY COMMENT 'The total number of used non-dummy shift indicators without store deliveries on non-resource Routes'
, TOTALNUMSHIFTINDICATORSTOREDELIVERYEXCLDUMMY COMMENT 'The total number of used non-dummy shift indicators with store deliveries on non-resource Routes'
, TOTALNUMSHIFTSELKEEXCLDUMMY COMMENT 'Counts the number of shifts (Route.NumOfDriverShifts) in all used routes with store deliveries'
, TOTALNUMSHIFTSEXCLDUMMY COMMENT 'Total number of driver shifts for all routes where route.IsUsed = true'
, TOTALNUMSHIFTSNONSTOREDELIVERYEXCLDUMMY COMMENT 'The total number of used non-dummy driver shifts without store deliveries on non-resource Routes'
, TOTALNUMSHIFTSSTOREDELIVERYEXCLDUMMY COMMENT 'The total number of used non-dummy driver shifts with store deliveries on non-resource Routes'
, TOTALROUTESINUSEELKEEXCLDUMMY COMMENT 'Counts the number of routes that are in use for a store delivery'
, TOTALROUTESINUSEEXCLDUMMY COMMENT 'Calculates the number of routes in use excluding the dummy resourceSets'
, TOTALROUTESINUSENONSTOREDELIVERYEXCLDUMMY COMMENT 'Total number of used non-dummy non-resource Routes without store deliveries'
, TOTALROUTESINUSESTOREDELIVERYEXCLDUMMY COMMENT 'Total number of used non-dummy non-resource Routes with store deliveries'
, TOTALUSEDDISTANCECNGELKEEXCLDUMMY COMMENT 'The total distance in km of used non-dummy Tours with store deliveries driven by CNG DriveTypes'
, TOTALUSEDDISTANCECNGEXCLDUMMY COMMENT 'The total distance in km of used non-dummy Tours driven by CNG DriveTypes'
, TOTALUSEDDISTANCECNGNONSTOREDELIVERYEXCLDUMMY COMMENT 'The total distance in km of used non-dummy non-resource Tours without store deliveries driven by CNG DriveTypes'
, TOTALUSEDDISTANCECNGSTOREDELIVERYEXCLDUMMY COMMENT 'The total distance in km of used non-dummy non-resource Tours with store deliveries driven by CNG DriveTypes'
, TOTALUSEDDISTANCEDIESELELKELEXLDUMMY COMMENT 'The total distance in km of used non-dummy Tours with store deliveries driven by Diesel DriveTypes'
, TOTALUSEDDISTANCEDIESELEXCLDUMMY COMMENT 'The total distance in km of used non-dummy Tours driven by diesel DriveTypes'
, TOTALUSEDDISTANCEDIESELNONSTOREDELIVERYEXCLDUMMY COMMENT 'The total distance in km of used non-dummy non-resource Tours without store deliveries driven by diesel DriveTypes'
, TOTALUSEDDISTANCEDIESELSTOREDELIVERYEXCLDUMMY COMMENT 'The total distance in km of used non-dummy non-resource Tours with store deliveries driven by diesel DriveTypes'
, TOTALUSEDDISTANCEELECTRICELKEEXLDUMMY COMMENT 'The total distance in km of used non-dummy Tours with store deliveries driven by Electric DriveTypes'
, TOTALUSEDDISTANCEELECTRICEXCLDUMMY COMMENT 'The total distance in km of used non-dummy Tours driven by electric DriveTypes'
, TOTALUSEDDISTANCEELECTRICNONSTOREDELIVERYEXCLDUMMY COMMENT 'The total distance in km of used non-dummy non-resource Tours without store deliveries driven by electric DriveTypes'
, TOTALUSEDDISTANCEELECTRICSTOREDELIVERYEXCLDUMMY COMMENT 'The total distance in km of used non-dummy non-resource Tours with store deliveries driven by electric DriveType'
, TOTALUSEDDISTANCEELKEEXCLDUMMY COMMENT 'The distance planned on all used tours with store deliveries'
, TOTALUSEDDISTANCEEXCLDUMMY COMMENT 'sum of the distance travelled for all routes where route.IsUsed=true'
, TOTALUSEDDISTANCEHYDROGENELKEEXLDUMMY COMMENT 'The total distance in km of used non-dummy Tours with store deliveries driven by Hydrogen DriveTypes'
, TOTALUSEDDISTANCEHYDROGENEXCLDUMMY COMMENT 'The total distance in km of used non-dummy Tours driven by Hydrogen DriveTypes'
, TOTALUSEDDISTANCEHYDROGENNONSTOREDELIVERYEXCLDUMMY COMMENT 'The total distance in km of used non-dummy non-resource Tours without store deliveries driven by hydrogen DriveTypes'
, TOTALUSEDDISTANCEHYDROGENSTOREDELIVERYEXCLDUMMY COMMENT 'The total distance in km of used non-dummy non-resource Tours with store deliveries driven by hydrogen DriveTypes'
, TOTALUSEDDISTANCELNGELKEEXLDUMMY COMMENT 'The total distance in km of used non-dummy Tours with store deliveries driven by LNG DriveTypes'
, TOTALUSEDDISTANCELNGEXCLDUMMY COMMENT 'The total distance in km of used non-dummy Tours driven by LNG DriveTypes'
, TOTALUSEDDISTANCELNGNONSTOREDELIVERYEXCLDUMMY COMMENT 'The total distance in km of used non-dummy non-resource Tours without store deliveries driven by LNG DriveTypes'
, TOTALUSEDDISTANCELNGSTOREDELIVERYEXCLDUMMY COMMENT 'The total distance in km of used non-dummy non-resource Tours with store deliveries driven by LNG DriveTypes'
, TOTALUSEDDISTANCENONSTOREDELIVERYEXCLDUMMY COMMENT 'The total distance traveled by all used non-dummy Tours without store deliveries on non-resource routes'
, TOTALUSEDDISTANCEPERPALLETELKEEXCLDUMMY COMMENT 'Used distance per number of pallets of type 1a'
, TOTALUSEDDISTANCEPERPALLETELKEEXCLDUMMYCONVERTED COMMENT 'Converted used distance per number of pallets of type 1a Excluding the dummy resourcesets'
, TOTALUSEDDISTANCEPERPALLETEXCLDUMMY COMMENT 'The total used distance of Tours as a factor of the total number of pallet positions excluding dummies and non-resource tours'
, TOTALUSEDDISTANCEPERPALLETEXCLDUMMYCONVERTED COMMENT 'The total used distance of Tours as a factor of the total number of converted pallet positions excluding dummies and non-resource tours'
, TOTALUSEDDISTANCEPERPALLETNONSTOREDELIVERYEXCLDUMMY COMMENT 'The total used distance of Tours without store deliveries as a factor of the total number of pallet positions excluding dummies and non-resource tours'
, TOTALUSEDDISTANCEPERPALLETNONSTOREDELIVERYEXCLDUMMYCONVERTED COMMENT 'The total used distance of Tours without store deliveries as a factor of the total number of converted pallet positions excluding dummies and non resource-tours'
, TOTALUSEDDISTANCEPERPALLETSTOREDELIVERYEXCLDUMMY COMMENT 'The total used distance of Tours with store deliveries as a factor of the total number of pallet positions excluding dummies and non-resource tours'
, TOTALUSEDDISTANCEPERPALLETSTOREDELIVERYEXCLDUMMYCONVERTED COMMENT 'The total used distance of Tours with store deliveries as a factor of the total number of converted pallet positions excluding dummies'
, TOTALUSEDDISTANCEPERSHIFTELKEEXCLDUMMY COMMENT 'Company.TotalUsedDistanceElkeExclDummy / Company.TotalNumShiftsElkeExclDummy'
, TOTALUSEDDISTANCESTOREDELIVERYEXCLDUMMY COMMENT 'The total distance traveled by all used non-dummy Tours with store deliveries on non-resource routes'
, TOTALUSEDDURATIONUSEREXCLDUMMY COMMENT 'The sum of the user duration for all tours with store visits'
, UTILIZATION1EXCLDUMMY COMMENT 'sum of the totalutilization1 for all routes in the dataset divided by the sum of the total distance driven across all routes'
, UTILIZATIONDELIVERIES1EXCLDUMMY COMMENT 'Total utilization across all routes not including return shipments'
, UTILIZATIONPALLETPOSITIONSELKEEXCLDUMMY COMMENT 'The average utilization of the resources that are going to stores over all tours that have store delivery'
, UTILIZATIONPALLETPOSITIONSELKEEXCLDUMMYCONVERTED COMMENT 'The average converted utilization of the resources that are going to stores over all tours that have store delivery'
, UTILIZATIONWAREHOUSEELKEEXCLDUMMY COMMENT 'The average of the utilization over all tours which have storedeliveries'
, UTILIZATIONWAREHOUSEELKEEXCLDUMMYCONVERTED COMMENT 'The converted average of the utilization over all tours which have store deliveries excluding the dummy resource sets and tours which have no pickup (load actions) at the RDC'
, UTILIZATIONWAREHOUSEEXCLDUMMY COMMENT 'The average of the utilization over all used tours on non-dummy routes excluding tours which have no pickup (load actions) at the RDC'
, UTILIZATIONWAREHOUSEEXCLDUMMYCONVERTED COMMENT 'The converted average of the utilization over all used tours on non-dummy routes excluding tours which have no pickup (load actions) at the RDC'
, UTILIZATIONWAREHOUSENONSTOREDELIVERYEXCLDUMMY COMMENT 'The average utilization over all used Tours without store deliveries on non-dummy non-resource Routes excluding tours which have no pickup (load actions) at the RDC'
, UTILIZATIONWAREHOUSENONSTOREDELIVERYEXCLDUMMYCONVERTED COMMENT 'The average utilization of quantity1 converted over all used Tours without store deliveries on non-dummy non-resource Routes excluding tours which have no pickup (load actions) at the RDC'
, UTILIZATIONWAREHOUSESTOREDELIVERYEXCLDUMMY COMMENT 'The average utilization over all used Tours with store deliveries on non-dummy non-resource Routes excluding tours which have no pickup (load actions) at the RDC'
, UTILIZATIONWAREHOUSESTOREDELIVERYEXCLDUMMYCONVERTED COMMENT 'The average utilization of quantity1 converted over all used Tours with store deliveries on non-dummy non-resource Routes excluding tours which have no pickup (load actions) at the RDC'
) COMMENT='QUINTIQ - prepared view on raw data'
 AS 
SELECT
   client_id
 , lidl_country
 , source_system
 , wh_id
 , store_stops_avg
 , dist_per_shift_avg
 , dur_per_shift_avg
 , costs_per_pallet_pos_sum
 , delivery_dt
 , max_additional_dist_per_pallet
 , lanes_assigned_cnt
 , lanes_blocked_cnt
 , store_stops_cnt
 , tours_cnt
 , tours_elke_cnt
 , tours_per_shift_cnt
 , tours_per_shift_elke_cnt
 , planned_pos_cnt
 , duration_sum
 , dur_per_shift_elke
 , pallets_1a_cnt
 , pallets_1a_per_shift_elke_cnt
 , pallets_1b_cnt
 , paid_shifts_cnt
 , paid_single_shift_routes_cnt
 , shifts_cnt
 , shifts_elke_cnt
 , toll_costs_sum
 , routes_elke_cnt
 , dist_sum
 , dist_elke_sum
 , dist_per_pallet_elke_sum
 , dist_per_shift_elke_sum
 , dur_user_sum
 , util_sum
 , util_pallet_pos_elke
 , util_wh_elke
 , utilization_5_flop_tours_avg
 , constraint_violations_per_tour_avg
 , cost_per_pallet_position_excl_pickup
 , store_stops_max_cnt
 , product_decay_transport_max_qty
 , mins_outside_preferred_window_cnt
 , mins_outside_tolerance_window_cnt
 , addresses_max_drivers_hauliers_exceeded_cnt
 , addresses_max_stops_per_delivery_day_exceeded_cnt
 , addresses_max_undelivered_exceeded_cnt
 , addresses_max_vehicles_exceeded_cnt
 , addresses_unmanned_pallet_positions_exceeded_cnt
 , constraint_violations_cnt
 , contract_allocations_exceeded_cnt
 , within_tolerance_delivery_performance_pct
 , utilization_time
 , utilization_deliveries_1
 , unplanned_positions_cnt
 , max_additional_distance_per_pallet_tour_id
 , total_working_time_excess_qty
 , total_waiting_time_qty
 , paid_multi_shift_routes_total_cnt
 , shift_indicator_elke_total_cnt
 , routes_in_use_total_cnt
 , driving_time_excess_total_sum
 , most_stops_stores_id
 , picklists_without_lane_incl_dummy_pct
 , picklists_without_lane_pct
 , pallet_positions_without_lane_incl_dummy_pct
 , pallet_positions_without_lane_pct
 , above_max_multi_shift_pct
 , unplanned_pallet_positions_store_deliveries_cnt
 , unplanned_pallet_positions_returns_cnt
 , unloading_teams_excess_cnt
 , product_availability_exceeded_tour_cnt
 , invalid_resource_dimensions_stops_cnt
 , constraint_violations_tour_cnt
 , infeasible_compartments_tour_cnt
 , max_capacity_exceeded_tour_cnt
 , max_dg_capacity_exceeded_tour_cnt
 , max_distance_exceeded_tour_cnt
 , one_way_unallowed_tour_cnt
 , outside_wh_area_opening_tour_cnt
 , incorrect_unloading_equipment_stops_cnt
 , outside_delivery_day_route_cnt
 , planned_pallet_positions_store_deliveries_cnt
 , planned_pallet_positions_returns_cnt
 , pallet_positions_store_deliveries_per_shift_cnt
 , pallet_positions_returns_cnt
 , lanes_unassigned_not_blocked_cnt
 , pallet_positions_cnt
 , excess_movements_cnt
 , pallet_positions_product_decay_transport_exceeded_cnt
 , dwh_load_id
 , dwh_created
 , dwh_updated
 , dwh_valid_from
 , dwh_valid_to
 , deleted_fg
 , IFF(dwh_valid_to = '9999-12-30', 1, 0) AS active_fg
 , averagenumstorestopsexcldummy
 , costperpalletpositionexcldummy
 , costperpalletpositionexcldummyconverted
 , numpalletpositionsexcldummy
 , numpalletpositionsexcldummyconverted
 , numpalletpositionsstoredeliveriespershiftexcldummy
 , numplannedpalletpositionsstoredeliveriesconverted
 , numstorestopsexcldummy
 , numtourselkeexcldummy
 , numtoursexcldummy
 , numtoursnonstoredeliveryexcldummy
 , numtourspershiftelkeexcldummy
 , numtourspershiftexcldummy
 , numtourspershiftindicatorexcldummy
 , numtourspershiftindicatornonstoredeliveryexcldummy
 , numtourspershiftindicatorstoredeliveryexcldummy
 , numtourspershiftnonstoredeliveryexcldummy
 , numtourspershiftstoredeliveryexcldummy
 , numtoursstoredeliveryexcldummy
 , sharesecondshiftindicatornonstoredeliveriesexcldummy
 , sharesecondshiftindicatorsexcldummy
 , sharesecondshiftindicatorstoredeliveriesexcldummy
 , sharesecondshiftsexcldummy
 , sharesecondshiftsnonstoredeliveriesexcldummy
 , sharesecondshiftsstoredeliveriesexcldummy
 , totaldurationexcldummy
 , totaldurationfirstshiftsexcldummy
 , totaldurationfirstshiftsnonstoredeliveriesexcldummy
 , totaldurationfirstshiftsstoredeliveriesexcldummy
 , totaldurationnonstoredeliveriesexcldummy
 , totaldurationperrouteexcldummy
 , totaldurationperroutenonstoredeliveriesexcldummy
 , totaldurationperroutestoredeliveriesexcldummy
 , totaldurationpershiftelkeexcldummy
 , totaldurationpershiftexcldummy
 , totaldurationpershiftindicatorexcldummy
 , totaldurationpershiftindicatornonstoredeliveriesexcldummy
 , totaldurationpershiftindicatorstoredeliveriesexcldummy
 , totaldurationpershiftnonstoredeliveriesexcldummy
 , totaldurationpershiftstoredeliveriesexcldummy
 , totaldurationsecondshiftsexcldummy
 , totaldurationsecondshiftsnonstoredeliveriesexcldummy
 , totaldurationsecondshiftsstoredeliveriesexcldummy
 , totaldurationstoredeliveriesexcldummy
 , totalnum1apalletspershiftelkeexcldummy
 , totalnum1apalletspershiftelkeexcldummyconverted
 , totalnum1apalletsplannedexcldummy
 , totalnum1apalletsplannedexcldummyconverted
 , totalnum1bpalletsplannedexcldummy
 , totalnum1bpalletsplannedexcldummyconverted
 , totalnumfirstshiftnonstoredeliveryexcldummy
 , totalnumfirstshiftsexcldummy
 , totalnumfirstshiftstoredeliveryexcldummy
 , totalnumpalletscapacityontournonstoredeliveriesexcldummy
 , totalnumpalletscapacityontournonstoredeliveriesexcldummyconverted
 , totalnumpalletscapacityontourstoredeliveriesexcldummy
 , totalnumpalletscapacityontourstoredeliveriesexcldummyconverted
 , totalnumpalletsplannedonroutenonstoredeliveriesexcldummy
 , totalnumpalletsplannedonroutenonstoredeliveriesexcldummyconverted
 , totalnumpalletsplannedonroutestoredeliveriesexcldummy
 , totalnumpalletsplannedonroutestoredeliveriesexcldummyconverted
 , totalnumpalletsplannedonshiftindicatorexcldummy
 , totalnumpalletsplannedonshiftindicatorexcldummyconverted
 , totalnumpalletsplannedonshiftindicatornonstoredeliveriesexcldummy
 , totalnumpalletsplannedonshiftindicatornonstoredeliveriesexcldummyconverted
 , totalnumpalletsplannedonshiftindicatorstoredeliveriesexcldummy
 , totalnumpalletsplannedonshiftindicatorstoredeliveriesexcldummyconverted
 , totalnumpalletsplannedonshiftnonstoredeliveriesexcldummy
 , totalnumpalletsplannedonshiftnonstoredeliveriesexcldummyconverted
 , totalnumpalletsplannedonshiftstoredeliveriesexcldummy
 , totalnumpalletsplannedonshiftstoredeliveriesexcldummyconverted
 , totalnumpalletsplannedontournonstoredeliveriesexcldummy
 , totalnumpalletsplannedontournonstoredeliveriesexcldummyconverted
 , totalnumpalletsplannedontourstoredeliveriesexcldummy
 , totalnumpalletsplannedontourstoredeliveriesexcldummyconverted
 , totalnumpalletsplannedpershiftexcldummy
 , totalnumpalletsplannedpershiftexcldummyconverted
 , totalnumpalletsplannedpershiftindicatorexcldummy
 , totalnumpalletsplannedpershiftindicatorexcldummyconverted
 , totalnumpalletsplannedpershiftindicatornonstoredeliveryexcldummy
 , totalnumpalletsplannedpershiftindicatornonstoredeliveryexcldummyconverted
 , totalnumpalletsplannedpershiftindicatorstoredeliveryexcldummy
 , totalnumpalletsplannedpershiftindicatorstoredeliveryexcldummyconverted
 , totalnumpalletsplannedpershiftnonstoredeliveryexcldummy
 , totalnumpalletsplannedpershiftnonstoredeliveryexcldummyconverted
 , totalnumpalletsplannedpershiftstoredeliveryexcldummy
 , totalnumpalletsplannedpershiftstoredeliveryexcldummyconverted
 , totalnumpalletswithisdeliverytoexternalwarehouseplannedexcldummy
 , totalnumpalletswithisdeliverytointernalwarehouseplannedexcldummy
 , totalnumpalletswithisdeliverytononfoodwarehouseplannedexcldummy
 , totalnumpalletswithispickingcrossdockingplannedexcldummy
 , totalnumpalletswithisreceivingcrossdockingplannedexcldummy
 , totalnumpalletswithisstocktransferplannedexcldummy
 , totalnumsecondshiftnonstoredeliveryexcldummy
 , totalnumsecondshiftsexcldummy
 , totalnumsecondshiftstoredeliveryexcldummy
 , totalnumshiftindicatorelkeexcldummy
 , totalnumshiftindicatorexcldummy
 , totalnumshiftindicatornonstoredeliveryexcldummy
 , totalnumshiftindicatorstoredeliveryexcldummy
 , totalnumshiftselkeexcldummy
 , totalnumshiftsexcldummy
 , totalnumshiftsnonstoredeliveryexcldummy
 , totalnumshiftsstoredeliveryexcldummy
 , totalroutesinuseelkeexcldummy
 , totalroutesinuseexcldummy
 , totalroutesinusenonstoredeliveryexcldummy
 , totalroutesinusestoredeliveryexcldummy
 , totaluseddistancecngelkeexcldummy
 , totaluseddistancecngexcldummy
 , totaluseddistancecngnonstoredeliveryexcldummy
 , totaluseddistancecngstoredeliveryexcldummy
 , totaluseddistancedieselelkelexldummy
 , totaluseddistancedieselexcldummy
 , totaluseddistancedieselnonstoredeliveryexcldummy
 , totaluseddistancedieselstoredeliveryexcldummy
 , totaluseddistanceelectricelkeexldummy
 , totaluseddistanceelectricexcldummy
 , totaluseddistanceelectricnonstoredeliveryexcldummy
 , totaluseddistanceelectricstoredeliveryexcldummy
 , totaluseddistanceelkeexcldummy
 , totaluseddistanceexcldummy
 , totaluseddistancehydrogenelkeexldummy
 , totaluseddistancehydrogenexcldummy
 , totaluseddistancehydrogennonstoredeliveryexcldummy
 , totaluseddistancehydrogenstoredeliveryexcldummy
 , totaluseddistancelngelkeexldummy
 , totaluseddistancelngexcldummy
 , totaluseddistancelngnonstoredeliveryexcldummy
 , totaluseddistancelngstoredeliveryexcldummy
 , totaluseddistancenonstoredeliveryexcldummy
 , totaluseddistanceperpalletelkeexcldummy
 , totaluseddistanceperpalletelkeexcldummyconverted
 , totaluseddistanceperpalletexcldummy
 , totaluseddistanceperpalletexcldummyconverted
 , totaluseddistanceperpalletnonstoredeliveryexcldummy
 , totaluseddistanceperpalletnonstoredeliveryexcldummyconverted
 , totaluseddistanceperpalletstoredeliveryexcldummy
 , totaluseddistanceperpalletstoredeliveryexcldummyconverted
 , totaluseddistancepershiftelkeexcldummy
 , totaluseddistancestoredeliveryexcldummy
 , totaluseddurationuserexcldummy
 , utilization1excldummy
 , utilizationdeliveries1excldummy
 , utilizationpalletpositionselkeexcldummy
 , utilizationpalletpositionselkeexcldummyconverted
 , utilizationwarehouseelkeexcldummy
 , utilizationwarehouseelkeexcldummyconverted
 , utilizationwarehouseexcldummy
 , utilizationwarehouseexcldummyconverted
 , utilizationwarehousenonstoredeliveryexcldummy
 , utilizationwarehousenonstoredeliveryexcldummyconverted
 , utilizationwarehousestoredeliveryexcldummy
 , utilizationwarehousestoredeliveryexcldummyconverted
FROM FE_MSTR_LOGOP.V_QUINTIQ_REPORTEDKPI;