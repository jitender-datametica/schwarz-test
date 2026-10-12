/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_PROMOTION_SALES_CLUSTER_WEEK_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 26. Juli 2022 14:12:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_rel_promotion_sales_cluster_week_1 (
promo_sale_cluster_cd BIGNUMERIC NOT NULL
OPTIONS(description='A code for aggregation of sales_1 orders assigned to a promotion based on the customer order date'),
week_nr BIGNUMERIC NOT NULL
OPTIONS(description='The week number connected to promo sale cluster code e.g cluster 1,2,3 are part of week 1'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (promo_sale_cluster_cd, week_nr) NOT ENFORCED
) OPTIONS(description='The relation table for the promotion sales_1 cluster to the corresponding week');