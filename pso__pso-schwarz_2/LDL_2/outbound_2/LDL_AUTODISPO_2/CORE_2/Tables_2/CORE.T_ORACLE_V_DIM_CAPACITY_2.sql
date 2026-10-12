CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_dim_capacity_2 (
cap_store_nr BIGNUMERIC(38,10),
cap_quantity STRING(16777216),
mod_date DATETIME,
cap_item_nr STRING(16777216),
cap_unit_id BIGNUMERIC(38,10),
cap_packagecapacity BIGNUMERIC(38,10),
country_2 STRING(16777216),
deleted BIGNUMERIC(38,10),
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);