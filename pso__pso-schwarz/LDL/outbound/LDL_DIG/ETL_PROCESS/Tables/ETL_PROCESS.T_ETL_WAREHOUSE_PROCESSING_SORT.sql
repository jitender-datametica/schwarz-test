/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_SORT
   GENERATED FROM POWERDESIGNER ON Freitag, 19. August 2022 12:30:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_processing_sort (
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier(surrogate key) of  warehouse'),
wh_cd STRING(5) OPTIONS(description='lgnum '),
sort_station STRING(100) NOT NULL OPTIONS(description='Sort station name'),
sort_shelf STRING(100) NOT NULL OPTIONS(description='Sort shelf'),
sap_sys_name STRING(100) OPTIONS(description='SAP System Name'),
sap_client_id STRING(100) OPTIONS(description='SAP Client Identifier'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_sid, sort_station, sort_shelf) NOT ENFORCED
) OPTIONS(description='ETL  table to support t_fact_warehouse_processing');