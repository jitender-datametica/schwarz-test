/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_TAX_TYPE_1
   GENERATED FROM POWERDESIGNER ON Freitag, 23. September 2022 12:52:57
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_tax_type_1 (
tax_type_cd STRING(5) NOT NULL OPTIONS(description='The code identifying the tax type'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
tax_type_descr_en STRING(250) OPTIONS(description='Text describing the tax code (in English)'),
tax_type_descr_de STRING(250) OPTIONS(description='Text describing the tax code (in German)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (tax_type_cd, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the tax types');