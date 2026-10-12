CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_map_deliv_type_mov_type_2_cache_map_deliv_type_mov_type_hist_2 (
record_id INTEGER,
client_id BIGNUMERIC(38),
bic_zmlila STRING(20),
order_type_cd STRING(20),
mov_type_cd STRING(20),
deliv_type_cd BIGNUMERIC(38),
deleted_fg BIGNUMERIC(38),
dwh_valid_from DATE,
dwh_valid_to DATE,
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);