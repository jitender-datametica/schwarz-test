/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_LOYALTY_CLASSIFICATION_1
   GENERATED FROM POWERDESIGNER ON Montag, 24. Juli 2023 12:46:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_customer_loyalty_classification_1 (
cust_loyalty_classification_cd STRING(5) NOT NULL
OPTIONS(description='Code identifying customer purchasing habits ( One-time buyer, Occasional Buyer, Loyal Customer)'),
cust_loyalty_classification_descr STRING(250) NOT NULL
OPTIONS(description='Description of customer\'s purchasing habits ( One-time buyer, Occasional Buyer, Loyal Customer)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_loyalty_classification_cd) NOT ENFORCED
)
OPTIONS(description='This dimension describes the classification of the customer based on their bying habits (one-time, occasional, loyal ..)');