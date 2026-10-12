/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_TRAVEL_BOOKING_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 12. September 2023 14:52:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_travel_booking_2 (
trav_booking_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the booking'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid (Timestamp of last process update ).'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
booking_nr STRING(20) OPTIONS(description='Unique Booking ID.'),
trav_offer_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the customer'),
process_nr STRING(20)
OPTIONS(description='Unique process ID. Process ID indicates the connection of different services (eg. Travel & insurance booking)'),
cust_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the customer'),
trav_cost_center_cd STRING(5) OPTIONS(description='The code for the cost center ( for each source market )'),
trav_booking_channel_cd STRING(5) OPTIONS(description='Communication_2 channel where the process was initiated.'),
cust_booking_ref_sid BIGNUMERIC
OPTIONS(description='The unique identifier (surrogate key) for customer booking reference link'),
cust_booking_ref_link STRING(1000)
OPTIONS(description='The reference link containing EKID & URL identifying the customer touch points incase of offline and online booking'),
trav_booking_svc_type_cd STRING(20)
OPTIONS(description='The code for the booking service type ( TOUR_2 - Pauschalreise  , CRUISE - Kreuzfahrt etc )'),
tour_operator_cd STRING(50)
OPTIONS(description='Abbreviation of the tour_2 operator ( also known as provider) , no master data is available'),
tour_operator_agency_cd STRING(100) OPTIONS(description='The code for identifying tour_2 operator agency code'),
booking_dt DATE OPTIONS(description='Booking date'),
travel_start_dt DATE OPTIONS(description='Travel start date '),
travel_end_dt DATE OPTIONS(description='Travel end date '),
curr_trav_booking_status_cd STRING(5)
OPTIONS(description='Current Travel Booking Status_2 Code ( A - active , C - cancelled ). '),
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
OPTIONS(description='Value of a coupon a customer used for booking a travel. In the data sample of Bosys the value can be identified with the attribute "Preis" in combination with "Type". It is only then a voucher if "type"=fee. All other characterizations of type are related to services (fligth/tour_2/...)'),
trav_booking_coupon_cust_cd STRING(100)
OPTIONS(description='The codes that customer entered during booking process to activate Coupon.( examples 3001, 3002, etc)'),
is_flight_svc_avail_fg BOOL
OPTIONS(description='The indicator to identify if flight service is available in the booking'),
departure_airport_cd STRING(5)
OPTIONS(description='Departure Airport for outbound flight (IATA 3 letter code) , no master data is available'),
arrival_airport_cd STRING(5)
OPTIONS(description='Arrival Airport for outbound flight (IATA 3 letter code)  , no master data is available'),
destination_country_cd STRING(5) OPTIONS(description='Destination country_2 code'),
destination_region_name STRING(100) OPTIONS(description='Destination region_2 name'),
cruise_region_name STRING(100) OPTIONS(description='Cruise region_2 name'),
trav_booking_room_type_cd STRING(50) OPTIONS(description='Accomodation code (EZ-single room; DZ-double room;…)'),
trav_booking_food_pack_type_cd STRING(5)
OPTIONS(description='The code for the food & beverage packages (All inclusive | half board | …)'),
is_hotel_svc_avail_fg BOOL OPTIONS(description='The indicator to identify if hotel service is available in the booking'),
hotel_svc_cd STRING(20) OPTIONS(description='The code for hotel service within the booking'),
hotel_giata_nr STRING(20) OPTIONS(description='Identification Code for an accomodation.'),
hotel_city_name STRING(100)
OPTIONS(description='If an offer contains a GIATA ID , fulltext name of the city the accomodation is located'),
is_misc_svc_avail_fg BOOL OPTIONS(description='The indicator to identify if other service is available in the booking'),
curr_trav_booking_svc_status_cd STRING(5)
OPTIONS(description='The current code for the status_2 of  travel  service ( c-open,  b-booking , etc ). In case of cancellation, this value will be overwritten with the CURRENT value (C - cancelled) and the initial value will be stored in the column init_booking_svc_status_cd.'),
init_trav_booking_svc_status_cd STRING(20)
OPTIONS(description='The initial code for the status_2 of  travel  service ( c-open,  b-booking , etc ). In case of cancellation, this initial value for the travel booking status_2 will be stored here. '),
trav_booking_dist_sys_cd STRING(5) OPTIONS(description='The code for the general distribution system'),
offer_operator_cd STRING(100) OPTIONS(description='The code for the travel offer operator'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (trav_booking_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='The fact table with the booking details of service for travel done by customer');