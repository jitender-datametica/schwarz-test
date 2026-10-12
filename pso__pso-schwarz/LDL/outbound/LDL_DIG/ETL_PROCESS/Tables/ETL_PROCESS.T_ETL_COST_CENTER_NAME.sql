/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_COST_CENTER_NAME
   GENERATED FROM POWERDESIGNER ON Freitag, 10. Februar 2023 11:37:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_cost_center_name (
language_cd STRING(5) NOT NULL OPTIONS(description='Code to identify the language of the names'),
cost_center_nr STRING(20) NOT NULL OPTIONS(description='Identifier of the Cost Center'),
cc_valid_to_dt DATE NOT NULL OPTIONS(description='The date until which this Cost Center can be used in bookings'),
short_name STRING(100) OPTIONS(description='Short description of the Cost Center'),
long_name STRING(100) OPTIONS(description='Long description of the Cost Center'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (language_cd, cost_center_nr, cc_valid_to_dt) NOT ENFORCED
) OPTIONS(description='Table that contains the description in English and in German of the cost centers.');