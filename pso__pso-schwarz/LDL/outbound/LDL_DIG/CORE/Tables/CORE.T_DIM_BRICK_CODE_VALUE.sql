CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_brick_code_value (
value_cd STRING(50) NOT NULL OPTIONS(description='Code that identifies the brickcode attribute value'),
value_descr STRING(250) OPTIONS(description='Name of the brickcode attribute value - Possible example: Male'),
is_custom_fg BOOL
OPTIONS(description='This flag shows if a brick_attribute and relative brick_attribute_value are custom (defined internally) or if they are derived from the GPC convention (defined externally).'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (value_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the list of additional attributes applicable to brickcode categories');