CREATE OR REPLACE TABLE ldl_data_production_etl.t_product_key_type_1 (
prod_key_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the Product.'),
prod_key_type_name STRING(100) NOT NULL
OPTIONS(description='The name of the type of natural key which identifies the Product.'),
prod_key_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the type of natural key, detailing its format and the meaning of the components.'),
PRIMARY KEY (prod_key_type_cd) NOT ENFORCED
);