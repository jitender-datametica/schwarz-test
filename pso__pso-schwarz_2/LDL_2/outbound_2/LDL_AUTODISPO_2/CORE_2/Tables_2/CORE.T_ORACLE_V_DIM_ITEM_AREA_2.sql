CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_dim_item_area_2 (
country_2 STRING(250),
area_wh_nr BIGNUMERIC(38,0),
area_item_nr STRING(250),
area_nr BIGNUMERIC(38,0),
area_packagecapacity BIGNUMERIC(38,10),
area_active BIGNUMERIC(38,0),
mod_date DATETIME,
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);