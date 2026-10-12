CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_0rt_wrf3_attr_hist (
client_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(20),
werks STRING(20) NOT NULL,
matkl STRING(20) NOT NULL,
loclb STRING(20) NOT NULL,
datab DATE NOT NULL,
datbi DATE NOT NULL,
prioritaet BIGNUMERIC(38,0),
odq_changemode STRING(20),
odq_entitycntr NUMERIC(18,5),
deleted_fg BIGNUMERIC(38,0),
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0),
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id, werks, matkl, loclb, datab, datbi, dwh_valid_from) NOT ENFORCED
);