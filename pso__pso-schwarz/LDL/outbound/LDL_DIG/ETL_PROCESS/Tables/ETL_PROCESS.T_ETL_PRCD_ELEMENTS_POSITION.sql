CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_prcd_elements_position (
prcd_elements_condition_nr STRING(20) NOT NULL,
cust_order_pos_nr BIGNUMERIC NOT NULL,
condition_counter BIGNUMERIC NOT NULL,
level_nr BIGNUMERIC NOT NULL,
condition_type STRING(5),
price_condition STRING(2),
price_condition_val BIGNUMERIC(38,5),
amount_val BIGNUMERIC(38,5),
curr_cd STRING(5),
lead_src_log_sys_cd STRING(100) OPTIONS(description='Technical field - source code'),
lead_src_name STRING(100) OPTIONS(description='Technical field - source name '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prcd_elements_condition_nr, cust_order_pos_nr, condition_counter, level_nr) NOT ENFORCED
) OPTIONS(description='ETL support table for pricing');