CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_dic_area_1 (
dic_area_nr BIGNUMERIC(38,10),
dic_active BIGNUMERIC(38,10),
dic_area_id BIGNUMERIC(38,10),
dic_area_name STRING(16777216),
country_1 STRING(16777216),
mod_date DATETIME,
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);