CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_customer_blocked_reason_2 (
cust_blocked_reason_cd STRING(5) NOT NULL
OPTIONS(description='The code for the central order block via certain payment types for a customer'),
cust_blocked_reason_descr STRING(250) NOT NULL
OPTIONS(description='The description for the  central  order block via certain payment types for a customer'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_blocked_reason_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the reasons why it is not allowed for the customer to place an order in SAP');