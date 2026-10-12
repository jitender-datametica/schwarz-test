/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_CUSTOMER_ORDER_LOYALTY_CLASSIFICATION
   GENERATED FROM POWERDESIGNER ON Dienstag, 30. April 2024 12:48:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_customer_order_loyalty_classification (
cust_order_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) to identify last order that was placed by a customer before any point in time.'),
master_cust_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the master customer'),
cust_loyalty_lifecycle_cd STRING(5) OPTIONS(description='The code that defines the loyalty lifecycle of the customer.'),
cust_loyalty_classification_cd STRING(5)
OPTIONS(description='Code identifying customer purchasing habits ( One-time buyer, Occasional Buyer, Loyal Customer)'),
second_last_cust_order_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) to identify 2nd last order that was placed by a customer before any point in time.'),
third_last_cust_order_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) to identify 3rd last order that was placed by a customer before any point in time.'),
fourth_last_cust_order_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) to identify 4th last order that was placed by a customer before any point in time.'),
cust_order_create_tmsp TIMESTAMP
OPTIONS(description='The timestamp when order was created in source ERP system ( is used in reporting)'),
second_last_cust_order_create_tmsp TIMESTAMP
OPTIONS(description='The Timestamp when customer\'s 2nd last order was created in source system.'),
third_last_cust_order_create_tmsp TIMESTAMP
OPTIONS(description='The Timestamp when customer\'s 3rd last order was created in source system.'),
fourth_last_cust_order_create_tmsp TIMESTAMP
OPTIONS(description='The Timestamp when customer\'s 4th last order was created in source system.'),
days_diff_order_1_2_cnt BIGNUMERIC OPTIONS(description='Number of days between last and the 2nd last customer order.'),
days_diff_order_1_3_cnt BIGNUMERIC OPTIONS(description='Number of days between last and the 3rd last customer order.'),
days_diff_order_1_4_cnt BIGNUMERIC OPTIONS(description='Number of days between last and the 4th last customer order.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (cust_order_sid) NOT ENFORCED
)
OPTIONS(description='Fact table - Transactional - Transaction - A fact table for all OS (Online Shop) orders from each master customer as well as their corresponding 3 orders (including order timestamps & calculated number of days between them) that might have been before that to determine the loyalty segmentation of the master customer.');