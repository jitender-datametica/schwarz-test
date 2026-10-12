CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_order_cancellation_status_2 (
order_cancel_status_cd STRING(5) NOT NULL OPTIONS(description='The code for the status_2 of cancellation'),
order_cancel_status_descr STRING(250) NOT NULL
OPTIONS(description='The textual description for  status_2 of cancellation'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (order_cancel_status_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the status_2 of cancellation');