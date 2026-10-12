/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_MASTER_CUSTOMER_2
   GENERATED FROM POWERDESIGNER ON Montag, 20. November 2023 08:43:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_rel_master_customer_2 (
master_cust_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the master customer'),
cust_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the customer'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
cust_type_cd STRING(5)
OPTIONS(description='The code for the customer type to differentiate whether an online shop or travel customer'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (dwh_valid_from_tmsp, cust_sid) NOT ENFORCED
)
OPTIONS(description='A dimension that holds relationship between customer and master customer data. One customer is related to only one master record at a time, master customer record consolidates data of several records from customer dimension. Does not contain GDPR protected data');