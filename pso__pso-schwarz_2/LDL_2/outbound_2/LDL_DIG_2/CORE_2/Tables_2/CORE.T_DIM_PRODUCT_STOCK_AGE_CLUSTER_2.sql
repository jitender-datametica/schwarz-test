CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_stock_age_cluster_2 (
prod_stock_age_cluster_cd STRING(5) NOT NULL
OPTIONS(description='A code for aggregation of product stock into age clusters to define how long products have been stored in our warehouse.'),
prod_stock_age_cluster_descr STRING(250)
OPTIONS(description='A description for aggregation of product stock into age clusters.'),
cluster_first_day BIGNUMERIC OPTIONS(description='Minimum day of the cluster'),
cluster_last_day BIGNUMERIC OPTIONS(description='Maximum day of the cluster'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_stock_age_cluster_cd) NOT ENFORCED
)
OPTIONS(description='A minor dimension that defines age cluster buckets.The age clusters are defining how long products have been stored in our warehouse. Based on this clusters the departments are able to tell for how long products are laying in our warehouse and whats the total amount of products in a cluster.');