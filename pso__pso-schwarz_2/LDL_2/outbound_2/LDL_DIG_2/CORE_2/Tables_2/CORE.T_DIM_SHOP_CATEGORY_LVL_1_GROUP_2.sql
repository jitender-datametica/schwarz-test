CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_shop_category_lvl_1_group_2 (
shop_category_lvl_1_group_name STRING(40) NOT NULL
OPTIONS(description='The code for the product size type (\'Kleines Kleinteil\',\'Großteil\'	, etc)'),
shop_category_lvl_1_group_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the  product  size type  in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (shop_category_lvl_1_group_name) NOT ENFORCED
)
OPTIONS(description='The additional grouping derived from shop category level 1  (\'Bücher & Medien\',\'Gesundheit & Pflege\',\'Lebensmittel & Drogerie\' ,\'Tierwelt\', etc)');