/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_GENERATION_1
   GENERATED FROM POWERDESIGNER ON Montag, 20. November 2023 08:42:04
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_customer_generation_1 (
cust_generation_cd STRING(50) NOT NULL OPTIONS(description='The code for a customer generation'),
cust_generation_descr STRING(250) OPTIONS(description='The textual description for the generation of a customer '),
generation_start_cy BIGNUMERIC OPTIONS(description='Calendar_1 year for a start of generation'),
generation_end_cy BIGNUMERIC OPTIONS(description='Calendar_1 year for an end of generation'),
display_order_nr BIGNUMERIC OPTIONS(description='Display order number for a generation list to appear in front end'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_generation_cd) NOT ENFORCED
)
OPTIONS(description='This dimension contains a list of generations for customer segmentation ( Generation Alpha , Generation X etc )');