CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_sys_revision_load_store_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
orig_store_nr BIGNUMERIC(38,0),
dat_formdate_from DATE NOT NULL,
dat_formdate_until DATE NOT NULL,
load_in_progress_fg BIGNUMERIC(38,0) NOT NULL
);