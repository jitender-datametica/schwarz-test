CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_travel_booking_passenger (
trav_booking_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the booking'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
passenger_salutation STRING(100) OPTIONS(description='Passenger salutation'),
passenger_full_name STRING(100) NOT NULL OPTIONS(description='Passenger full name '),
passenger_birth_year BIGNUMERIC NOT NULL OPTIONS(description='Passenger birth year ( 0 if it could not be identified)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
booking_nr STRING(20) OPTIONS(description='Unique Booking ID.'),
process_nr STRING(20)
OPTIONS(description='Unique process ID. Process ID indicates the connection of different services (eg. Travel & insurance booking)'),
PRIMARY KEY (trav_booking_sid, dwh_valid_from_tmsp, passenger_full_name, passenger_birth_year) NOT ENFORCED
) OPTIONS(description='A fact containing passengers list for a particular booking');