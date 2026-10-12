CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_param (
param_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
dwh_valid_from DATE DEFAULT DATE '1900-01-01' NOT NULL,
dwh_valid_to DATE DEFAULT DATE '9999-12-31' NOT NULL,
param_name STRING(16777216),
param_value STRING(16777216)
);