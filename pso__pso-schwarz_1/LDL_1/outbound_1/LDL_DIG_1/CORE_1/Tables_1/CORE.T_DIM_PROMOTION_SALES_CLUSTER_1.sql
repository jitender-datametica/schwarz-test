CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_promotion_sales_cluster_1 (
promo_sale_cluster_cd BIGNUMERIC NOT NULL
OPTIONS(description='A code for aggregation of sales_1 orders assigned to a promotion based on the customer order date'),
promo_sale_cluster_descr STRING(250)
OPTIONS(description='A description for aggregation of sales_1 orders assigned to a promotion based on the customer order date'),
last_week_nr BIGNUMERIC
OPTIONS(description='The last week number connected to promo sale cluster code e.g cluster 1,2,3 are part of week 1'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (promo_sale_cluster_cd) NOT ENFORCED
) OPTIONS(description='A minor dimension that defines clustering for sales_1 analysis during promotion');