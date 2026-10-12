CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_stock_webshop_allocation_daily_2 (
wshop_cd STRING(5) OPTIONS(description='The unique code for the Lidl webshop'),
sale_promo_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='A unique key from sales_2 promotion line'),
prod_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for the product'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
tgt_sales_cnt BIGNUMERIC(38,0) OPTIONS(description='Amount of goods meant to be sold'),
sale_dt DATE,
alloc_promo_class_cd STRING(5)
OPTIONS(description='The code for the indicating if product  is a part of a promotion or main assortment.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (sale_promo_id, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='The etl table to support t_fact_stock_webshop_allocation_daily , created from excel');