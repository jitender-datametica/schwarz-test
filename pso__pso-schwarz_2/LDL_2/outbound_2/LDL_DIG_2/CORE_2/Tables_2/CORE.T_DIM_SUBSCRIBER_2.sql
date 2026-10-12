CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_subscriber_2 (
subscr_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the customer'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
subscr_nr STRING(50) OPTIONS(description='A customer number from original system'),
email STRING(100) OPTIONS(description='The email address_2 of the customer'),
sso_id STRING(20) OPTIONS(description='Single Sign on Id'),
tracking_token STRING(2000)
OPTIONS(description='A string that is inserted in email allowing the tracking of subscriber activities'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (subscr_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A person who is signed up for Lidl Newsletter ( does not include people who subscribed for individual products )');