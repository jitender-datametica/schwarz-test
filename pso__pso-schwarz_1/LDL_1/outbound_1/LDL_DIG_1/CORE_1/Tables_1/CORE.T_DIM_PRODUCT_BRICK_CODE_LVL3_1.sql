CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_brick_code_lvl3_1 (
prod_gs1_lvl3_brick_cd STRING(40) NOT NULL
OPTIONS(description='The code of the third level of the GS1 article categorization system.  '),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='A description for a brick code'),
prod_gs1_lvl3_brick_descr STRING(250)
OPTIONS(description='Textual representation of the third level of the GS1 article categorization system.  '),
prod_gs1_lvl2_brick_cd STRING(40)
OPTIONS(description='The code of the second level of the GS1 article categorization system. '),
prod_gs1_lvl2_brick_descr STRING(250)
OPTIONS(description='Textual representation of the second level of the GS1 article categorization system.  '),
prod_gs1_lvl1_brick_cd STRING(40)
OPTIONS(description='The code of the first/highest/least granular level of the GS1 article categorization system.  '),
prod_gs1_lvl1_brick_descr STRING(250)
OPTIONS(description='Textual representation of the first/highest/least granular level of the GS1 article categorization system.  '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (prod_gs1_lvl3_brick_cd, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the brickcode level 3 of product hierarchy_1 ( the highest is level 1  , the lowest is level 3)');