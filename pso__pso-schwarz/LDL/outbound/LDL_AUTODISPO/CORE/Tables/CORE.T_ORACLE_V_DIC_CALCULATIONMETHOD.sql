CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_dic_calculationmethod (
country STRING(16777216),
calculationmethod BIGNUMERIC(38,10),
calculationmethod_name STRING(16777216),
mod_date DATE,
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);