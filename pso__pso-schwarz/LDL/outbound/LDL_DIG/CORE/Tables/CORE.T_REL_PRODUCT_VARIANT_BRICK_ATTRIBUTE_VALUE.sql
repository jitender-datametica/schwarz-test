CREATE TABLE IF NOT EXISTS ldl_dig_core.t_rel_product_variant_brick_attribute_value (
prod_variant_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
attr_cd STRING(50) NOT NULL OPTIONS(description='The code of the brickcode attribute. '),
attr_descr STRING(250) OPTIONS(description='Name of the brickcode attribute. Eg: Target Gender'),
value_cd STRING(50) NOT NULL OPTIONS(description='Code that identifies the brickcode attribute value'),
value_descr STRING(250) OPTIONS(description='Name of the brickcode attribute value - Possible example: Male'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
prod_brick_cd STRING(40)
OPTIONS(description='The Brickcode is a unique standardized code of all categories in the GS1 article categorization system on level 4 and is maintained for every article in SAP. '),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
PRIMARY KEY (prod_variant_sid, dwh_valid_from_tmsp, attr_cd, value_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the list of additional attributes applicable directly to product variant');