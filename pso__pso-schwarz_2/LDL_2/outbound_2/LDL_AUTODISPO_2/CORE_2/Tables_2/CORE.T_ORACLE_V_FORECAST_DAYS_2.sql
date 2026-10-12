CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_forecast_days_2 (
country_2 STRING(16777216),
forecast_days BIGNUMERIC(38,0),
mod_date DATETIME,
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
) CLUSTER BY country_2;