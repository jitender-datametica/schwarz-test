CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_stock_1 (
stock_loc_id STRING(16777216),
country_1 STRING(16777216),
stock_item_nr STRING(16777216),
stock_quantity BIGNUMERIC(38,2),
mod_date DATETIME,
stock_time_id STRING(16777216),
stock_ware_id STRING(16777216),
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);