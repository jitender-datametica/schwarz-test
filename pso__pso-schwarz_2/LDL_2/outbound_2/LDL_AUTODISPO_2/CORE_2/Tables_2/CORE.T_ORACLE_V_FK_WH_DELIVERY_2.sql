CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_wh_delivery_2 (
country_2 STRING(16777216),
wdel_time_id STRING(16777216),
wdel_wh_nr STRING(16777216),
wdel_item_nr STRING(16777216),
wdel_packagecapacity STRING(16777216),
wdel_amount BIGNUMERIC(38,10),
mod_date DATETIME,
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);