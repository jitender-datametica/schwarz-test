CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_brick_code_attribute_1 (
attr_cd STRING(50) NOT NULL OPTIONS(description='The code of the brickcode attribute. '),
attr_descr STRING(250) OPTIONS(description='Name of the brickcode attribute. Eg: Target Gender'),
is_custom_fg BOOL
OPTIONS(description='This flag shows if a brick_attribute and relative brick_attribute_value are custom (defined internally) or if they are derived from the GPC convention (defined externally).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (attr_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the list of additional attributes applicable to brickcode categories');