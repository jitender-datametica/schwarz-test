/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_CURRENT_WAVE_ITEM_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 19. März 2024 11:28:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_processing_current_wave_item_2 (
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier(surrogate key) of  warehouse'),
rdoc_id STRING(64) NOT NULL OPTIONS(description='Identifier'),
ritm_id STRING(64) NOT NULL OPTIONS(description='Identifier'),
wh_order_pos_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique surrogate key within the DWH for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement. (generated from itemid + sap_client_id + sap_sys_name from the source)'),
src_wh_order_pos_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement (itemid in the source system).'),
src_wh_order_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)'),
wave_id BIGNUMERIC NOT NULL OPTIONS(description='Wave Identifier'),
wave_pos_nr STRING(10) NOT NULL OPTIONS(description='wave position number'),
wh_cd STRING(5) OPTIONS(description='Warehouse code'),
wave_error STRING(2) OPTIONS(description='wave error'),
wh_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (sk) for warehouse order'),
wh_order_pos_nr BIGNUMERIC OPTIONS(description='The particular position number of a position in an order'),
max_wave_qty BIGNUMERIC(38,5) OPTIONS(description='The maximum wave item_2 quantity'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_sid, rdoc_id, ritm_id) NOT ENFORCED
) OPTIONS(description='ETL  table to support T_FACT_WAREHOUSE_PROCESSING_2');