CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_to_count_1 (
country_1 STRING(250),
store BIGNUMERIC(38,0),
item_nr STRING(250),
itemdesc STRING(250),
countingdate DATETIME,
orderarea BIGNUMERIC(38,0),
reason STRING(250),
mod_date DATETIME,
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);