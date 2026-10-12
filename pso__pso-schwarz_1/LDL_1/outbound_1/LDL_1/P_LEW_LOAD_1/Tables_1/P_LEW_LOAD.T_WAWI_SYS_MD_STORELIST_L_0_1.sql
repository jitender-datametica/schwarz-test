CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_sys_md_storelist_l_0_1 (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id BIGNUMERIC(38) NOT NULL,
orig_store_nr BIGNUMERIC(38) NOT NULL,
dat_open DATE NOT NULL,
dat_dayend DATE NOT NULL,
timestamp_fn DATETIME NOT NULL,
load_id BIGNUMERIC(38) NOT NULL,
dc_server_id BIGNUMERIC(38) NOT NULL
);