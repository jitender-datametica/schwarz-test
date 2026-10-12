CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_goods_movement_category (
goods_mov_cat_cd STRING(10) NOT NULL
OPTIONS(description='The code which identifies the reason why a product is moved in or out of the warehouse. E.g. delivery to a customer, return to a supplier, movement to another warehouse, ...'),
goods_mov_cat_group_cd STRING(10)
OPTIONS(description='The code which identifies the reason why a product is moved in or out of the warehouse. E.g. delivery to a customer, return to a supplier, movement to another warehouse, ...'),
goods_mov_cat_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the reason why a product is moved out of the warehouse. E.g. delivery to a customer, return to a supplier, movement to another warehouse, ...'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (goods_mov_cat_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the reasons why a product is moved in or out of the warehouse. E.g. delivery to a customer, return to a supplier, movement to another warehouse, ...');