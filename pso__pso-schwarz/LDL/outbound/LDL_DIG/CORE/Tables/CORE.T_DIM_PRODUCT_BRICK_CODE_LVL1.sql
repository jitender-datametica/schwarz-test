CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_brick_code_lvl1 (
prod_gs1_lvl1_brick_cd STRING(40) NOT NULL
OPTIONS(description='The code of the first/highest/least granular level of the GS1 article categorization system.  '),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
prod_gs1_lvl1_brick_descr STRING(250)
OPTIONS(description='Textual representation of the first/highest/least granular level of the GS1 article categorization system.  '),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (prod_gs1_lvl1_brick_cd, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the brickcode , that is a unique standardized code of all categories in the GS1 article categorization system on level 4 and is maintained for every article in SAP. ');