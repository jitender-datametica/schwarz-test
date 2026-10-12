CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_ptm_bookingtype_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
bookingtype_id STRING(1) COLLATE 'und:ci' NOT NULL,
bookingtype_desc STRING(20) COLLATE 'und:ci',
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);