CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_elke_hour_tracking_digital_temp (
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID'),
warehouse_name STRING(100) NOT NULL OPTIONS(description='Warehouse name'),
geoclass STRING(100) NOT NULL
OPTIONS(description='An additional differentiation flag, whether it is mainly palletized or case-sized goods or wine handling in the warehouse location.'),
calendar_dt DATE NOT NULL OPTIONS(description='Calendar Date'),
we_net_hours_administration BIGNUMERIC(38,5)
OPTIONS(description='Inbound Department: Hours of administration employees '),
we_net_hours_receipt_gate BIGNUMERIC(38,5) OPTIONS(description='Inbound Department: Hours of employee book goods in'),
we_net_hours_deco_stations BIGNUMERIC(38,5)
OPTIONS(description='Inbound Department: Hours of employee, working at Deco Station (Deconsolidation)'),
we_net_hours_sick BIGNUMERIC(38,5) OPTIONS(description='Inbound Department: Hours of sick employee'),
we_net_hours_other_absences BIGNUMERIC(38,5)
OPTIONS(description='Inbound Department: Hours if employee absences but not sick'),
we_net_hours_traning BIGNUMERIC(38,5) OPTIONS(description='Inbound Department: Hours for training sessions of employee'),
we_net_hours_system_failure BIGNUMERIC(38,5)
OPTIONS(description='Inbound Department: Hours, if productive work is not possible because of SAP breakdown.'),
ibt_net_hours_forklift_driver_ekx BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: Hours of employee, working on all kinds of special forklifts: Narrow aisle truck and Wide Aisle Forklift.'),
ibt_net_hours_fast_mover BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: Hours of employee, working on all kinds of other forklifts and Fast Mover than Narrow aisle truck and Wide Aisle Forklift.'),
ibt_net_hours_administration BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: Hours of administration employee'),
ibt_net_hours_putaway_to_pick BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: Hours of employee store goods in pick bins'),
ibt_net_hours_packaging_material BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: Hours of employee store packaging material'),
ibt_net_hours_trainings BIGNUMERIC(38,5) OPTIONS(description='Department Internal Movement: Hours of sick employee'),
ibt_net_hours_system_failure BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: Hours if employee absences but not sick'),
ibt_net_hours_sick BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: Hours for training sessions of employee'),
ibt_net_hours_other_absences BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: Hours, if productive work is not possible because of SAP breakdown.'),
wa_net_hours_administration BIGNUMERIC(38,5) OPTIONS(description='Department Pick: Hours of administration employees '),
wa_net_hours_pick_kk_gt_wein BIGNUMERIC(38,5)
OPTIONS(description='Department Pick: Hours of employees picking all kind of goods.'),
wa_net_hours_transshipment BIGNUMERIC(38,5)
OPTIONS(description='Department Pick: Hours of employees picking items for B2B Transshipment Process (Outbound to other FCs)'),
wa_net_hours_preparation BIGNUMERIC(38,5)
OPTIONS(description='Department Pick: Hours of employees preparation picking process'),
wa_net_hours_clearing BIGNUMERIC(38,5) OPTIONS(description='Department Pick: Hours of employees working at Clearing'),
wa_net_hours_system_failure BIGNUMERIC(38,5)
OPTIONS(description='Department Pick: Hours, if productive work is not possible because of SAP breakdown.'),
wa_net_hours_tranings BIGNUMERIC(38,5) OPTIONS(description='Department Pick: Hours for training sessions of employee'),
wa_net_hours_sick BIGNUMERIC(38,5) OPTIONS(description='Department Pick: Hours of sick employee'),
wa_net_hours_other_absences BIGNUMERIC(38,5)
OPTIONS(description='Department Pick: Hours if employee absences but not sick'),
sort_pack_net_hours_administration BIGNUMERIC(38,5)
OPTIONS(description='Department Sort Pack: Hours of administration employees '),
sort_pack_net_hours_kk_gt_wein BIGNUMERIC(38,5)
OPTIONS(description='Department Sort Pack: Hours of employees packing all kind of goods'),
ship_pack_net_hours_palletized_loading BIGNUMERIC(38,5)
OPTIONS(description='Department Ship: Hours of employees loading palletized goods'),
sort_pack_net_hours_preparation BIGNUMERIC(38,5)
OPTIONS(description='Department Sort Pack: Hours of employees preparatin packing process'),
ship_net_hours_loose_loading BIGNUMERIC(38,5)
OPTIONS(description='Department Sort Pack: Hours of employees loading loose load goods'),
ship_net_hours_driver_swap_body_carrier BIGNUMERIC(38,5)
OPTIONS(description='Department Ship: Hours of employees driving swap body carrier'),
sort_pack_net_hours_quality_test BIGNUMERIC(38,5)
OPTIONS(description='Department Sort Pack: Hours of employees for Quality Tests'),
sort_pack_net_hours_sorting_station BIGNUMERIC(38,5)
OPTIONS(description='Department Sort Pack: Hours of employees at Sorting stations.'),
sort_pack_net_hours_system_failure BIGNUMERIC(38,5)
OPTIONS(description='Department Sort Pack: Hours, if productive work is not possible because of SAP breakdown.'),
sort_pack_net_hours_trainings BIGNUMERIC(38,5)
OPTIONS(description='Department Sort Pack: Hours for training sessions of employee'),
sort_pack_net_hours_transshipment BIGNUMERIC(38,5)
OPTIONS(description='Department Sort Pack: Hours of employees loading items for B2B Transshipment Process (Outbound to other FCs)'),
sort_pack_net_hours_clearing BIGNUMERIC(38,5)
OPTIONS(description='Department Sort Pack: Hours of employees working at Clearing'),
sort_pack_net_hours_sick BIGNUMERIC(38,5) OPTIONS(description='Department Sort Pack: Hours of sick employee'),
sort_pack_net_hours_other_absences BIGNUMERIC(38,5)
OPTIONS(description='Department Sort Pack: Hours if employee absences but not sick'),
returns_net_hours_administration_customer_returns BIGNUMERIC(38,5)
OPTIONS(description='Returns  Department Hours of administration employees for processing Customer Returns'),
returns_net_hours_customer_returns_table BIGNUMERIC(38,5)
OPTIONS(description='Returns Department Hours of employees for processing Curstomer Returns inbound'),
returns_net_hours_putaway_to_pick_batch1 BIGNUMERIC(38,5)
OPTIONS(description='Returns Department: Hours of employee store goods in pick bins'),
returns_net_hours_preparation BIGNUMERIC(38,5)
OPTIONS(description='Returns Department: Hours of employee preparation return process (customer return at return desk)'),
returns_net_hours_administration_venor_return_scrapping BIGNUMERIC(38,5)
OPTIONS(description='Returns  Department Hours of administration employees for processing Vendor Returns / Scrapping'),
returns_net_hours_vendor_return BIGNUMERIC(38,5)
OPTIONS(description='Returns  Department Hours of employees for processing Vendor Returns'),
returns_net_hours_scrapping BIGNUMERIC(38,5)
OPTIONS(description='Returns  Department Hours of employees for processing scrapping'),
returns_net_hours_trainings BIGNUMERIC(38,5)
OPTIONS(description='Return Department:  Hours for training sessions of employee'),
returns_net_hours_system_failure BIGNUMERIC(38,5)
OPTIONS(description='Return Department: Hours, if productive work is not possible because of SAP breakdown.'),
returns_net_hours_sick BIGNUMERIC(38,5) OPTIONS(description='Return Department: Hours of sick employee'),
returns_net_hours_other_absences BIGNUMERIC(38,5)
OPTIONS(description='Return Department: Hours if employee absences but not sick'),
wko_net_hours_clarification_case_processing BIGNUMERIC(38,5)
OPTIONS(description='WKO Hours of employee processing clarificatin cases'),
wko_net_hours_verwertung_process BIGNUMERIC(38,5)
OPTIONS(description='WKO Hours Verwerung process (Reselling to 3rd Party Reseller)'),
wko_net_hours_trainings BIGNUMERIC(38,5) OPTIONS(description='WKO: Hours for training sessions of employee'),
wko_net_hours_system_failure BIGNUMERIC(38,5)
OPTIONS(description='WKO: Hours, if productive work is not possible because of SAP breakdown.'),
wko_net_hours_sick BIGNUMERIC(38,5) OPTIONS(description='WKO: Hours of sick employee'),
wko_net_hours_other_absences BIGNUMERIC(38,5) OPTIONS(description='WKO: Hours if employee absences but not sick'),
total_warehouse_net_hours_head_of_warehouse_management BIGNUMERIC(38,5)
OPTIONS(description='Total Warehouse: Hours of employee Head of Warehouse Management'),
total_warehouse_net_hours_manager_inbound BIGNUMERIC(38,5)
OPTIONS(description='Total Warehouse: Hours of employees Inbound Mangement'),
total_warehouse_net_hours_manager_outbound BIGNUMERIC(38,5)
OPTIONS(description='Total Warehouse: Hours of employees Outbound Mangement'),
total_warehouse_net_hours_warehouse_technic BIGNUMERIC(38,5)
OPTIONS(description='Total Warehouse: Hours of employees working in technical Department'),
total_warehouse_net_hours_hr BIGNUMERIC(38,5)
OPTIONS(description='Total Warehouse: Hours of employees working in Human-Ressource Department'),
total_warehouse_net_hours_it BIGNUMERIC(38,5)
OPTIONS(description='Total Warehouse: Hours of employees working in IT-Department'),
total_warehouse_net_hours_sick BIGNUMERIC(38,5) OPTIONS(description='Total Warehouse: Hours of sick employee'),
total_warehouse_net_hours_other_hours BIGNUMERIC(38,5)
OPTIONS(description='Total Warehouse: Hours if employee absences but not sick'),
we_pallets_before_processing BIGNUMERIC(38,5)
OPTIONS(description='Inbound Department: number of pallets booked inbound from trucks (without packaging material)'),
we_pallets_stored BIGNUMERIC(38,5)
OPTIONS(description='Inbound Department: number of pallets stored on reserve or pick bins'),
we_deliveries_trucks BIGNUMERIC(38,5)
OPTIONS(description='Inbound Department: number of trucks booked inbound (without packaging material)'),
we_items BIGNUMERIC(38,5)
OPTIONS(description='Inbound Department: number of Items booked inbound without packaging material'),
we_pallets_stored_in_reserve BIGNUMERIC(38,5)
OPTIONS(description='Inbound Department: number of pallets booked inbound and stored on reserve bins'),
we_paletts_stored_in_pick BIGNUMERIC(38,5)
OPTIONS(description='Inbound Department: number of pallets booked inbound and stored on pick bins'),
we_paletts_processed_on_deco BIGNUMERIC(38,5)
OPTIONS(description='Inbound Department: number of paletts processed on Deco Stations'),
we_boxes_processed_on_deco BIGNUMERIC(38,5)
OPTIONS(description='Inbound Department: number of boxes processed on Deco Stations'),
ibt_items_stored_on_pick_bins BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: number of items stored on Pick bins'),
ibt_items_stored_on_shelf_pick_bins_from_inbound BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement:Items stored on Shelf pick bins from inbound'),
ibt_items_stored_on_shelf_pick_bins_from_reserve BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: Items stored on Shelf pick bins from reserve'),
ibt_items_stored_on_pallet_pick_bins_from_inbound BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: Items stored on pallet pick bins from inbound'),
ibt_items_stored_on_pallet_pick_bins_from_reserve BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: Items stored on pallet pick bins from reserve'),
ibt_number_of_confirmed_warehouse_tasks_stored_on_shelf_pick_bins_from_inbound BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: Number of confirmed warehouse tasks stocking on Shelf pick bins from inbound'),
ibt_number_of_confirmed_warehouse_tasks_stored_on_shelf_pick_bins_from_reserve BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: Number of confirmed warehouse tasks stocking on Shelf pick bins from reserve'),
ibt_number_of_confirmed_warehouse_tasks_stored_on_pallet_pick_bins_from_inbound BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: Number of confirmed warehouse tasks stocking on pallet pick bins from inbound'),
ibt_number_of_confirmed_warehouse_tasks_stored_on_pallet_pick_bins_from_reserve BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: Number of confirmed warehouse tasks stocking on pallet pick bins from reserve'),
ibt_items_mepo BIGNUMERIC(38,5) OPTIONS(description='Department Internal Movement: Items in Mepo Process'),
ibt_confirmed_warehouse_tasks_mepo BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: confirmed warehouse tasks in Mepo Process'),
ibt_confirmed_warehouse_tasks_ekx BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: confirmed warehouse tasks Narrow aisle truck and Wide Aisle Forklift.'),
ibt_confirmed_warehouse_tasks_fast_mover BIGNUMERIC(38,5)
OPTIONS(description='Department Internal Movement: confirmed warehouse tasks fast mover. All other forklift than Narrow aisle truck and Wide Aisle Forklift.'),
wa_picked_items_kk_gt_wein BIGNUMERIC(38,5)
OPTIONS(description='Department Pick: items in customer picking process (KT / GT / Wein)'),
wa_picked_items_transshipment BIGNUMERIC(38,5)
OPTIONS(description='Department Pick: items in Transshipment picking process (B2B for other FCs)'),
sort_pack_packed_items_kk_gt_wein BIGNUMERIC(38,5)
OPTIONS(description='Department Sort Pack: packed Items for customer shippments (KT / GT / Wein)'),
sort_pack_packed_packages_national BIGNUMERIC(38,5)
OPTIONS(description='Department Sort Pack: packed Shippments for customer for Germany'),
sort_pack_packed_packages_international BIGNUMERIC(38,5)
OPTIONS(description='Department Sort Pack: packed Shippments for customer for not for Germany'),
sort_pack_items_sorting BIGNUMERIC(38,5) OPTIONS(description='Department Sort Pack: items in sorting process'),
ship_packed_pallets BIGNUMERIC(38,5)
OPTIONS(description='Department Sort Pack: number of pallets for  loading palletized goods'),
sort_pack_number_of_errors_quality_tests BIGNUMERIC(38,5)
OPTIONS(description='Department Sort Pack: number of errors found in Quality Tests'),
sort_pack_checked_packages_quality_tests BIGNUMERIC(38,5)
OPTIONS(description='Department Sort Pack: number of shippments in Quality Tests'),
ship_number_of_outbound_tours BIGNUMERIC(38,5)
OPTIONS(description='Department Ship: number of outbound trucks - not swap bodys.'),
ret_total_items_customer_returns BIGNUMERIC(38,5) OPTIONS(description='Returns  Department: Items customer returns'),
ret_items_return_table BIGNUMERIC(38,5) OPTIONS(description='Return Department: processed items at return table'),
ret_items_clearing BIGNUMERIC(38,5) OPTIONS(description='Return Department: processed Items in Clearing process'),
ret_items_items_stored_on_pick_bins BIGNUMERIC(38,5)
OPTIONS(description='Return Department: Items put away to pick bins'),
ret_items_removal_lr_returns_power_seller_etc BIGNUMERIC(38,5)
OPTIONS(description='Return Department: Items in vendor return / powerseller process'),
ret_items_scrapping_process BIGNUMERIC(38,5) OPTIONS(description='Return Department: items in scapping process'),
reorg_inventur_net_hours_inventory BIGNUMERIC(38,5)
OPTIONS(description='Department Reorg / Inventur: Hours of employee processing Inventory'),
reorg_inventur_net_hours_reorg BIGNUMERIC(38,5)
OPTIONS(description='Department Reorg / Inventur: Hours of employee processing Reorganisation'),
reorg_inventur_counted_storage_bins_inventory BIGNUMERIC(38,5)
OPTIONS(description='Reorg / Inventur: number of counted storage bins for inventory'),
reorg_inventur_confirmed_storage_bins_reorg BIGNUMERIC(38,5)
OPTIONS(description='Reorg / Inventur: number of storage bins with confirmed Reorg Tasks'),
reorg_inventur_items_reorg_pick_to_reserve BIGNUMERIC(38,5)
OPTIONS(description='Reorg / Inventur: Items in reorg process pick to reserve'),
reorg_inventur_items_reorg_pick_to_pick BIGNUMERIC(38,5)
OPTIONS(description='Reorg / Inventur: Items in reorg process pick to pick'),
wko_items_verwertung_process BIGNUMERIC(38,5)
OPTIONS(description='WKO Items in  Verwerung process (Reselling to 3rd Party Reseller)'),
wko_number_of_clarification_cases BIGNUMERIC(38,5) OPTIONS(description='WKO number of clarificatin cases'),
hours_coordination_back_office_housekeeping_problem_solver BIGNUMERIC(38,5)
OPTIONS(description='Steuerung: hours of employees for Housekeeping, Back Office, Problem Solving'),
hours_coordination_office_we_wa BIGNUMERIC(38,5) OPTIONS(description='Steuerung: hours of employees for office WE / WA'),
hours_coordination_clearing BIGNUMERIC(38,5) OPTIONS(description='Steuerung: hours of employees for Clearing'),
hours_coordination_administration BIGNUMERIC(38,5)
OPTIONS(description='Steuerung: hours of employees for administration'),
hours_leitstand_kpi_administration_leitstand BIGNUMERIC(38,5)
OPTIONS(description='Leitstand (KPI): hours of employees for administration Leitstand'),
hours_leitstand_kpi_admin_steuerung BIGNUMERIC(38,5)
OPTIONS(description='Leitstand (KPI): hours of employees for administration Steuerung'),
total_warehouse_net_hours_finance_controlling BIGNUMERIC(38,5)
OPTIONS(description='Total Warehouse: Hours of employees for (Finance) Controlling'),
leitstand_kpi_net_hours_administration BIGNUMERIC(38,5)
OPTIONS(description='Department Leitstand (KPI): Hours of employees processing Pick / Replenishment-Waves'),
ibt_net_hours_forklift_drivers BIGNUMERIC(38,5) OPTIONS(description='Old column, no further maintenance!'),
ibt_number_of_confirmed_warehouse_tasks_stocking_on_pick_bins BIGNUMERIC(38,5)
OPTIONS(description='Old column, no further maintenance!'),
ibt_final_completed_warehouse_tasks_driving_orders BIGNUMERIC(38,5)
OPTIONS(description='Old column, no further maintenance!'),
vs_packed_te BIGNUMERIC(38,5) OPTIONS(description='Old column, no further maintenance!'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (wh_id, geoclass, calendar_dt) NOT ENFORCED
)
OPTIONS(description='ELKE - Quantity and hourly data from warehouse locations throughout the entire warehousing process, from goods receipt to shipment to customer.');