CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_scope_country_init_1 (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
dwh_valid_from DATE DEFAULT DATE '1900-01-01' NOT NULL,
dwh_valid_to DATE DEFAULT DATE '9999-12-31' NOT NULL,
deleted_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
dwh_created DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL,
dwh_updated DATETIME,
PRIMARY KEY (client_id, dwh_valid_from) NOT ENFORCED
);