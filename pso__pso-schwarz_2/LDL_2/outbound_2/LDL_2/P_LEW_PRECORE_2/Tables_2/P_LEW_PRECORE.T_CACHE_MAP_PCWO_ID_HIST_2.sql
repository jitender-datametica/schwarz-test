CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_map_pcwo_id_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(20),
pcwo_reason_id BIGNUMERIC(38,0) NOT NULL,
mov_type_cd STRING(20) NOT NULL,
mov_reason_cd STRING(20) NOT NULL,
mov_reason_descr STRING(100) NOT NULL,
deleted_fg BIGNUMERIC(38,0),
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id, mov_type_cd, mov_reason_cd, dwh_valid_from) NOT ENFORCED
);