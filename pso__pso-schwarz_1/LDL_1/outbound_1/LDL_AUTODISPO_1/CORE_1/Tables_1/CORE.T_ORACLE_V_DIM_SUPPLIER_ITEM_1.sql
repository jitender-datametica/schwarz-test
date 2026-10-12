CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_dim_supplier_item_1 (
country_1 STRING(16777216),
item_nr STRING(16777216),
item_packagecapacity BIGNUMERIC(38,0),
supplier_nr STRING(16777216),
subsupplier_name STRING(16777216),
supplier_wh BIGNUMERIC(38,0),
rounding BIGNUMERIC(38,0),
offsetparameter BIGNUMERIC(38,0),
ironreserve BIGNUMERIC(38,0),
mod_date DATETIME,
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
active INTEGER
) CLUSTER BY country_1;