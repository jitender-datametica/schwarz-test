/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CONTROLLING_AREA
   GENERATED FROM POWERDESIGNER ON Freitag, 24. Februar 2023 12:02:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_controlling_area (
ctrl_area_cd STRING(5) NOT NULL OPTIONS(description='A unique identifier of the Controlling Area'),
ctrl_area_descr STRING(250) OPTIONS(description='Description of the Controlling Area'),
chart_of_accounts_cd STRING(5) OPTIONS(description='Unique Identifier of the Chart of Accounts'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (ctrl_area_cd) NOT ENFORCED
)
OPTIONS(description='A minor dimension that contains one row for ever controlling area used in accounting by Lidl compnaies');