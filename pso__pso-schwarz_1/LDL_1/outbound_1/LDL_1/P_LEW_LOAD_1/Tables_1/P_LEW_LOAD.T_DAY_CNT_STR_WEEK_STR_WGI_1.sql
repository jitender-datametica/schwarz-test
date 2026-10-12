CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_day_cnt_str_week_str_wgi_1 (
client_id BIGNUMERIC(38) NOT NULL,
move_to_store_id BIGNUMERIC(38) NOT NULL,
dat_formdate DATE NOT NULL,
aspect_id BIGNUMERIC(38),
currency_iso_cd STRING(3) COLLATE 'und:ci',
itemgroup_int_id BIGNUMERIC(38),
cnt_day_store NUMERIC(18,4),
load_ts DATETIME
);