CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_dim_item_1 (
country_1 STRING(16777216),
item_nr STRING(16777216),
item_name STRING(16777216),
item_group_nr STRING(16777216),
item_sub_group STRING(16777216),
item_sub_group_nr STRING(16777216),
item_family_group_nr STRING(16777216),
item_family_group STRING(16777216),
item_rlz_supplier BIGNUMERIC(38,10),
item_rlz_store BIGNUMERIC(38,10),
item_rlz_warehouse BIGNUMERIC(38,10),
mod_date DATETIME,
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);