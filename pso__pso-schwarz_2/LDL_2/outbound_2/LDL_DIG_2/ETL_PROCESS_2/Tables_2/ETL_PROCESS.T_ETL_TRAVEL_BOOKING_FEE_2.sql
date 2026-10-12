/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_TRAVEL_BOOKING_FEE_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 22. August 2023 16:32:19
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_travel_booking_fee_2 (
boskey_id STRING(100) NOT NULL OPTIONS(description='Unique booking identifier in bosys API.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid (Timestamp of last process update ).'),
last_process_update_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid (Timestamp of last process update ).'),
trav_booking_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the booking'),
process_nr STRING(20)
OPTIONS(description='Unique process ID. Process ID indicates the connection of different services (eg. Travel & insurance booking)'),
booking_nr STRING(20) OPTIONS(description='Unique Booking ID.'),
trav_booking_coupon_cd STRING(25)
OPTIONS(description='The codes that customer entered during booking process to activate Coupon.( examples 3001, 3002, etc)'),
coupon_price_val BIGNUMERIC(38,5)
OPTIONS(description='Value of a coupon a customer used for booking a travel. In the data sample of Bosys the value can be identified with the attribute "Preis" in combination with "Type". It is only then a voucher if "type"=fee. All other characterizations of type are related to services (fligth/tour_2/...)'),
trav_booking_coupon_cust_cd STRING(100)
OPTIONS(description='The codes that customer entered during booking process to activate Coupon.( examples 3001, 3002, etc)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (last_process_update_tmsp, dwh_valid_from_tmsp, boskey_id) NOT ENFORCED
)
OPTIONS(description='This ETL table contains detailed fee data for a booking and offers high granularity by adding the bosys id. It is used to help loading data into T_FACT_TRAVEL_BOOKING_2, specially for the FEE');