/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WAREHOUSE_2
   GENERATED FROM POWERDESIGNER ON Montag, 26. September 2022 16:30:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_warehouse_2 (
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
wh_cd STRING(5) NOT NULL OPTIONS(description='A short unique code for the warehouses which receives the deliveries'),
wh_name STRING(100) OPTIONS(description='The name by which the warehouse is known.'),
wh_type_cd STRING(5)
OPTIONS(description='The code forthe type for the warehouse (Außenlager, Versandlager, Zwischenlager)'),
wh_storage_type_cd STRING(5) OPTIONS(description='The code for the type of warehouse storage ((KK,GT ...)'),
is_run_by_ext_company BOOL
OPTIONS(description='Flag shows is warehouse run by external company  (there is no difference between internal / external run companies, only necessary for top mgmt reporting)'),
is_wine_storage_fg BOOL
OPTIONS(description='Flag shows if the warehouse stores wine&spirits(Großbeeren currently is GT + Wein)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (wh_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A warehouse is a physical building which is used for storing and trans-shipping goods. In many cases it is also the home of the associated sales_2 organization');