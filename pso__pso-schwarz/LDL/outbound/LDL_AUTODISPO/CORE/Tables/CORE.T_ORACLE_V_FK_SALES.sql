CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_sales (
mod_date DATETIME,
sales_quantity BIGNUMERIC(38,10),
sales_time_id BIGNUMERIC(38,10),
sales_value BIGNUMERIC(38,10),
sales_price BIGNUMERIC(38,10),
sales_receipt_nr STRING(16777216),
deleted BIGNUMERIC(38,10),
sales_item_nr STRING(16777216),
sales_store_nr BIGNUMERIC(38,10),
country STRING(16777216),
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
date_ DATE
) CLUSTER BY date_, country;