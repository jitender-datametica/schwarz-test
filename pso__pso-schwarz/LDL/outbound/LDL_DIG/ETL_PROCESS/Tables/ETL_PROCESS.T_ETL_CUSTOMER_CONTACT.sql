CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_customer_contact (
addr_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the addresses'),
cust_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the customer'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
contact_cust_nr STRING(20) OPTIONS(description='A customer number from original system'),
cust_addr_nr STRING(100) OPTIONS(description='Original address numbers in source system'),
phone_nr STRING(100) OPTIONS(description='The phone number of the customer'),
email STRING(100) OPTIONS(description='The email address of the customer'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (addr_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='Etl table to support development of t_customer');