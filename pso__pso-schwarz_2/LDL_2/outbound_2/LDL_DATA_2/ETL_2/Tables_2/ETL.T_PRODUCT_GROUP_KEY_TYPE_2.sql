CREATE TABLE IF NOT EXISTS ldl_data_etl.t_product_group_key_type_2 (
prod_grp_key_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the Product Group.'),
prod_grp_key_type_name STRING(100) NOT NULL
OPTIONS(description='The name of the type of natural key which identifies the Product Group.'),
prod_grp_key_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the type of natural key, detailing its format and the meaning of the components.'),
PRIMARY KEY (prod_grp_key_type_cd) NOT ENFORCED
);