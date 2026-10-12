/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WAREHOUSE_PROCESSING_EXCEPTION_2
   GENERATED FROM POWERDESIGNER ON Montag, 15. Juli 2024 15:34:14
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_warehouse_processing_exception_2 (
wh_processing_exception_cd STRING(5) NOT NULL
OPTIONS(description='This code describes exceptions which took place during processing of the warehouse task because of unexpected issues. (e.g. ZHBD)'),
wh_processing_exception_descr STRING(250) NOT NULL
OPTIONS(description='The description for warehouse processing exception (e.g. Change Destination Bin and storage type)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_processing_exception_cd) NOT ENFORCED
)
OPTIONS(description='The minor dimension defines exceptions which can take place during processing of a warehouse task because of unexpected issues. (e.g. ZHBD = Change Destination Bin and storage type - this code can be chosen whenever the destination for a putaway task had to be changed because the initially chosen shelf was broken/dirty, etc.)');