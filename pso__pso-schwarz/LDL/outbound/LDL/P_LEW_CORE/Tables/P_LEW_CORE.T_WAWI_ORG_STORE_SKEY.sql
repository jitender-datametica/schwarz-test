CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_org_store_skey (
client_id BIGNUMERIC(38,0) NOT NULL,
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
orig_store_nr BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);