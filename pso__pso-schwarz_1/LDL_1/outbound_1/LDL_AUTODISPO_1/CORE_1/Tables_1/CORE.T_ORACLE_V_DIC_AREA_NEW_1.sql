CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_dic_area_new_1 (
dic_area_id NUMERIC(18,1),
dic_active NUMERIC(18,1),
mod_date DATETIME,
dic_area_nr BIGNUMERIC(38,10),
dic_area_wh BIGNUMERIC(38,10),
country_1 STRING(16777216),
dic_area_name STRING(16777216),
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);