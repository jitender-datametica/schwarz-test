CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_client_config_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
country_lidl_cd STRING(20) COLLATE 'und:ci' NOT NULL,
client_name STRING(100) COLLATE 'und:ci' NOT NULL,
ai_timezone STRING(100) COLLATE 'und:ci',
sales_gross_fg BIGNUMERIC(38,0) NOT NULL,
PRIMARY KEY (client_id) NOT ENFORCED
);