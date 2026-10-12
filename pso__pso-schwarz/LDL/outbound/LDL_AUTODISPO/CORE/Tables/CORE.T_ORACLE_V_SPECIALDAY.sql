CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_specialday (
country STRING(16777216),
sp_day DATE,
store BIGNUMERIC(38,0),
reports BIGNUMERIC(38,0),
mod_date DATETIME,
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
) CLUSTER BY country;