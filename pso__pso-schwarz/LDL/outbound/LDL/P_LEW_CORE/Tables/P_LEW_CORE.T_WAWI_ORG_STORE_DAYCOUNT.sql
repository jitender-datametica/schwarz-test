CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_org_store_daycount (
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
dat_last_update DATE,
art_data_fg BIGNUMERIC(38,0) NOT NULL,
ejr_data_fg BIGNUMERIC(38,0) NOT NULL,
txj_data_fg BIGNUMERIC(38,0) NOT NULL,
wawi_data_fg BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
) CLUSTER BY dat_formdate;