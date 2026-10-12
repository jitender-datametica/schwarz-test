CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_scope_country_param_backup_after (
param_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
dwh_valid_from DATE DEFAULT DATE '1900-01-01' NOT NULL,
dwh_valid_to DATE DEFAULT DATE '9999-12-31' NOT NULL,
version_nr BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
param_name STRING(16777216) DEFAULT 'N/A',
param_value BIGNUMERIC(38,5) DEFAULT 0,
param_value_char STRING(16777216),
deleted_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
current_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
dwh_created DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL,
dwh_updated DATETIME,
PRIMARY KEY (param_id, client_id, dwh_valid_from, version_nr) NOT ENFORCED
);