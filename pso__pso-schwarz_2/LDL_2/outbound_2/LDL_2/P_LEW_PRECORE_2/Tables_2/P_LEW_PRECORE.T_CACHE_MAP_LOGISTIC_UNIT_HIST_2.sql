CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_map_logistic_unit_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(20),
uom_id STRING(20) NOT NULL,
logistic_unit_cd BIGNUMERIC(38,0) NOT NULL,
deleted_fg BIGNUMERIC(38,0),
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id, uom_id, dwh_valid_from) NOT ENFORCED
);