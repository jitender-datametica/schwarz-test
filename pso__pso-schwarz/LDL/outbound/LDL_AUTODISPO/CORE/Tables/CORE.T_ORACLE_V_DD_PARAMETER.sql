CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_dd_parameter (
country STRING(16777216),
param_value STRING(16777216),
param_name STRING(16777216),
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);