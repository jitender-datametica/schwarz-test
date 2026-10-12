/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_HANDLING_UNIT_2
   GENERATED FROM POWERDESIGNER ON Freitag, 19. August 2022 09:58:36
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_processing_handling_unit_2 (
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier(surrogate key) of  warehouse'),
wh_cd STRING(5) OPTIONS(description='Warehouse code'),
hu_id STRING(64) NOT NULL OPTIONS(description='Identifier'),
sort_trolley_name STRING(40) OPTIONS(description='Identifier'),
wsbin STRING(36) OPTIONS(description='Identifier'),
wtconf_cd TIMESTAMP OPTIONS(description='Timestamp'),
aqua_huident_cd STRING(40) OPTIONS(description='Identifier'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_sid, hu_id) NOT ENFORCED
) OPTIONS(description='ETL  table to support T_FACT_WAREHOUSE_PROCESSING_2');