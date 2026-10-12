/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WAREHOUSE_STORAGE_TYPE
   GENERATED FROM POWERDESIGNER ON Montag, 26. September 2022 16:29:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_warehouse_storage_type (
wh_storage_type_cd STRING(5) NOT NULL OPTIONS(description='The code for the type of warehouse storage ((KK,GT ...)'),
wh_storage_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the type for the warehouse storage (KK = small items warehouse,GT = large items warehouse)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_storage_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the storage type for the warehouse (KK = small items warehouse,GT = large items warehouse,Wein = wine & spririts)');