CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_goods_movement_category_group_1 (
goods_mov_cat_group_cd STRING(10) NOT NULL
OPTIONS(description='The code which identifies the type of the warehouse movement (IN , OUT or RET (return) )'),
goods_mov_cat_group_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the type of the warehouse movement (IN , OUT or RET (return) )'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (goods_mov_cat_group_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the type of the warehouse movement (IN , OUT or RET (return) )');