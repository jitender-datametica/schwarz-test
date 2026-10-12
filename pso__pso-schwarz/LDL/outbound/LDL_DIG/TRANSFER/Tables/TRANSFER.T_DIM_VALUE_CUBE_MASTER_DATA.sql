CREATE TABLE IF NOT EXISTS ldl_dig_transfer.t_dim_value_cube_master_data (
master_data_field_name STRING(150) NOT NULL
OPTIONS(description='The field name used in the Value Cube and in the Core data model for specific business master data.'),
field_data_type_descr STRING(50)
OPTIONS(description='The data type corresponding to the content of the master data field'),
field_descr STRING(500) OPTIONS(description='The description of the master data field, from the Core data model'),
tmsp_insert TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
tmsp_update TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (master_data_field_name) NOT ENFORCED
)
OPTIONS(description='This table contains the list of available master data dimensions and attributes, which can be used for querying the Value Cube.');