CREATE TABLE IF NOT EXISTS ldl_data_etl.t_inventory_key_type_1 (
inv_key_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the Inventory.'),
inv_key_type_name STRING(100) NOT NULL
OPTIONS(description='The name of the type of natural key which identifies the Inventory.'),
inv_key_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the type of natural key, detailing its format and the meaning of the components.')
);