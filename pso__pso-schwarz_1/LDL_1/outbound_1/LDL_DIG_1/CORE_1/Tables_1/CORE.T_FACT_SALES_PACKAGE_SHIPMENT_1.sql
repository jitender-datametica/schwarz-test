/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_SALES_PACKAGE_SHIPMENT_1
   GENERATED FROM POWERDESIGNER ON Montag, 4. August 2025 13:55:41
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_sales_package_shipment_1 (
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop where an order can be placed by a customer.The webshop is defined per political country_1'),
dist_channel_cd STRING(5)
OPTIONS(description='The code for the distribution channel ( a channel  through which the goods are sold )'),
pack_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier(surrogate key) for the package_1'),
cust_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the customer'),
ewm_pack_sid BIGNUMERIC
OPTIONS(description='The unique identifier (surrogate key) for the package_1 based on the EWM API data. This surrogate key is generated based on ewm_pack_nr and pack_tracking_nr.'),
pack_tracking_nr STRING(1000)
OPTIONS(description='The tracking ID which links the shipment to customer with the actual package_1 and can also be searched for within the the carrier url'),
ewm_pack_nr STRING(50)
OPTIONS(description='The warehouse(SAP EWM) system number which is being used to search within the EWM system'),
pack_tracking_url STRING(500)
OPTIONS(description='The URL which can be used in the browser to get all customer information which the carrier/hauler is providing to the customer'),
pack_order_nr STRING(20) NOT NULL
OPTIONS(description='The order number within warehouse system which tells which articles are part of which package_1'),
pack_order_tgt_create_tmsp TIMESTAMP
OPTIONS(description='The timestamp until which it is being expected from the lidl digital business to create the EWM order'),
pack_order_actual_create_tmsp TIMESTAMP
OPTIONS(description='Technical timestamp when the order has been created within EWM (warehouse system). This also indicates when the TrackingId has been created and is therefore the start of a Shipment'),
pack_order_orig_create_tmsp TIMESTAMP
OPTIONS(description='The original timestamp of the order created within EWM (warehouse system) - before any changes to the date were made, e.g. because of insufficient stock. '),
delivery_order_nr STRING(20)
OPTIONS(description='The order number from the SAP retail system that processes deliveries'),
cust_delivery_tgt_dt DATE
OPTIONS(description='The first date which has been communicated to the customer for the expected delivery'),
cust_delivery_tgt_hauler_tmsp TIMESTAMP
OPTIONS(description='Timestamp when package_1 is meant to arrive at the customer. This timestamp differs from the communicated timestamp to the customer as the expected delivery timestamp for the carrier is being dependent on goods arrival time at the first service hub. The package_1 might have not been available as promised which the carrier can\'t be charged for."'),
first_attempt_delivery_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the shipment is delivered by service provider for the first time. It will be considered in customer quota as the service provider has fulfilled its duty. It does not necessarily mean_1 that customer has received shipment as he/she might not have been at home'),
cust_delivery_actual_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the customer has received delivery physically. It will not affect any DLZ quota, because it is up the customer when to pick up the delivery from neighbour or post office etc.'),
wh_sid BIGNUMERIC OPTIONS(description='The unique identifier(surrogate key) for the physical warehouse'),
wh_cd STRING(5) OPTIONS(description='A short unique code for the warehouses which receives the deliveries'),
wh_leave_tgt_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the truck is meant to leave for the specific tracking id. The time is known as CPT. The time depends on the warehouse, the carrier, the workday and the shipment type'),
wh_leave_actual_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the truck actually left the warehouse platform (\"Rampe\") from which the package_1 is sent to the customer'),
first_hub_cd STRING(5)
OPTIONS(description='A hub is the distribution center of the carrier to fullfill the package_1 shipment.First hub indicates the one which is the first location_1 after our warehouse'),
first_hub_scan_actual_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the first scan of service provider in his first hub has happened'),
first_hub_scan_tgt_tmsp TIMESTAMP
OPTIONS(description='Timestamp when the package_1 is meant to arrive in the starting hub of the carrier. This timestamp depends on the\"Warenausgangszeitstempel\" (leave timestamp from warehouse)'),
last_hub_cd STRING(5)
OPTIONS(description='A hub is the distribution center of the carrier to fullfill the package_1 shipment.Last hub indicates the one, which is the last station before the customer'),
first_hub_loc_descr STRING(100)
OPTIONS(description='Describes the location_1 of the first Hub of a Carrier/Hauler where the Parcel gets sent to / arrives at. In case the parcel doesn\'t need a second hub, this will be the last hub on the way of the parcel delivery to the customer.'),
second_hub_loc_descr STRING(100)
OPTIONS(description='Describes the location_1 of the second Hub of a Carrier/Hauler where the Parcel gets sent to / arrives at. It is the last hub on the way of the parcel delivery to the customer.'),
is_replacement_delivery_fg BOOL
OPTIONS(description='The flag which tells whether the delivery is a replacement delivery or not'),
is_damaged_fg BOOL
OPTIONS(description='The flag which tells whether the product was broken by the carrier during the shipment to the customer'),
is_lost_pack_fg BOOL
OPTIONS(description='The flag which indicates whether it is a lost package_1 or not. Evaluated based on how many days have passed since the goods(package_1) were issued but there was no inbound/delivery scan'),
is_ghost_pack_fg BOOL
OPTIONS(description='Indicator if the package_1 was lost during the transfer process from the warehouse to the logistics company (carrier).'),
is_ghost_pack_return_fg BOOL OPTIONS(description='Indicator if the ghost package_1 was returned to the warehouse.'),
pack_return_tmsp TIMESTAMP
OPTIONS(description='Timestamp when any package_1 gets returned to the warehouse.'),
ghost_pack_return_duration_days_cnt BIGNUMERIC
OPTIONS(description='For ghost packages (packages that did not reached the carrier) this is the number of days between the return date (pack_return_tmsp) and the date when the package_1 was supposed to be handed to the carrier (data_transferred_to_carrier_tmsp, an ETL field used to derive the logic). For packages that the carrier received successfully, the value in the field is NULL.'),
pack_size_type_cd STRING(50)
OPTIONS(description='The code for the package_1 size type  (Normal , Überlänge, XXL , Heavy etc)'),
delivery_type_cd STRING(5)
OPTIONS(description='The code for the package_1 delivery type  (Home Delivery, Shop Delivery, Locker Delivery)'),
is_productsize_used_fg BOOL
OPTIONS(description='Discriminator which tells whether trackingId is using Article sizes or is within a Package_1 and therefore the package_1 size'),
delivery_addr_sid BIGNUMERIC
OPTIONS(description='The unique identifier (sk) for the delivery address_1 where original order was delivered'),
delivery_zip_short_cd STRING(100)
OPTIONS(description='This field holds a shortened version of the delivery address_1 postcode. The last character (either digit or letter) is removed to avoid identification of a customer.'),
hauler_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the hauler'),
hauler_ship_type_id STRING(50)
OPTIONS(description='The unique identifier for available shipment modes for carrier that is coming from source system'),
hauler_name STRING(100) OPTIONS(description='The name by which the hauler is known'),
hauler_country_cd STRING(5)
OPTIONS(description='The unique code for a country_1 according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
hauler_paym_class_cd STRING(5)
OPTIONS(description='This Payment Code classifies Trackingids, classification depends on the carrier. Depending on the code Lidl Digital has to pay a different amount of money to the carrier.'),
pack_height_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 height'),
pack_height_uom_sid BIGNUMERIC OPTIONS(description='Package_1 height unit_1 of measure'),
pack_width_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 width'),
pack_width_uom_sid BIGNUMERIC OPTIONS(description='Package_1 width unit_1 of measure'),
pack_length_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 length'),
pack_mean_length_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 length mean_1 value'),
pack_shortest_length_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 length shortest value'),
pack_longest_length_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 length longest value'),
pack_length_uom_sid BIGNUMERIC OPTIONS(description='Package_1 length unit_1 of measure'),
pack_girth_west_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 girth West'),
pack_girth_east_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 girth east'),
pack_girth_uom_sid BIGNUMERIC OPTIONS(description='Package_1 girth unit_1 of measure'),
pack_weight_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 weight'),
pack_weight_uom_sid BIGNUMERIC OPTIONS(description='Package_1 weight unit_1 of measure'),
pack_volume_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 volume'),
pack_volume_uom_sid BIGNUMERIC OPTIONS(description='Package_1 volume unit_1 of measure'),
weight_class_cd STRING(50) OPTIONS(description='A code for weight classification'),
volume_class_cd STRING(50) OPTIONS(description='A code for volume classification'),
delivery_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for delivery order '),
deliv_prod_qty BIGNUMERIC(38,5) OPTIONS(description='Total quantity of delivered products within the given package.'),
pack_material_nr STRING(20) OPTIONS(description='The packaging material number (e..g 420000026,  420000028)'),
vehicle_license_plate_nr STRING(30)
OPTIONS(description='The licence plate number of the trucks which carries the package_1'),
vehicle_internal_nr STRING(40)
OPTIONS(description='This number is the internal number of the trucks which carries the package.'),
vehicle_loading_start_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the loading in the truck started'),
vehicle_loading_end_tmsp TIMESTAMP
OPTIONS(description='The timestamp when a truck is finished with loading'),
vehicle_departure_tmsp TIMESTAMP
OPTIONS(description='The timestamp when a truck departed from the warehouse'),
vehicle_hub_loading_start_tmsp TIMESTAMP
OPTIONS(description='The timestamp when a truck with a certain truck plate nr is doing the very first hub scan tmsp for the first package_1 of its entire freight at the warehouse '),
vehicle_hub_loading_end_tmsp TIMESTAMP
OPTIONS(description='Based on the first hub scan tmsp ranges the minimum first hub scan tmsp per range is defined as unloading stop tmsp'),
vehicle_hub_loading_pct BIGNUMERIC(38,5)
OPTIONS(description='Classification of the first hub scan tmsp in ranges for its entire freight of a truck with a certain truck plate nr. The classification is done in a range of 0, 95, 96, 97, 98, 99, 100 percent ranks starting with the very first hub scan as rank 0.'),
vehicle_hub_loading_dur_hr BIGNUMERIC(38,5)
OPTIONS(description='Time difference of the unloading start tmsp and stop tmsp in hours.'),
delivery_postponed_tgt_tmsp TIMESTAMP
OPTIONS(description='The timestamp of the postponed target delivery date'),
pack_height_uom_cd STRING(5) OPTIONS(description=' A code for the unit_1 of measure for package_1 height'),
pack_width_uom_cd STRING(5) OPTIONS(description=' A code for the unit_1 of measure for package_1 width'),
pack_length_uom_cd STRING(5) OPTIONS(description=' A code for the unit_1 of measure for package_1 length'),
pack_girth_uom_cd STRING(5) OPTIONS(description=' A code for the unit_1 of measure for package_1 girth'),
pack_weight_uom_cd STRING(5) OPTIONS(description=' A code for the unit_1 of measure for package_1 weight'),
pack_volume_uom_cd STRING(5) OPTIONS(description=' A code for the unit_1 of measure for package_1 volume'),
cust_ship_delay_day BIGNUMERIC(38,5)
OPTIONS(description='If cust_ship_punctuality_cd has the value “too late” then the delay will be calculated in days, not subtracting possible weekend days (Saturday, Sunday) or regional holidays'),
hauler_delay_hr BIGNUMERIC(38,5)
OPTIONS(description='If hauler_punctuality_cd has the value “too late” then the delay will be calculated in hours, subtracting possible weekend days (Saturday, Sunday) or regional holidays'),
wh_delay_hr BIGNUMERIC(38,5)
OPTIONS(description='If wh_punctuality_cd has the value “too late” then the delay will be calculated in hours, subtracting possible weekend days (Saturday, Sunday) or regional holidays'),
cust_ship_punctuality_cd STRING(50)
OPTIONS(description='Calculation of the punctuality of the package_1 to the customer. The punctuality is based on the time difference of the customer delivery target date and the first attempt delivery tmsp. Possible values are punctual (pünktlich), too late (zu spät) or delivery not confirmed (Zustellung nicht bestätigt)'),
hauler_punctuality_cd STRING(50)
OPTIONS(description='Calculation of the punctuality of the hauler delivering the package_1 to the customer. The punctuality is based on the time difference of the customer delivery target hauler tmsp and the first attempt delivery tmsp. Possible values are punctual (pünktlich), too late (zu spät), delivery open (Sendung offen) or income scan pending (WE Scan ausstehend)'),
wh_punctuality_cd STRING(50)
OPTIONS(description='Calculation of the punctuality of a truck leaving the warehouse. The punctuality is based on the time difference of the warehouse leave target tmsp and the warehouse leave actual tmsp. Possible values are punctual (pünktlich), too late (zu spät) or leave pending (WA ausstehend)'),
cust_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
cust_order_dt DATE OPTIONS(description='The date when order was made ( when customer created the order )'),
cust_order_type_cd STRING(5)
OPTIONS(description='This field contains codes for different credit notes for orders, for example ZRPL for replacement order and ZWSO for webshop sales_1 order and so on.'),
cust_paym_method_cd STRING(5) OPTIONS(description='Unique code of the payment method'),
ic_order_nr STRING(20)
OPTIONS(description='The order number assigned to the intercompany sale order in the source system'),
ic_order_dt DATE OPTIONS(description='The date when order was made'),
pack_order_create_punctuality_cd STRING(10)
OPTIONS(description='This code denotes the punctuality of the package_1 order creation in EWM (warehouse system) compared to wh_leave_tgt_tmsp or compared to a fixed point in time (2 a.m.) If the package_1 order is created in EWM before 2 a.m. or before wh_leave_tgt_tmsp, the punctuality is considered "on time". Otherwise, it is considered "too late".'),
locker_located_at_lidl_store_fg BOOL OPTIONS(description='A flag indicating if locker is situated at Lidl store'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (pack_sid) NOT ENFORCED
)
OPTIONS(description='Combines the information about the package_1 and the details of its shipment  ( including Lidl Webshops customer orders and IC orders, excluding dropshipments). A detailed facted created to support delivery report (DLZ).             This table has same granularity and main src as T_FACT_GOODS_PACKAGE_SHIPMENT_1, however here we have a limited subset of the data.             Only shipments from a LDL warehouse directly to customers (regular or intercompany orders).              The table is additionally enriched with information about carrier/hauler and vehicle used for transport and the transportation steps itself.             At some point it was decided that enriching all data in T_FACT_GOODS_PACKAGE_SHIPMENT_1 will be unnecessary and would require a lot of processing time, so this table was separated and it includes only subset of all package_1 shipments. In the future this decision could be reevaluated.                          Main Src - SAP ERP table VEKP, enriched with data from ZEWT_VEH_HEADER , and "Carrier Layer"');