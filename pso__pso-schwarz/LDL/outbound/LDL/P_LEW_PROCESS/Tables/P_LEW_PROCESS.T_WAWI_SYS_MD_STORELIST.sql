CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_wawi_sys_md_storelist (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
dat_open DATE NOT NULL,
dat_dayend DATE NOT NULL,
timestamp_fn DATETIME NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);