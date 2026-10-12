CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_dispo_range_store (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
order_area_cd BIGNUMERIC(38,0),
range_group BIGNUMERIC(38,0),
range_zone_id BIGNUMERIC(38,0),
dat_days STRING(7) COLLATE 'und:ci',
range_fg BIGNUMERIC(38,0),
range_dbl_fg BIGNUMERIC(38,0),
active_int_fg BIGNUMERIC(38,0),
dat_dayend DATE,
load_id BIGNUMERIC(38,0) NOT NULL
);