CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_excluded_1 (
ex_to_time_id STRING(16777216),
mod_date DATETIME,
country_1 STRING(16777216),
ex_from_time_id STRING(16777216),
ex_item_nr STRING(16777216),
ex_store_nr STRING(16777216),
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
deleted BIGNUMERIC(38,10),
date_from DATE,
date_to DATE
) CLUSTER BY country_1;