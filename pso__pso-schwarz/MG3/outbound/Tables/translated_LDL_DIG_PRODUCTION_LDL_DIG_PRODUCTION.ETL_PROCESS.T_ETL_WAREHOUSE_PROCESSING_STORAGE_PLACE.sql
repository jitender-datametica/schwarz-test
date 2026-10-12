CREATE OR REPLACE TABLE ldl_dig_production_etl_process.t_etl_warehouse_processing_storage_place (
wh_sid INTEGER NOT NULL OPTIONS(description='The unique identifier(surrogate key) of  warehouse'),
wh_cd STRING(5) OPTIONS(description='Warehouse code'),
gu_id_parent STRING(100) NOT NULL OPTIONS(description='GU Identifier'),
storage_place_lgpla STRING(20) OPTIONS(description='Storage Place'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_sid, gu_id_parent) NOT ENFORCED
) OPTIONS(description='ETL  table to support T_FACT_WAREHOUSE_PROCESSING');