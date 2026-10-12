CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_z_ds_tcurr_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(20),
fcurr STRING(20) NOT NULL,
tcurr STRING(20) NOT NULL,
kurst STRING(20) NOT NULL,
gdatu DATE NOT NULL,
ukurs NUMERIC(18,5),
active_from_dt DATE NOT NULL,
deleted_fg BIGNUMERIC(38,0),
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id, fcurr, tcurr, kurst, gdatu, active_from_dt, dwh_valid_from) NOT ENFORCED
);