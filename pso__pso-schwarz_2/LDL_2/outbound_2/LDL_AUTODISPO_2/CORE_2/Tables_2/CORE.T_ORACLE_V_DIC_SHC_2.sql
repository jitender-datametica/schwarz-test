CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_dic_shc_2 (
shc_unit_name STRING(16777216),
mod_date DATETIME,
shc_unit_id BIGNUMERIC(38,10),
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);