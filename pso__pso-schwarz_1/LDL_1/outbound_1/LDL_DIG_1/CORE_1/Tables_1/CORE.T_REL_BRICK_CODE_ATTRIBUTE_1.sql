/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_BRICK_CODE_ATTRIBUTE_1
   GENERATED FROM POWERDESIGNER ON Freitag, 12. August 2022 12:25:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_rel_brick_code_attribute_1 (
attr_cd STRING(50) NOT NULL
OPTIONS(description='A brickcode_attribute has an internal and an external code.It is a numeric code that identifies the attribute.            The external code is the attribute code.'),
prod_brick_cd STRING(10) NOT NULL
OPTIONS(description='The Brickcode is a unique standardized code of all categories in the GS1 article categorization system on level 4 and is maintained for every article in SAP. '),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
attr_descr STRING(250) OPTIONS(description='Name of the brickcode attribute. Eg: Target Gender'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (attr_cd, prod_brick_cd, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the list of brickcode attributes that has internal and external codes');