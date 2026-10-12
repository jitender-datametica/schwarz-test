CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_order_item_category_1 (
order_item_category_cd STRING(5) NOT NULL OPTIONS(description='The code to uniquely identify the order item_1 categories'),
order_item_category_descr STRING(250) NOT NULL
OPTIONS(description='The description for the categorization of sales_1 and delivery order items'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (order_item_category_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines categorization of sales_1 order and delivery order items');