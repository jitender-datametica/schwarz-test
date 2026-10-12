CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_map_price_groups_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(20) NOT NULL,
prcs_grp_cd STRING(20) NOT NULL,
lang_cd STRING(20) NOT NULL,
prcs_grp_descr STRING(100) NOT NULL,
deleted_fg BIGNUMERIC(38,0),
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id, prcs_grp_cd, dwh_valid_from) NOT ENFORCED
);