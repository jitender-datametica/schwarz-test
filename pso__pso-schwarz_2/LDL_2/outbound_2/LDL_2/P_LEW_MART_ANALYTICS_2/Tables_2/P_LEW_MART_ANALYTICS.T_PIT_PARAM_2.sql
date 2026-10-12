CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_pit_param_2 (
param_id BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
param_name STRING(100) COLLATE 'und:ci',
param_value STRING(250) COLLATE 'und:ci'
);