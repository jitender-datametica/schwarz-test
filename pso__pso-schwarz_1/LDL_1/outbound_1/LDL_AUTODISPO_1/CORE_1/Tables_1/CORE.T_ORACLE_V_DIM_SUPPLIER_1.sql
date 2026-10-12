CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_dim_supplier_1 (
country_1 STRING(16777216),
supplier_nr STRING(16777216),
supplier_name STRING(16777216),
supplier_shortname STRING(16777216),
supplier_country STRING(16777216),
intbuycountry STRING(16777216),
supplier_wh BIGNUMERIC(38,0),
ma BIGNUMERIC(38,0),
mod_date DATETIME,
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);