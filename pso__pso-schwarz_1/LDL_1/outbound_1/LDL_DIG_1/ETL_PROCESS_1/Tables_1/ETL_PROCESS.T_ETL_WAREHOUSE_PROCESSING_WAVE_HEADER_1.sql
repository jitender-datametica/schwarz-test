/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_WAVE_HEADER_1
   GENERATED FROM POWERDESIGNER ON Freitag, 19. August 2022 12:25:51
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_processing_wave_header_1 (
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier(surrogate key) of  warehouse'),
wh_cd STRING(5) OPTIONS(description='Warehouse code'),
wave_id BIGNUMERIC NOT NULL OPTIONS(description='Wave Identifier'),
wave_fg BOOL OPTIONS(description='Wave Flag'),
wave_header_status STRING(2) OPTIONS(description='Wave header status_1'),
wavecat_cd STRING(20) OPTIONS(description='Wave Cat Code '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_sid, wave_id) NOT ENFORCED
) OPTIONS(description='ETL  table to support T_FACT_WAREHOUSE_PROCESSING_1');