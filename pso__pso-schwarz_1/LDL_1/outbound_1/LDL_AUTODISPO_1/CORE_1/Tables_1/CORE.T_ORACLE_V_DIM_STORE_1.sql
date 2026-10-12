CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_dim_store_1 (
store_address STRING(16777216),
store_so_id BIGNUMERIC(38,10),
mod_date DATETIME,
store_open_day DATE,
store_nr BIGNUMERIC(38,10),
store_wh BIGNUMERIC(38,10),
country_1 STRING(16777216),
store_size BIGNUMERIC(38,10),
store_type STRING(16777216),
store_close_day DATE,
store_active BIGNUMERIC(38,10),
deleted BIGNUMERIC(38,10),
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);