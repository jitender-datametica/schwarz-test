/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_TRAVEL_BOOKING_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 6. September 2023 10:14:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_travel_booking_1 (
boskey_id STRING(100) NOT NULL OPTIONS(description='Unique booking identifier in bosys API.'),
requirement_tomastadis_cd STRING(20) NOT NULL
OPTIONS(description='The TOMA/STADIS interface transfers a standardized code for the request to distinguish the type of booking, such as hotel / flight / other.'),
service_cd STRING(50) NOT NULL
OPTIONS(description='The code contains different hotel types and for flights with stopovers the airports are listed.'),
accommodation_cd STRING(50) NOT NULL
OPTIONS(description='The code contains a clear description of the accommodation such as the type of room: single room, double room, others.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid (Timestamp of last process update ).'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
trav_booking_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the booking'),
booking_nr STRING(20) OPTIONS(description='Unique Booking ID.'),
trav_offer_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the customer'),
process_nr STRING(20)
OPTIONS(description='Unique process ID. Process ID indicates the connection of different services (eg. Travel & insurance booking)'),
cust_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the customer'),
trav_cost_center_cd STRING(5) OPTIONS(description='The code for the cost center ( for each source market )'),
trav_booking_channel_cd STRING(5) OPTIONS(description='Communication_1 channel where the process was initiated.'),
cust_booking_ref_sid BIGNUMERIC
OPTIONS(description='The unique identifier (surrogate key) for customer booking reference link'),
cust_booking_ref_link STRING(1000)
OPTIONS(description='The reference link containing EKID & URL identifying the customer touch points incase of offline and online booking'),
trav_booking_svc_type_cd STRING(20)
OPTIONS(description='The code for the booking service type ( TOUR_1 - Pauschalreise  , CRUISE - Kreuzfahrt etc )'),
tour_operator_cd STRING(50)
OPTIONS(description='Abbreviation of the tour_1 operator ( also known as provider) , no master data is available'),
tour_operator_agency_cd STRING(100) OPTIONS(description='The code for identifying tour_1 operator agency code'),
booking_dt DATE OPTIONS(description='Booking date'),
travel_start_dt DATE OPTIONS(description='Travel start date '),
travel_end_dt DATE OPTIONS(description='Travel end date '),
trav_booking_status_cd STRING(5) OPTIONS(description='Travel Booking Status_1 Code ( A - active , C - cancelled )'),
cancel_dt DATE OPTIONS(description='Cancellation date'),
child_cnt BIGNUMERIC OPTIONS(description='Number of kinder'),
passenger_cnt BIGNUMERIC OPTIONS(description='Number of passengers'),
passenger_type_cluster_cd STRING(25)
OPTIONS(description='The code for the categorization of passanger based on their age and gender ( Single traveler , Small Family , etc)'),
flight_svc_cd STRING(100) OPTIONS(description='The code for flight service within the booking'),
curr_cd STRING(5) OPTIONS(description='The code identifying the currency according to ISO-4217.'),
init_booking_svc_price_val BIGNUMERIC(38,5) OPTIONS(description='Initial booking price '),
init_booking_svc_provision_val BIGNUMERIC(38,5) OPTIONS(description='Initial booking provision '),
curr_booking_svc_price_val BIGNUMERIC(38,5)
OPTIONS(description='Current booking price ( aditional services can be added or removed )'),
curr_booking_svc_provision_val BIGNUMERIC(38,5)
OPTIONS(description='Current booking provision ( aditional services can be added or removed )'),
cancel_price_val BIGNUMERIC(38,5)
OPTIONS(description='Cancellation booking price ( filled only if booking is cancelled )'),
cancel_provision_val BIGNUMERIC(38,5)
OPTIONS(description='Cancellation booking  provision ( filled only if booking is cancelled )'),
trav_booking_coupon_cd STRING(25)
OPTIONS(description='The codes that customer entered during booking process to activate Coupon.( examples 3001, 3002, etc)'),
coupon_price_val BIGNUMERIC(38,5)
OPTIONS(description='Value of a coupon a customer used for booking a travel. In the data sample of Bosys the value can be identified with the attribute "Preis" in combination with "Type". It is only then a voucher if "type"=fee. All other characterizations of type are related to services (fligth/tour_1/...)'),
trav_booking_coupon_cust_cd STRING(100)
OPTIONS(description='The codes that customer entered during booking process to activate Coupon.( examples 3001, 3002, etc)'),
is_flight_svc_avail_fg BOOL
OPTIONS(description='The indicator to identify if flight service is available in the booking'),
departure_airport_cd STRING(5)
OPTIONS(description='Departure Airport for outbound flight (IATA 3 letter code) , no master data is available'),
arrival_airport_cd STRING(5)
OPTIONS(description='Arrival Airport for outbound flight (IATA 3 letter code)  , no master data is available'),
destination_country_cd STRING(5) OPTIONS(description='Destination country_1 code'),
destination_region_name STRING(100) OPTIONS(description='Destination region_1 name'),
cruise_region_name STRING(100) OPTIONS(description='Cruise region_1 name'),
trav_booking_room_type_cd STRING(50) OPTIONS(description='Accomodation code (EZ-single room; DZ-double room;…)'),
trav_booking_food_pack_type_cd STRING(5)
OPTIONS(description='The code for the food & beverage packages (All inclusive | half board | …)'),
is_hotel_svc_avail_fg BOOL OPTIONS(description='The indicator to identify if hotel service is available in the booking'),
hotel_svc_cd STRING(20) OPTIONS(description='The code for hotel service within the booking'),
hotel_giata_nr STRING(20) OPTIONS(description='Identification Code for an accomodation.'),
hotel_city_name STRING(100)
OPTIONS(description='If an offer contains a GIATA ID , fulltext name of the city the accomodation is located'),
is_misc_svc_avail_fg BOOL OPTIONS(description='The indicator to identify if other service is available in the booking'),
trav_booking_svc_status_cd STRING(5)
OPTIONS(description='The code for the status_1 of  travel  service ( c-open,  b-booking , etc )'),
trav_booking_dist_sys_cd STRING(5) OPTIONS(description='The code for the general distribution system'),
offer_operator_cd STRING(100) OPTIONS(description='The code for the travel offer operator'),
init_booking_status_cd STRING(5)
OPTIONS(description='This field stores the initial value in case the booking was canceled and the current code is automatically overwritten by "S" (Storniert). Example value for "INIT_STATUS_CD": "SE".'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (dwh_valid_from_tmsp, boskey_id, requirement_tomastadis_cd, service_cd, accommodation_cd) NOT ENFORCED
)
OPTIONS(description='This ETL table offers high granularity by adding the bosys id. The table is used to help loading data into T_FACT_TRAVEL_BOOKING_1');