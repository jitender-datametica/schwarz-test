CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_subscriber_active (
subscr_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the customer'),
subscr_nr STRING(50) OPTIONS(description='A subscriber number from original system'),
sub_channel STRING(100),
sub_name STRING(100) NOT NULL,
sub_origin STRING(100),
sub_dt TIMESTAMP NOT NULL,
sub_email STRING(100),
legal_txt STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (subscr_sid, sub_name, sub_dt) NOT ENFORCED
) OPTIONS(description='ETL support table for load subscribers');