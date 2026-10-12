CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_optimization_all_1 (
country_1 STRING(250),
opt_time_id BIGNUMERIC(38,0),
opt_storecalculation_id BIGNUMERIC(38,0),
opt_order_type STRING(250),
opt_item_nr STRING(250),
opt_store_nr BIGNUMERIC(38,0),
opt_type_name STRING(250),
opt_before BIGNUMERIC(38,0),
opt_after BIGNUMERIC(38,0),
mod_date DATETIME,
deleted INTEGER,
source_extraction_tmsp TIMESTAMP,
snflk_insert_tmsp TIMESTAMP,
snflk_update_tmsp TIMESTAMP,
opt_unit_id BIGNUMERIC(38,0),
date_ DATE
) CLUSTER BY date_, country_1, opt_order_type;