/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WAREHOUSE_PROCESS_TYPE
   GENERATED FROM POWERDESIGNER ON Donnerstag, 7. Juli 2022 16:47:07
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_warehouse_process_type (
wh_process_type_cd STRING(5) NOT NULL OPTIONS(description='The code for warehouse process type (2010, 2011, etc)'),
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
wh_cd STRING(5) OPTIONS(description='A short unique code for the warehouses which receives the deliveries'),
wh_process_type_descr STRING(250) NOT NULL
OPTIONS(description='The description for warehouse process type (Normal picking , Mix-Picking)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_process_type_cd, wh_sid) NOT ENFORCED
)
OPTIONS(description='The minor dimension defines warehouse process type, which groups tasks with the same picking process. "2010" (= Normal picking), "2011" (=Mix-Picking), "2013" (=Picking again/Nachkommisionierung)');