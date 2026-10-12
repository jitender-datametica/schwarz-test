CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_map_itm_missing_state_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(20),
itm_state_bges_id STRING(20) NOT NULL,
itm_missing_state STRING(100) NOT NULL,
itm_missing_reason_cd STRING(20),
item_status_pp_mis STRING(100) NOT NULL,
end_cd_pp_mis STRING(20) NOT NULL,
deleted_fg BIGNUMERIC(38,0),
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id, itm_state_bges_id, itm_missing_state, dwh_valid_from) NOT ENFORCED
);