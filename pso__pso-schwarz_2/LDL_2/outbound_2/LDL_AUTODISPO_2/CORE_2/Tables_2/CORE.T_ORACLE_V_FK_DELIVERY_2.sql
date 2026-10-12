CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_delivery_2 (
del_packagecapacity BIGNUMERIC(38,10),
mod_date DATETIME,
del_time_id BIGNUMERIC(38,10),
del_item_nr STRING(16777216),
del_store_nr BIGNUMERIC(38,10),
del_amount BIGNUMERIC(38,10),
country_2 STRING(16777216),
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);