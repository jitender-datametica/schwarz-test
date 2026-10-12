/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_LOYALTY_LIFECYCLE_1
   GENERATED FROM POWERDESIGNER ON Freitag, 24. Mai 2024 16:15:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_customer_loyalty_lifecycle_1 (
cust_loyalty_lifecycle_cd STRING(5) NOT NULL
OPTIONS(description='The code that defines the loyalty lifecycle of the customer.'),
cust_loyalty_lifecycle_descr STRING(250) NOT NULL
OPTIONS(description='The description for the code that defines the loyalty lifecycle of the customer.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_loyalty_lifecycle_cd) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - This dimension defines the loyalty lifecycle of the customer based on the time interval between two consecutive orders i.e.             New Customer (NC) = 2nd last order was placed more than 3 years ago or is non-existent.             Reactivated Customer (RC) = 2nd last order was placed more than 1 year ago, but less than 3 years ago.             Existing Customer (EC) = 2nd last order was placed less than 1 year ago (more than 1 order in the past year).                          ');