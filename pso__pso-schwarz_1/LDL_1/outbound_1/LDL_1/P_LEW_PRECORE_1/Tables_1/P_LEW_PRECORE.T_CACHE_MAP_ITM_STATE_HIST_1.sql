CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_map_itm_state_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(20),
itm_state_bges_id STRING(20) NOT NULL,
itm_state_descr STRING(100) NOT NULL,
mis_itm_state_id BIGNUMERIC(38,0) NOT NULL,
mis_state_descr STRING(1000) NOT NULL,
deleted_fg BIGNUMERIC(38,0),
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id, itm_state_bges_id, dwh_valid_from) NOT ENFORCED
);